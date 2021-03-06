<?php

use TMS\Tamara\Notification\NotificationService;
use TMS\Tamara\Request\Order\AuthoriseOrderRequest;

class ControllerExtensionPaymentTamarapay extends Controller
{
    const ORDER_STATUS_APPROVED = "approved";
    private const INDEX_TEMPLATE = "extension/payment/tamarapay";

    public function index()
    {
        $this->load->language('extension/payment/tamarapay');
        $this->load->model('extension/payment/tamarapay');

        //validate currency
        if (!$this->model_extension_payment_tamarapay->isCurrencySupported()) {
            return $this->renderIndexTemplate(['error_get_payment' => $this->language->get('error_wrong_currency')]);
        }
        $methods = $this->model_extension_payment_tamarapay->getPaymentMethodsForCheckoutPage();
        if (empty($methods)) {
            return $this->renderIndexTemplate(['error_get_payment' => $this->language->get('error_no_method_available')]);
        }
        $installmentMinLimit = 0;
        $totalTypeAvailable = 0;
        $paymentAvailableForCurrency = "";
        foreach ($methods as $method) {
            $paymentAvailableForCurrency = $method['currency'];
            if ($method['name'] == "PAY_BY_INSTALMENTS") {
                $installmentMinLimit = $method['min_limit'];
            }
            if ($method['is_available']) {
                $totalTypeAvailable++;
            }
        }
        $data['installment_min_limit'] = $installmentMinLimit;
        $data['methods'] = $methods;
        $data['total_method_available'] = $totalTypeAvailable;
        $data['use_iframe_checkout'] = false;
        $data['merchant_urls'] = $this->model_extension_payment_tamarapay->getMerchantUrls();
        $orderData = $this->model_extension_payment_tamarapay->getOrder( $this->model_extension_payment_tamarapay->getOrderIdFromSession());
        if (strtoupper($orderData['currency_code']) != $paymentAvailableForCurrency) {
            return $this->renderIndexTemplate(['error_get_payment' => $this->language->get('error_wrong_currency')]);
        }
        $data['order_data'] = $orderData;
        $data['language_code'] = $this->language->get('code');
        $data['current_time'] = time();
        return $this->renderIndexTemplate($data);
    }

    protected function renderIndexTemplate($data)
    {
        return $this->renderTemplate(self::INDEX_TEMPLATE, $data);
    }

    private function renderTemplate($template, $data)
    {
        return $this->load->view($template, $data);
    }

    public function send()
    {
        $this->load->language('extension/payment/tamarapay');
        $this->load->model('extension/payment/tamarapay');

        $error = [];

        if (!isset($this->request->post['payment_type'])) {
            $error = ['error' => $this->language->get('error_missing_payment_type')];
        }

        if (!empty($error)) {
            $this->response->addHeader('Content-Type: application/json');
            $this->response->setOutput(json_encode($error));
            return;
        }

        $response = $this->model_extension_payment_tamarapay->createCheckout(
            $this->request->post['payment_type']);

        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($response));
    }

    public function success()
    {
        $this->load->model('checkout/order');
        $this->load->language('extension/payment/tamarapay');
        $this->load->model('extension/payment/tamarapay');

        if (!isset($this->session->data['order_id'])) {
            $this->response->redirect($this->url->link('common/home', '', true));
        }

        $data['order_id'] = $this->session->data['order_id'];
        $tamaraOrder = $this->model_extension_payment_tamarapay->getTamaraOrder($data['order_id']);
        if (!$tamaraOrder['is_authorised']) {

            //set order status
            $successStatusId = $this->config->get('payment_tamarapay_order_status_success_id');
            $this->model_extension_payment_tamarapay->addOrderComment($this->session->data['order_id'], $successStatusId, "Tamara - Pay success", 0);

            //call authorise
            $this->model_extension_payment_tamarapay->authoriseOrder($tamaraOrder['tamara_order_id']);
        }

        if (!$this->config->get('payment_tamarapay_enable_tamara_checkout_success_page')) {
            $this->response->redirect($this->url->link('checkout/success', '', true));
        }

        //render success pay
        $this->document->setTitle($this->language->get('heading_title'));

        $data['breadcrumbs'] = array();

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_home'),
            'href' => $this->url->link('common/home')
        );

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_basket'),
            'href' => $this->url->link('checkout/cart')
        );

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_checkout'),
            'href' => $this->url->link('checkout/checkout', '', true)
        );

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_success'),
            'href' => $this->url->link('checkout/success')
        );

        if ($this->customer->isLogged()) {
            $data['text_message'] = sprintf($this->language->get('text_customer'),
                $this->url->link('account/account', '', true), $this->url->link('account/order', '', true),
                $this->url->link('account/download', '', true), $this->url->link('information/contact'));
        } else {
            $data['text_message'] = sprintf($this->language->get('text_guest'),
                $this->url->link('information/contact'));
        }

        $data['continue'] = $this->url->link('common/home');

        $data['column_left'] = $this->load->controller('common/column_left');
        $data['column_right'] = $this->load->controller('common/column_right');
        $data['content_top'] = $this->load->controller('common/content_top');
        $data['content_bottom'] = $this->load->controller('common/content_bottom');
        $data['footer'] = $this->load->controller('common/footer');
        $data['header'] = $this->load->controller('common/header');
        $this->clearCheckoutSession();

        $this->response->setOutput($this->load->view('extension/payment/tamarapay_success', $data));
    }

    private function clearCheckoutSession()
    {
        $this->cart->clear();

        unset($this->session->data['shipping_method']);
        unset($this->session->data['shipping_methods']);
        unset($this->session->data['payment_method']);
        unset($this->session->data['payment_methods']);
        unset($this->session->data['guest']);
        unset($this->session->data['comment']);
        unset($this->session->data['order_id']);
        unset($this->session->data['coupon']);
        unset($this->session->data['reward']);
        unset($this->session->data['voucher']);
        unset($this->session->data['vouchers']);
        unset($this->session->data['totals']);
    }

    public function failure()
    {
        $this->load->model('checkout/order');
        $this->load->model('extension/payment/tamarapay');
        $this->load->language('extension/payment/tamarapay');

        if (isset($this->session->data['order_id'])) {
            if (!$this->canCancelByRedirect($this->session->data['order_id'])) {
                return $this->response->redirect($this->url->link('checkout/cart', '', true));
            }
            $this->model_extension_payment_tamarapay->addOrderComment($this->session->data['order_id'], $this->config->get('payment_tamarapay_order_status_failure_id'), "Tamara - Pay failed", 0);
        }

        $this->session->data['error'] = $this->language->get('text_order_pay_failure');
        $this->response->redirect($this->url->link('checkout/cart', '', true));
    }

    public function cancel()
    {
        $this->load->model('checkout/order');
        $this->load->model('extension/payment/tamarapay');
        $this->load->language('extension/payment/tamarapay');
        if (isset($this->session->data['order_id'])) {
            if (!$this->canCancelByRedirect($this->session->data['order_id'])) {
                return $this->response->redirect($this->url->link('checkout/cart', '', true));
            }
            $this->model_extension_payment_tamarapay->addOrderComment($this->session->data['order_id'], $this->config->get('payment_tamarapay_order_status_canceled_id'), "Tamara - Pay canceled", 0);
        }

        $this->session->data['error'] = $this->language->get('text_order_canceled');
        $this->response->redirect($this->url->link('checkout/cart', '', true));
    }

    private function responseJson($response)
    {
        $this->response->addHeader('Content-Type: application/json');
        $this->response->setOutput(json_encode($response));
    }

    public function notification()
    {
        $this->load->language('extension/payment/tamarapay');
        $this->load->model('extension/payment/tamarapay');
        $this->load->model('checkout/order');

        $tokenNotification = $this->config->get('payment_tamarapay_token_notification');

        $notificationService = NotificationService::create($tokenNotification);
        try {
            $authorise = $notificationService->processAuthoriseNotification();
        } catch (Exception $exception) {
            $this->log("Error when processAuthoriseNotification: " . $exception->getMessage());
            $response = ['error' => $this->language->get('error_cannot_process_authorise_notification')];
            return $this->responseJson($response);
        }

        $orderId = $authorise->getOrderId();

        try {
            $tamaraOrder = $this->model_extension_payment_tamarapay->getTamaraOrderByTamaraOrderId($orderId);
        } catch (Exception $exception) {
            $this->log($exception->getMessage());
            $response = ['error' => $this->language->get('error_not_found_order')];
            return $this->responseJson($response);
        }

        if (!$tamaraOrder['is_authorised']) {
            $response = $this->model_extension_payment_tamarapay->authoriseOrder($orderId);
            $this->responseJson($response);
        }
    }

    public function webhook() {
        $this->log(['Start to webhook']);
        $response = ['status' => "success", 'success' => "Webhook processed"];
        try {
            $this->load->model('extension/payment/tamarapay');
            $this->model_extension_payment_tamarapay->webhook();
        } catch (\Exception $exception) {
            $this->log(["Error when execute webhook: " . $exception->getMessage()]);
            $response = ['status' => 'error', 'error' => $exception->getMessage()];
        }
        $this->log(['End Webhook']);
        return $this->responseJson($response);
    }

    public function log($data, $class_step = 6, $function_step = 6)
    {
        $this->load->model('extension/payment/tamarapay');
        $this->model_extension_payment_tamarapay->log($data, $class_step, $function_step);
    }

    public function handleOrderStatusChange($route, $args, $output)
    {
        $this->log(["Tamara - function handleOrderStatusChange"]);
        if ($this->config->get('payment_tamarapay_trigger_actions_enabled')) {
            try {
                $this->load->model('extension/payment/tamarapay');
                $orderId = $args[0];
                $statusId = $args[1];
                $this->log([
                    "event" => "handleOrderStatusChange",
                    "order id" => $orderId,
                    "status id" => $statusId
                ]);
                $tamaraOrder = $this->model_extension_payment_tamarapay->getTamaraOrder($orderId);
                if ($statusId == $this->config->get('payment_tamarapay_capture_order_status_id')) {
                    $this->log(["Tamara - handleOrderStatusChange - will go to capture, order id: " . $orderId . ", tamara order id: " . $tamaraOrder['tamara_order_id']]);
                    $this->model_extension_payment_tamarapay->captureOrder($tamaraOrder['tamara_order_id']);
                    return;
                }
                if ($statusId == $this->config->get('payment_tamarapay_cancel_order_status_id')) {
                    $this->log(["Tamara - handleOrderStatusChange - will go to cancel, order id: " . $orderId . ", tamara order id: " . $tamaraOrder['tamara_order_id']]);
                    $this->model_extension_payment_tamarapay->cancelOrder($tamaraOrder['tamara_order_id']);
                    return;
                }
                $this->log(["Tamara - handleOrderStatusChange - not processing, order id: " . $orderId . ", tamara order id: " . $tamaraOrder['tamara_order_id']]);
            } catch (\Exception $exception) {
                $this->log(["handleOrderStatusChange - Exception when capture or cancel order"]);
                $this->log($exception->getMessage());
            }
        } else {
            $this->log("Tamara trigger is disabled");
        }
    }

    public function addPromoWidgetForProduct($route, $data, $output) {
        $productId = $data['product_id'];
        $excludeProductIds = explode(",",$this->config->get('payment_tamarapay_pdp_wg_exclude_product_ids'));
        if (in_array($productId, $excludeProductIds)) {
            return $output;
        }
        $excludeCategoryIds = explode(",",$this->config->get('payment_tamarapay_pdp_wg_exclude_category_ids'));
        $productCategories = [];
        if (isset($this->request->get['path'])) {
            $productCategories = explode("_", $this->request->get['path']);
        }

        $this->load->model('catalog/product');
        if (!empty(array_intersect($productCategories, $excludeCategoryIds))) {
            return $output;
        }

        $productInfo = $this->model_catalog_product->getProduct($productId);
        if ($productInfo) {
            $this->load->model('extension/payment/tamarapay');
            $finalPrice = $this->model_extension_payment_tamarapay->getValueInCurrency($this->tax->calculate($productInfo['price'], $productInfo['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
            if ((float)$productInfo['special']) {
                $finalPrice = $this->model_extension_payment_tamarapay->getValueInCurrency($this->tax->calculate($productInfo['special'], $productInfo['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
            }

            $availableMethods = $this->model_extension_payment_tamarapay->getPaymentsMethodsAvailableForPrice($finalPrice);
            if (empty($availableMethods)) {
                return $output;
            }

            $str = "";
            foreach ($availableMethods as $method) {
                if ($method['is_available'] && $method['checked']) {
                    if ($method['name'] == "PAY_BY_INSTALMENTS") {
                        $str .= ('<div id="tamara-product-widget" data-disable-paylater="false" class="tamara-product-widget" data-lang="" data-price="'.$finalPrice.'" data-currency="' .$method['currency']. '" data-payment-type="installment" data-installment-minimum-amount="' .$method['min_limit']. '" data-installment-max-amount="'.$method['max_limit'].'"></a>');

                    } else {
                        $str .= ('<div id="tamara-product-widget" data-disable-paylater="false" data-pay-later-minimum-amount="'.$method['min_limit'].'" data-pay-later-max-amount="'.$method['max_limit'].'" class="tamara-product-widget" data-lang="" data-inject-template="true"></div>');
                    }
                    break;
                }
            }
            if (empty($str)) {
                return $output;
            }
            $str .= '<script charset="utf-8" src="https://cdn.tamara.co/widget/product-widget.min.js?t='.time().'"></script> <script type="text/javascript">let langCode="'.$this->language->get('code').'";window.langCode=langCode;window.checkTamaraProductWidgetCount=0;document.getElementById("tamara-product-widget").setAttribute("data-lang",langCode);var existTamaraProductWidget=setInterval(function(){if(window.TamaraProductWidget){window.TamaraProductWidget.init({lang:window.langCode});window.TamaraProductWidget.render();clearInterval(existTamaraProductWidget);} window.checkTamaraProductWidgetCount+=1;if(window.checkTamaraProductWidgetCount>33){clearInterval(existTamaraProductWidget);}},300);</script>';
            $str = ("\n\n" . "<div class='tamara-promo' style='margin-bottom: 10px;'>" . $str . "</div>" . "\n\n");
            $positionToInsert = strpos($output, '<div id="product"');

            $output = substr_replace($output, $str, $positionToInsert, 0);
            return $output;
        }
    }

    public function canCancelByRedirect($orderId) {
        try {
            $tamaraOrder = $this->model_extension_payment_tamarapay->getTamaraOrder($orderId);
            if ($tamaraOrder['is_authorised']) {
                return false;
            } else {
                if ($this->model_extension_payment_tamarapay->getTamaraOrderFromRemote($tamaraOrder['order_id'])->getStatus() == "approved") {
                    return false;
                }
            }
            return true;
        } catch (\Exception $exception) {
            return false;
        }
    }
}
