<?php

declare (strict_types=1);

namespace TMS\Tamara\Request\Checkout;

use TMS\Tamara\Request\AbstractRequestHandler;
use TMS\Tamara\Response\Checkout\CheckPaymentOptionsAvailabilityResponse;

class CheckPaymentOptionsAvailabilityRequestHandler extends AbstractRequestHandler
{

    private const CHECK_PAYMENT_OPTIONS_AVAILABILITY_ENDPOINT = '/checkout/payment-options-pre-check';

    public function __invoke(CheckPaymentOptionsAvailabilityRequest $request)
    {
        $response = $this->httpClient->post(
            self::CHECK_PAYMENT_OPTIONS_AVAILABILITY_ENDPOINT,
            $request->getPaymentOptionAvailability()->toArray()
        );

        return new CheckPaymentOptionsAvailabilityResponse($response);
    }
}
