<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
    <div class="page-header">
        <div class="container-fluid">
            <div class="pull-right">
                <button type="submit" form="form-payment" data-toggle="tooltip" title="<?php echo $button_save ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
                <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
            <h1><?php echo $heading_title; ?> version <?php echo $extension_version; ?></h1>
            <ul class="breadcrumb">
                <?php foreach ($breadcrumbs as $breadcrumb): ?>
                <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
                <?php endforeach; ?>
            </ul>
        </div>
    </div>
    <div class="container-fluid">

        <?php if ($is_using_latest_version !== null): ?>
            <?php if ($is_using_latest_version): ?>
                <div class="alert alert-success"><p>You are using latest version, read more about extension <a title="Read more" href="<?php echo $github['readme_link']; ?>">here</a></p></div>
            <?php else: ?>
                <div class="alert alert-danger"><p>You are using outdated version, please update <a title="Download" href="<?php echo $github['download_link']; ?>">here</a>, read more about extension <a title="Read more" href="<?php echo $github['readme_link']; ?>">here</a></p></div>
            <?php endif; ?>
        <?php endif; ?>

        <?php foreach ($notifications as $notification) { ?>
            <div class="alert alert-warning"><p><?php echo $notification; ?></p></div>
        <?php } ?>

        <?php if ($error_warning): ?>
            <div class="alert alert-danger alert-dismissible"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
                <button type="button" class="close" data-dismiss="alert">&times;</button>
            </div>
        <?php endif; ?>

        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_edit ?></h3>
            </div>
            <div class="panel-body">
                <form action="<?php echo $action ?>" method="post" enctype="multipart/form-data" id="form-payment" class="form-horizontal">

                    <div class="panel-group" id="tamara-payment-api-configurations">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h4 class="panel-title"><a href="#collapse-api-configurations" data-toggle="collapse" data-parent="#tamara-payment-api-configurations" class="accordion-toggle collapsed" aria-expanded="false">API Configurations <i class="fa fa-caret-down"></i></a></h4>
                            </div>
                            <div class="panel-collapse collapse" id="collapse-api-configurations" aria-expanded="false" style="height: 0px;">
                                <div class="panel-body">
                                    <div class="row">
                                        <div class="col-sm-12">

                                            <div class="form-group">
                                                <label class="col-sm-2 control-label" for="input-api-environment"><?php echo $entry_api_environment ?></label>
                                                <div class="col-sm-10">
                                                    <select name="tamarapay_api_environment" id="input-api-environment" class="form-control">
                                                        <?php if ($tamarapay_api_environment == "1"): ?>
                                                        <option value="1" selected="selected"><?php echo $text_sandbox ?></option>
                                                        <option value="2"><?php echo $text_production ?></option>
                                                        <?php else: ?>
                                                        <option value="1"><?php echo $text_sandbox ?></option>
                                                        <option value="2" selected="selected"><?php echo $text_production ?></option>
                                                        <?php endif ?>
                                                    </select>
                                                    <span>The sandbox environment is used for testing, not actual orders. Please make sure sandbox testing goes well before moving to production.</span>
                                                </div>
                                            </div>

                                            <div class="form-group required">
                                                <label class="col-sm-2 control-label" for="input-token"><?php echo $entry_token ?></label>
                                                <div class="col-sm-10">
                                                    <textarea class="form-control" id="input-token" placeholder="<?php echo $entry_token ?>" rows="7" name="tamarapay_token"><?php echo $tamarapay_token ?></textarea>
                                                    <?php if($error_token): ?>
                                                    <div class="text-danger"><?php echo $error_token ?></div>
                                                    <?php endif ?>
                                                </div>
                                            </div>
                                            <div class="form-group required">
                                                <label class="col-sm-2 control-label" for="input-token-notification"><?php echo $entry_token_notification ?></label>
                                                <div class="col-sm-10">
                                                    <textarea class="form-control" id="input-token-notification" placeholder="<?php echo $entry_token_notification ?>" rows="7" name="tamarapay_token_notification"><?php echo $tamarapay_token_notification ?></textarea>
                                                    <?php if ($error_token_notification): ?>
                                                    <div class="text-danger"><?php echo $error_token_notification; ?></div>
                                                    <?php endif ?>
                                                </div>
                                            </div>
                                            <div id="group-merchant-public-key" class="form-group <?php echo $tamarapay_merchant_public_key_extra_class ?>">
                                                <label class="col-sm-2 control-label" for="input-merchant-public-key"><?php echo $entry_merchant_public_key ?></label>
                                                <div class="col-sm-10">
                                                    <input id="input-merchant-public-key" name="tamarapay_merchant_public_key" value="<?php echo $tamarapay_merchant_public_key ?>" type="text" class="form-control" />
                                                    <?php if ($error_merchant_public_key): ?>
                                                    <div class="text-danger"><?php echo $error_merchant_public_key ?></div>
                                                    <?php endif; ?>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-sm-2 control-label" for="input-trigger-actions-enabled"><?php echo $entry_enable_trigger_actions ?></label>
                                                <div class="col-sm-10">
                                                    <select name="tamarapay_trigger_actions_enabled" id="input-trigger-actions-enabled" class="form-control">
                                                        <?php if ($tamarapay_trigger_actions_enabled): ?>
                                                        <option value="1" selected="selected"><?php echo $text_enabled ?></option>
                                                        <option value="0"><?php echo $text_disabled ?></option>
                                                        <?php else: ?>
                                                        <option value="1"><?php echo $text_enabled ?></option>
                                                        <option value="0" selected="selected"><?php echo $text_disabled ?></option>
                                                        <?php endif ?>
                                                    </select>
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label class="col-sm-2 control-label" for="input-warning-under-over-message-enabled"><?php echo $entry_enable_under_over_warning?></label>
                                                <div class="col-sm-10">
                                                    <select name="tamarapay_enable_under_over_warning" id="input-warning-under-over-message-enabled" class="form-control">
                                                        <?php if ($tamarapay_enable_under_over_warning): ?>
                                                        <option value="1" selected="selected"><?php echo $text_enabled ?></option>
                                                        <option value="0"><?php echo $text_disabled ?></option>
                                                        <?php else: ?>
                                                        <option value="1"><?php echo $text_enabled ?></option>
                                                        <option value="0" selected="selected"><?php echo $text_disabled ?></option>
                                                        <?php endif ?>
                                                    </select>
                                                    <span>Enable warning message if the cart total amount is under / over payment limit. If disabled, we will hide unavailable methods</span>
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label class="col-sm-2 control-label" for="input-checkout-success-url"><?php echo $entry_merchant_success_url ?></label>
                                                <div class="col-sm-10">
                                                    <input id="input-checkout-success-url" name="tamarapay_checkout_success_url" value="<?php echo $tamarapay_checkout_success_url ?>" type="text" class="form-control" />
                                                    <span>If empty, Tamara will process this url automatically (Recommend)</span>
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label class="col-sm-2 control-label" for="input-checkout-cancel-url"><?php echo $entry_merchant_cancel_url ?></label>
                                                <div class="col-sm-10">
                                                    <input id="input-checkout-cancel-url" name="tamarapay_checkout_cancel_url" value="<?php echo $tamarapay_checkout_cancel_url ?>" type="text" class="form-control" />
                                                    <span>If empty, Tamara will process this url automatically (Recommend)</span>
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label class="col-sm-2 control-label" for="input-checkout-failure-url"><?php echo $entry_merchant_failure_url ?></label>
                                                <div class="col-sm-10">
                                                    <input id="input-checkout-failure-url" name="tamarapay_checkout_failure_url" value="<?php echo $tamarapay_checkout_failure_url ?>" type="text" class="form-control" />
                                                    <span>If empty, Tamara will process this url automatically (Recommend)</span>
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label class="col-sm-2 control-label" for="input-tamara-success-page-enabled"><?php echo $entry_enable_tamara_checkout_success_page ?></label>
                                                <div class="col-sm-10">
                                                    <select name="tamarapay_enable_tamara_checkout_success_page" id="input-tamara-success-page-enabled" class="form-control">
                                                        <?php if ($tamarapay_enable_tamara_checkout_success_page): ?>
                                                        <option value="1" selected="selected"><?php echo $text_enabled ?></option>
                                                        <option value="0"><?php echo $text_disabled ?></option>
                                                        <?php else: ?>
                                                        <option value="1"><?php echo $text_enabled ?></option>
                                                        <option value="0" selected="selected"><?php echo $text_disabled ?></option>
                                                        <?php endif ?>
                                                    </select>
                                                    <b>This option is only available while checkout success redirect URL is empty</b>
                                                    <br />
                                                    <span>If disabled, we will use default checkout success page</span>
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label class="col-sm-2 control-label" for="input-pdp-wg-exclude-product-ids"><?php echo $entry_pdp_wg_exclude_product_ids ?></label>
                                                <div class="col-sm-10">
                                                    <input id="input-pdp-wg-exclude-product-ids" name="tamarapay_pdp_wg_exclude_product_ids" value="<?php echo $tamarapay_pdp_wg_exclude_product_ids ?>" type="text" class="form-control" />
                                                    <span>Each value is separated by comma (,)</span>
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label class="col-sm-2 control-label" for="input-pdp-wg-exclude-category-ids"><?php echo $entry_pdp_wg_exclude_category_ids ?></label>
                                                <div class="col-sm-10">
                                                    <input id="input-pdp-wg-exclude-category-ids" name="tamarapay_pdp_wg_exclude_category_ids" value="<?php echo $tamarapay_pdp_wg_exclude_category_ids ?>" type="text" class="form-control" />
                                                    <span>Each value is separated by comma (,)</span>
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label class="col-sm-2 control-label" for="input-only-show-tamara-for-these-emails"><?php echo $entry_only_show_for_these_customer ?></label>
                                                <div class="col-sm-10">
                                                    <input id="input-only-show-tamara-for-these-emails" name="tamarapay_only_show_for_these_customer" value="<?php echo $tamarapay_only_show_for_these_customer ?>" type="text" class="form-control" />
                                                    <span>Useful in case you want to limit the customers who can use Tamara, for example testing. Each email is separated by comma (,)</span>
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label class="col-sm-2 control-label" for="input-webhook-enabled"><?php echo $entry_enable_webhook ?></label>
                                                <div class="col-sm-10">
                                                    <select name="tamarapay_webhook_enabled" id="input-webhook-enabled" class="form-control">
                                                        <?php if ($tamarapay_webhook_enabled): ?>
                                                        <option value="1" selected="selected"><?php echo $text_enabled ?></option>
                                                        <option value="0"><?php echo $text_disabled ?></option>
                                                        <?php else: ?>
                                                        <option value="1"><?php echo $text_enabled ?></option>
                                                        <option value="0" selected="selected"><?php echo $text_disabled ?></option>
                                                        <?php endif ?>
                                                    </select>
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label class="col-sm-2 control-label" for="input-webhook-id"><?php echo $entry_webhook_id ?></label>
                                                <div class="col-sm-10">
                                                    <input id="input-webhook-id" name="tamarapay_webhook_id" value="<?php echo $tamarapay_webhook_id ?>" type="text" class="form-control" readonly />
                                                </div>
                                            </div>

                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="panel-group" id="tamara-payment-types">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h4 class="panel-title"><a href="#collapse-payment-types" data-toggle="collapse" data-parent="#tamara-payment-types" class="accordion-toggle collapsed" aria-expanded="false">Payment types <i class="fa fa-caret-down"></i></a></h4>
                            </div>
                            <div class="panel-collapse collapse" id="collapse-payment-types" aria-expanded="false" style="height: 0px;">
                                <div class="panel-body">

                                    <div class="form-group">
                                        <div class="col-sm-12">
                                            <button type="button" id="update-payment-config">Pull new changes from Tamara / Flush cache</button>
                                            <span id="update-payment-config-message" style="display: none;"></span>
                                        </div>
                                    </div>

                                    <div class="panel-group" id="pay-by-later-group">
                                        <div class="panel panel-default">
                                            <div class="panel-heading">
                                                <h4 class="panel-title"><a href="#collapse-pay-by-later" data-toggle="collapse" data-parent="#pay-by-later-group" class="accordion-toggle" aria-expanded="true">Pay later in 30 days<i class="fa fa-caret-down"></i></a></h4>
                                            </div>
                                            <div class="panel-collapse collapse in" id="collapse-pay-by-later" aria-expanded="true">
                                                <div class="panel-body">
                                                    <div class="row">

                                                        <div class="row form-group required">
                                                            <label class="col-sm-4 control-label" for="pay-by-later-enabled"><?php echo $entry_enable ?></label>
                                                            <div class="col-sm-8">

                                                                <select name="tamarapay_types_pay_by_later_enabled" id="pay-by-later-enabled" class="form-control" <?php echo $select_enable_payment_type_extra_attributes; ?>>
                                                                    <?php if ($tamarapay_types_pay_by_later_enabled): ?>
                                                                    <option value="1" selected="selected"><?php echo $text_enabled ?></option>
                                                                    <option value="0"><?php echo $text_disabled ?></option>
                                                                    <?php else: ?>
                                                                    <option value="1"><?php echo $text_enabled ?></option>
                                                                    <option value="0" selected="selected"><?php echo $text_disabled ?></option>
                                                                    <?php endif ?>
                                                                </select>

                                                            </div>
                                                        </div>

                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="panel-group" id="pay-next-month-group">
                                        <div class="panel panel-default">
                                            <div class="panel-heading">
                                                <h4 class="panel-title"><a href="#collapse-pay-next-month" data-toggle="collapse" data-parent="#pay-next-month-group" class="accordion-toggle" aria-expanded="true">Pay next month <i class="fa fa-caret-down"></i></a></h4>
                                            </div>
                                            <div class="panel-collapse collapse in" id="collapse-pay-next-month" aria-expanded="true">
                                                <div class="panel-body">
                                                    <div class="row">

                                                        <div class="row form-group required">
                                                            <label class="col-sm-4 control-label" for="pay-next-month-enabled"><?php echo $entry_enable; ?></label>
                                                            <div class="col-sm-8">

                                                                <select name="tamarapay_types_pay_next_month_enabled" id="pay-next-month-enabled" class="form-control" <?php echo $select_enable_payment_type_extra_attributes; ?>>
                                                                <?php if ($tamarapay_types_pay_next_month_enabled): ?>
                                                                        <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                                                                <option value="0"><?php echo $text_disabled; ?></option>
                                                                <?php else: ?>
                                                                <option value="1"><?php echo $text_enabled; ?></option>
                                                                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                                                                <?php endif; ?>
                                                                </select>

                                                            </div>
                                                        </div>

                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="panel-group" id="pay-now-group">
                                        <div class="panel panel-default">
                                            <div class="panel-heading">
                                                <h4 class="panel-title"><a href="#collapse-pay-now" data-toggle="collapse" data-parent="#pay-now-group" class="accordion-toggle" aria-expanded="true">Pay now <i class="fa fa-caret-down"></i></a></h4>
                                            </div>
                                            <div class="panel-collapse collapse in" id="collapse-pay-now" aria-expanded="true">
                                                <div class="panel-body">
                                                    <div class="row">

                                                        <div class="row form-group required">
                                                            <label class="col-sm-4 control-label" for="pay-now-enabled"><?php echo $entry_enable; ?></label>
                                                            <div class="col-sm-8">

                                                                <select name="tamarapay_types_pay_now_enabled" id="pay-now-enabled" class="form-control">
                                                                    <?php if ($tamarapay_types_pay_now_enabled): ?>
                                                                    <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                                                                    <option value="0"><?php echo $text_disabled; ?></option>
                                                                    <?php else: ?>
                                                                    <option value="1"><?php echo $text_enabled; ?></option>
                                                                    <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                                                                    <?php endif; ?>
                                                                </select>

                                                            </div>
                                                        </div>

                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="panel-group" id="pay-by-instalments-2-group">
                                        <div class="panel panel-default">
                                            <div class="panel-heading">
                                                <h2 class="panel-title"><a href="#collapse-pay-by-instalments-2" data-toggle="collapse" data-parent="#pay-by-instalments-2-group" class="accordion-toggle" aria-expanded="true">Pay in 2 instalments <i class="fa fa-caret-down"></i></a></h2>
                                            </div>
                                            <div class="panel-collapse collapse in" id="collapse-pay-by-instalments-2" aria-expanded="true">
                                                <div class="panel-body">
                                                    <div class="row">

                                                        <div class="row form-group required">
                                                            <label class="col-sm-4 control-label" for="pay-by-instalments-2-enabled"><?php echo $entry_enable; ?></label>
                                                            <div class="col-sm-8">

                                                                <select name="tamarapay_types_pay_by_instalments_2_enabled" id="pay-by-instalments-2-enabled" class="form-control" <?php echo $select_enable_payment_type_extra_attributes; ?>>
                                                                <?php if ($tamarapay_types_pay_by_instalments_2_enabled): ?>
                                                                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                                                                <option value="0"><?php echo $text_disabled; ?></option>
                                                                <?php else: ?>
                                                                <option value="1"><?php echo $text_enabled; ?></option>
                                                                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                                                                <?php endif; ?>
                                                                </select>

                                                            </div>
                                                        </div>

                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="panel-group" id="pay-by-instalments-group">
                                        <div class="panel panel-default">
                                            <div class="panel-heading">
                                                <h4 class="panel-title"><a href="#collapse-pay-by-instalments" data-toggle="collapse" data-parent="#pay-by-instalments-group" class="accordion-toggle" aria-expanded="true">Pay in 3 instalments <i class="fa fa-caret-down"></i></a></h4>
                                            </div>
                                            <div class="panel-collapse collapse in" id="collapse-pay-by-instalments" aria-expanded="true">
                                                <div class="panel-body">
                                                    <div class="row">

                                                        <div class="row form-group required">
                                                            <label class="col-sm-4 control-label" for="pay-by-instalments-enabled"><?php echo $entry_enable ?></label>
                                                            <div class="col-sm-8">

                                                                <select name="tamarapay_types_pay_by_instalments_enabled" id="pay-by-instalments-enabled" class="form-control" <?php echo $select_enable_payment_type_extra_attributes; ?>>
                                                                    <?php if ($tamarapay_types_pay_by_instalments_enabled): ?>
                                                                    <option value="1" selected="selected"><?php echo $text_enabled ?></option>
                                                                    <option value="0"><?php echo $text_disabled ?></option>
                                                                    <?php else: ?>
                                                                    <option value="1"><?php echo $text_enabled ?></option>
                                                                    <option value="0" selected="selected"><?php echo $text_disabled ?></option>
                                                                    <?php endif ?>
                                                                </select>

                                                            </div>
                                                        </div>

                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="panel-group" id="pay-by-instalments-4-group">
                                        <div class="panel panel-default">
                                            <div class="panel-heading">
                                                <h4 class="panel-title"><a href="#collapse-pay-by-instalments-4" data-toggle="collapse" data-parent="#pay-by-instalments-4-group" class="accordion-toggle" aria-expanded="true">Pay in 4 instalments <i class="fa fa-caret-down"></i></a></h4>
                                            </div>
                                            <div class="panel-collapse collapse in" id="collapse-pay-by-instalments-4" aria-expanded="true">
                                                <div class="panel-body">
                                                    <div class="row">

                                                        <div class="row form-group required">
                                                            <label class="col-sm-4 control-label" for="pay-by-instalments-4-enabled"><?php echo $entry_enable ?></label>
                                                            <div class="col-sm-8">

                                                                <select name="tamarapay_types_pay_by_instalments_4_enabled" id="pay-by-instalments-4-enabled" class="form-control" <?php echo $select_enable_payment_type_extra_attributes; ?>>
                                                                    <?php if ($tamarapay_types_pay_by_instalments_4_enabled): ?>
                                                                    <option value="1" selected="selected"><?php echo $text_enabled ?></option>
                                                                    <option value="0"><?php echo $text_disabled ?></option>
                                                                    <?php else: ?>
                                                                    <option value="1"><?php echo $text_enabled ?></option>
                                                                    <option value="0" selected="selected"><?php echo $text_disabled ?></option>
                                                                    <?php endif ?>
                                                                </select>

                                                            </div>
                                                        </div>

                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="panel-group" id="pay-by-instalments-5-group">
                                        <div class="panel panel-default">
                                            <div class="panel-heading">
                                                <h4 class="panel-title"><a href="#collapse-pay-by-instalments-5" data-toggle="collapse" data-parent="#pay-by-instalments-5-group" class="accordion-toggle" aria-expanded="true">Pay in 5 instalments <i class="fa fa-caret-down"></i></a></h4>
                                            </div>
                                            <div class="panel-collapse collapse in" id="collapse-pay-by-instalments-5" aria-expanded="true">
                                                <div class="panel-body">
                                                    <div class="row">

                                                        <div class="row form-group required">
                                                            <label class="col-sm-4 control-label" for="pay-by-instalments-5-enabled"><?php echo $entry_enable ?></label>
                                                            <div class="col-sm-8">

                                                                <select name="tamarapay_types_pay_by_instalments_5_enabled" id="pay-by-instalments-5-enabled" class="form-control" <?php echo $select_enable_payment_type_extra_attributes; ?>>
                                                                    <?php if ($tamarapay_types_pay_by_instalments_5_enabled): ?>
                                                                    <option value="1" selected="selected"><?php echo $text_enabled ?></option>
                                                                    <option value="0"><?php echo $text_disabled ?></option>
                                                                    <?php else: ?>
                                                                    <option value="1"><?php echo $text_enabled ?></option>
                                                                    <option value="0" selected="selected"><?php echo $text_disabled ?></option>
                                                                    <?php endif ?>
                                                                </select>

                                                            </div>
                                                        </div>

                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="panel-group" id="pay-by-instalments-6-group">
                                        <div class="panel panel-default">
                                            <div class="panel-heading">
                                                <h4 class="panel-title"><a href="#collapse-pay-by-instalments-6" data-toggle="collapse" data-parent="#pay-by-instalments-6-group" class="accordion-toggle" aria-expanded="true">Pay in 6 instalments <i class="fa fa-caret-down"></i></a></h4>
                                            </div>
                                            <div class="panel-collapse collapse in" id="collapse-pay-by-instalments-6" aria-expanded="true">
                                                <div class="panel-body">
                                                    <div class="row">

                                                        <div class="row form-group required">
                                                            <label class="col-sm-4 control-label" for="pay-by-instalments-6-enabled"><?php echo $entry_enable ?></label>
                                                            <div class="col-sm-8">

                                                                <select name="tamarapay_types_pay_by_instalments_6_enabled" id="pay-by-instalments-6-enabled" class="form-control" <?php echo $select_enable_payment_type_extra_attributes; ?>>
                                                                    <?php if ($tamarapay_types_pay_by_instalments_6_enabled): ?>
                                                                    <option value="1" selected="selected"><?php echo $text_enabled ?></option>
                                                                    <option value="0"><?php echo $text_disabled ?></option>
                                                                    <?php else: ?>
                                                                    <option value="1"><?php echo $text_enabled ?></option>
                                                                    <option value="0" selected="selected"><?php echo $text_disabled ?></option>
                                                                    <?php endif ?>
                                                                </select>

                                                            </div>
                                                        </div>

                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="panel-group" id="pay-by-instalments-7-group">
                                        <div class="panel panel-default">
                                            <div class="panel-heading">
                                                <h4 class="panel-title"><a href="#collapse-pay-by-instalments-7" data-toggle="collapse" data-parent="#pay-by-instalments-7-group" class="accordion-toggle" aria-expanded="true">Pay in 7 instalments <i class="fa fa-caret-down"></i></a></h4>
                                            </div>
                                            <div class="panel-collapse collapse in" id="collapse-pay-by-instalments-7" aria-expanded="true">
                                                <div class="panel-body">
                                                    <div class="row">

                                                        <div class="row form-group required">
                                                            <label class="col-sm-4 control-label" for="pay-by-instalments-7-enabled"><?php echo $entry_enable ?></label>
                                                            <div class="col-sm-8">

                                                                <select name="tamarapay_types_pay_by_instalments_7_enabled" id="pay-by-instalments-7-enabled" class="form-control" <?php echo $select_enable_payment_type_extra_attributes; ?>>
                                                                    <?php if ($tamarapay_types_pay_by_instalments_7_enabled): ?>
                                                                    <option value="1" selected="selected"><?php echo $text_enabled ?></option>
                                                                    <option value="0"><?php echo $text_disabled ?></option>
                                                                    <?php else: ?>
                                                                    <option value="1"><?php echo $text_enabled ?></option>
                                                                    <option value="0" selected="selected"><?php echo $text_disabled ?></option>
                                                                    <?php endif ?>
                                                                </select>

                                                            </div>
                                                        </div>

                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="panel-group" id="pay-by-instalments-8-group">
                                        <div class="panel panel-default">
                                            <div class="panel-heading">
                                                <h4 class="panel-title"><a href="#collapse-pay-by-instalments-8" data-toggle="collapse" data-parent="#pay-by-instalments-8-group" class="accordion-toggle" aria-expanded="true">Pay in 8 instalments <i class="fa fa-caret-down"></i></a></h4>
                                            </div>
                                            <div class="panel-collapse collapse in" id="collapse-pay-by-instalments-8" aria-expanded="true">
                                                <div class="panel-body">
                                                    <div class="row">

                                                        <div class="row form-group required">
                                                            <label class="col-sm-4 control-label" for="pay-by-instalments-8-enabled"><?php echo $entry_enable ?></label>
                                                            <div class="col-sm-8">

                                                                <select name="tamarapay_types_pay_by_instalments_8_enabled" id="pay-by-instalments-8-enabled" class="form-control" <?php echo $select_enable_payment_type_extra_attributes; ?>>
                                                                    <?php if ($tamarapay_types_pay_by_instalments_8_enabled): ?>
                                                                    <option value="1" selected="selected"><?php echo $text_enabled ?></option>
                                                                    <option value="0"><?php echo $text_disabled ?></option>
                                                                    <?php else: ?>
                                                                    <option value="1"><?php echo $text_enabled ?></option>
                                                                    <option value="0" selected="selected"><?php echo $text_disabled ?></option>
                                                                    <?php endif ?>
                                                                </select>

                                                            </div>
                                                        </div>

                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="panel-group" id="pay-by-instalments-9-group">
                                        <div class="panel panel-default">
                                            <div class="panel-heading">
                                                <h4 class="panel-title"><a href="#collapse-pay-by-instalments-9" data-toggle="collapse" data-parent="#pay-by-instalments-9-group" class="accordion-toggle" aria-expanded="true">Pay in 9 instalments <i class="fa fa-caret-down"></i></a></h4>
                                            </div>
                                            <div class="panel-collapse collapse in" id="collapse-pay-by-instalments-9" aria-expanded="true">
                                                <div class="panel-body">
                                                    <div class="row">

                                                        <div class="row form-group required">
                                                            <label class="col-sm-4 control-label" for="pay-by-instalments-9-enabled"><?php echo $entry_enable ?></label>
                                                            <div class="col-sm-8">

                                                                <select name="tamarapay_types_pay_by_instalments_9_enabled" id="pay-by-instalments-9-enabled" class="form-control" <?php echo $select_enable_payment_type_extra_attributes; ?>>
                                                                    <?php if ($tamarapay_types_pay_by_instalments_9_enabled): ?>
                                                                    <option value="1" selected="selected"><?php echo $text_enabled ?></option>
                                                                    <option value="0"><?php echo $text_disabled ?></option>
                                                                    <?php else: ?>
                                                                    <option value="1"><?php echo $text_enabled ?></option>
                                                                    <option value="0" selected="selected"><?php echo $text_disabled ?></option>
                                                                    <?php endif ?>
                                                                </select>

                                                            </div>
                                                        </div>

                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="panel-group" id="pay-by-instalments-10-group">
                                        <div class="panel panel-default">
                                            <div class="panel-heading">
                                                <h4 class="panel-title"><a href="#collapse-pay-by-instalments-10" data-toggle="collapse" data-parent="#pay-by-instalments-10-group" class="accordion-toggle" aria-expanded="true">Pay in 10 instalments <i class="fa fa-caret-down"></i></a></h4>
                                            </div>
                                            <div class="panel-collapse collapse in" id="collapse-pay-by-instalments-10" aria-expanded="true">
                                                <div class="panel-body">
                                                    <div class="row">

                                                        <div class="row form-group required">
                                                            <label class="col-sm-4 control-label" for="pay-by-instalments-10-enabled"><?php echo $entry_enable ?></label>
                                                            <div class="col-sm-8">

                                                                <select name="tamarapay_types_pay_by_instalments_10_enabled" id="pay-by-instalments-10-enabled" class="form-control" <?php echo $select_enable_payment_type_extra_attributes; ?>>
                                                                    <?php if ($tamarapay_types_pay_by_instalments_10_enabled): ?>
                                                                    <option value="1" selected="selected"><?php echo $text_enabled ?></option>
                                                                    <option value="0"><?php echo $text_disabled ?></option>
                                                                    <?php else: ?>
                                                                    <option value="1"><?php echo $text_enabled ?></option>
                                                                    <option value="0" selected="selected"><?php echo $text_disabled ?></option>
                                                                    <?php endif ?>
                                                                </select>

                                                            </div>
                                                        </div>

                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="panel-group" id="pay-by-instalments-11-group">
                                        <div class="panel panel-default">
                                            <div class="panel-heading">
                                                <h4 class="panel-title"><a href="#collapse-pay-by-instalments-11" data-toggle="collapse" data-parent="#pay-by-instalments-11-group" class="accordion-toggle" aria-expanded="true">Pay in 11 instalments <i class="fa fa-caret-down"></i></a></h4>
                                            </div>
                                            <div class="panel-collapse collapse in" id="collapse-pay-by-instalments-11" aria-expanded="true">
                                                <div class="panel-body">
                                                    <div class="row">

                                                        <div class="row form-group required">
                                                            <label class="col-sm-4 control-label" for="pay-by-instalments-11-enabled"><?php echo $entry_enable ?></label>
                                                            <div class="col-sm-8">

                                                                <select name="tamarapay_types_pay_by_instalments_11_enabled" id="pay-by-instalments-11-enabled" class="form-control" <?php echo $select_enable_payment_type_extra_attributes; ?>>
                                                                    <?php if ($tamarapay_types_pay_by_instalments_11_enabled): ?>
                                                                    <option value="1" selected="selected"><?php echo $text_enabled ?></option>
                                                                    <option value="0"><?php echo $text_disabled ?></option>
                                                                    <?php else: ?>
                                                                    <option value="1"><?php echo $text_enabled ?></option>
                                                                    <option value="0" selected="selected"><?php echo $text_disabled ?></option>
                                                                    <?php endif ?>
                                                                </select>

                                                            </div>
                                                        </div>

                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="panel-group" id="pay-by-instalments-12-group">
                                        <div class="panel panel-default">
                                            <div class="panel-heading">
                                                <h4 class="panel-title"><a href="#collapse-pay-by-instalments-12" data-toggle="collapse" data-parent="#pay-by-instalments-12-group" class="accordion-toggle" aria-expanded="true">Pay in 12 instalments <i class="fa fa-caret-down"></i></a></h4>
                                            </div>
                                            <div class="panel-collapse collapse in" id="collapse-pay-by-instalments-12" aria-expanded="true">
                                                <div class="panel-body">
                                                    <div class="row">

                                                        <div class="row form-group required">
                                                            <label class="col-sm-4 control-label" for="pay-by-instalments-12-enabled"><?php echo $entry_enable ?></label>
                                                            <div class="col-sm-8">

                                                                <select name="tamarapay_types_pay_by_instalments_12_enabled" id="pay-by-instalments-12-enabled" class="form-control" <?php echo $select_enable_payment_type_extra_attributes; ?>>
                                                                    <?php if ($tamarapay_types_pay_by_instalments_12_enabled): ?>
                                                                    <option value="1" selected="selected"><?php echo $text_enabled ?></option>
                                                                    <option value="0"><?php echo $text_disabled ?></option>
                                                                    <?php else: ?>
                                                                    <option value="1"><?php echo $text_enabled ?></option>
                                                                    <option value="0" selected="selected"><?php echo $text_disabled ?></option>
                                                                    <?php endif ?>
                                                                </select>

                                                            </div>
                                                        </div>

                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="panel-group" id="tamara-payment-order-statuses">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h4 class="panel-title"><a href="#collapse-order-statuses" data-toggle="collapse" data-parent="#tamara-payment-order-statuses" class="accordion-toggle collapsed" aria-expanded="false">Checkout order statuses <i class="fa fa-caret-down"></i></a></h4>
                            </div>
                            <div class="panel-collapse collapse" id="collapse-order-statuses" aria-expanded="false" style="height: 0px;">
                                <div class="panel-body">
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <div class="form-group">
                                                <label class="col-sm-2 control-label" for="input-order-status-success"><?php echo $entry_order_status_success ?></label>
                                                <div class="col-sm-10">
                                                    <select name="tamarapay_order_status_success_id" id="input-order-status-success" class="form-control">
                                                        <?php foreach ($order_statuses as $order_status): ?>
                                                        <?php if ($order_status['order_status_id'] == $tamarapay_order_status_success_id): ?>
                                                        <option value="<?php echo $order_status['order_status_id'] ?>" selected="selected"><?php echo $order_status['name'] ?></option>
                                                        <?php else: ?>
                                                        <option value="<?php echo $order_status['order_status_id'] ?>"><?php echo $order_status['name'] ?></option>
                                                        <?php endif ?>
                                                        <?php endforeach ?>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-sm-2 control-label" for="input-order-status-failure"><?php echo $entry_order_status_failure ?></label>
                                                <div class="col-sm-10">
                                                    <select name="tamarapay_order_status_failure_id" id="input-order-status-failure" class="form-control">
                                                        <?php foreach ($order_statuses as $order_status): ?>
                                                        <?php if ($order_status['order_status_id'] == $tamarapay_order_status_failure_id): ?>
                                                        <option value="<?php echo $order_status['order_status_id'] ?>" selected="selected"><?php echo $order_status['name'] ?></option>
                                                        <?php else: ?>
                                                        <option value="<?php echo $order_status['order_status_id'] ?>"><?php echo $order_status['name'] ?></option>
                                                        <?php endif ?>
                                                        <?php endforeach ?>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-sm-2 control-label" for="input-order-status-canceled"><?php echo $entry_order_status_canceled ?></label>
                                                <div class="col-sm-10">
                                                    <select name="tamarapay_order_status_canceled_id" id="input-order-status-canceled" class="form-control">
                                                        <?php foreach ($order_statuses as $order_status): ?>
                                                        <?php if ($order_status['order_status_id'] == $tamarapay_order_status_canceled_id): ?>
                                                        <option value="<?php echo $order_status['order_status_id'] ?>" selected="selected"><?php echo $order_status['name'] ?></option>
                                                        <?php else: ?>
                                                        <option value="<?php echo $order_status['order_status_id'] ?>"><?php echo $order_status['name'] ?></option>
                                                        <?php endif ?>
                                                        <?php endforeach ?>
                                                    </select>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-sm-2 control-label" for="input-order-status-authorised"><?php echo $entry_order_status_authorised ?></label>
                                                <div class="col-sm-10">
                                                    <select name="tamarapay_order_status_authorised_id" id="input-order-status-authorised" class="form-control">
                                                        <?php foreach ($order_statuses as $order_status): ?>
                                                        <?php if ($order_status['order_status_id'] == $tamarapay_order_status_authorised_id): ?>
                                                        <option value="<?php echo $order_status['order_status_id'] ?>" selected="selected"><?php echo $order_status['name'] ?></option>
                                                        <?php else: ?>
                                                        <option value="<?php echo $order_status['order_status_id'] ?>"><?php echo $order_status['name'] ?></option>
                                                        <?php endif ?>
                                                        <?php endforeach ?>
                                                    </select>
                                                </div>
                                            </div>


                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="panel-group" id="tamara-payment-capture-order-statuses">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h4 class="panel-title"><a href="#collapse-capture-order-statuses" data-toggle="collapse" data-parent="#tamara-payment-capture-order-statuses" class="accordion-toggle collapsed" aria-expanded="false">Tamara trigger configuration <i class="fa fa-caret-down"></i></a></h4>
                            </div>
                            <div class="panel-collapse collapse" id="collapse-capture-order-statuses" aria-expanded="false" style="height: 0px;">
                                <div class="panel-body">
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <div class="form-group">
                                                <label class="col-sm-6 control-label" for="input-capture-order-status"><?php echo $entry_capture_order_status ?></label>
                                                <div class="col-sm-6">
                                                    <select name="tamarapay_capture_order_status_id" id="input-capture-order-status" class="form-control">
                                                        <?php foreach ($order_statuses as $order_status): ?>
                                                        <?php if ($order_status['order_status_id'] == $tamarapay_capture_order_status_id): ?>
                                                        <option value="<?php echo $order_status['order_status_id'] ?>" selected="selected"><?php echo $order_status['name'] ?></option>
                                                        <?php else: ?>
                                                        <option value="<?php echo $order_status['order_status_id'] ?>"><?php echo $order_status['name'] ?></option>
                                                        <?php endif ?>
                                                        <?php endforeach ?>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <div class="form-group">
                                                <label class="col-sm-6 control-label" for="input-cancel-order-status"><?php echo $entry_cancel_order_status ?></label>
                                                <div class="col-sm-6">
                                                    <select name="tamarapay_cancel_order_status_id" id="input-cancel-order-status" class="form-control">
                                                        <?php foreach ($order_statuses as $order_status): ?>
                                                        <?php if ($order_status['order_status_id'] == $tamarapay_cancel_order_status_id): ?>
                                                        <option value="<?php echo $order_status['order_status_id'] ?>" selected="selected"><?php echo $order_status['name'] ?></option>
                                                        <?php else: ?>
                                                        <option value="<?php echo $order_status['order_status_id'] ?>"><?php echo $order_status['name'] ?></option>
                                                        <?php endif ?>
                                                        <?php endforeach ?>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="panel-group" id="tamara-payment-general-configuration">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h4 class="panel-title">General configuration</h4>
                            </div>
                            <div class="panel-body">
                                <div class="form-group">
                                    <label class="col-sm-2 control-label" for="input-debug-enabled"><?php echo $entry_enable_debug ?></label>
                                    <div class="col-sm-10">
                                        <select name="tamarapay_debug" id="input-debug-enabled" class="form-control">
                                            <?php if ($tamarapay_debug): ?>
                                            <option value="1" selected="selected"><?php echo $text_enabled ?></option>
                                            <option value="0"><?php echo $text_disabled ?></option>
                                            <?php else: ?>
                                            <option value="1"><?php echo $text_enabled ?></option>
                                            <option value="0" selected="selected"><?php echo $text_disabled ?></option>
                                            <?php endif ?>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label" for="input-geo-zone"><?php echo $entry_geo_zone ?></label>
                                    <div class="col-sm-10">
                                        <select name="tamarapay_geo_zone_id" id="input-geo-zone" class="form-control">
                                            <option value="0"><?php echo $text_all_zones ?></option>
                                            <?php foreach ($geo_zones as $geo_zone):  ?>
                                            <?php if ($geo_zone['geo_zone_id'] == $tamarapay_geo_zone_id): ?>
                                            <option value="<?php echo $geo_zone['geo_zone_id'] ?>" selected="selected"><?php echo $geo_zone['name'] ?></option>
                                            <?php else: ?>
                                            <option value="<?php echo $geo_zone['geo_zone_id'] ?>"><?php echo $geo_zone['name'] ?></option>
                                            <?php endif ?>
                                            <?php endforeach ?>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status ?></label>
                                    <div class="col-sm-10">
                                        <select name="tamarapay_status" id="input-status" class="form-control">
                                            <?php if ($tamarapay_status): ?>
                                            <option value="1" selected="selected"><?php echo $text_enabled ?></option>
                                            <option value="0"><?php echo $text_disabled ?></option>
                                            <?php else: ?>
                                            <option value="1"><?php echo $text_enabled ?></option>
                                            <option value="0" selected="selected"><?php echo $text_disabled ?></option>
                                            <?php endif ?>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label" for="input-sort-order"><?php echo $entry_sort_order ?></label>
                                    <div class="col-sm-10">
                                        <input type="text" name="tamarapay_sort_order" value="<?php echo $tamarapay_sort_order ?>" placeholder="<?php echo $entry_sort_order ?>" id="input-sort-order" class="form-control" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                </form>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript"><!--
    $('#update-payment-config').on('click', function() {
        $.ajax({
            url: 'index.php?route=payment/tamarapay/flushTamaraCache&token=<?php echo $token ?>',
            type: 'get',
            contentType: 'application/json',
            dataType: 'json',
            data: {},
            beforeSend: function() {
                $('#update-payment-config').attr("disabled", true);
            },
            complete: function() {
                $('#update-payment-config').attr("disabled", false);
            },
            success: function(rs) {
                if (rs.success == true) {
                    $('#update-payment-config-message').text("Payment types flushed").removeClass("text-danger").addClass("text-success").show();
                } else {
                    let msg = "Cannot flush payment types";
                    if (rs.error) {
                        msg += (", error: " + rs.error);
                    } else {
                        msg += ", please check log file";
                    }
                    $('#update-payment-config-message').text(msg).removeClass("text-success").addClass("text-danger").show();
                }

                $('#update-payment-config').attr("disabled", false);
            }
        });
    });
//--></script>
<?php echo $footer; ?>