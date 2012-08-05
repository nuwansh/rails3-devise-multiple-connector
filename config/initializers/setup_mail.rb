ActionMailer::Base.perform_deliveries = true
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
    :address    => "",
    :port       => 25,
    :user_name  => "",
    :password   => "",
    :domain     => ""
     
}

# Turn off auto TLS for e-mail
ActionMailer::Base.smtp_settings[:enable_starttls_auto] = false

