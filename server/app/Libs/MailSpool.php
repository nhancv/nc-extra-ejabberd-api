<?php
/**
 * Created by IntelliJ IDEA.
 * User: nhancao
 * Date: 12/12/16
 * Time: 10:49 PM
 */

namespace App\Libs;


class MailSpool
{
    public static $mails = [];

    public static function addMail($to, $subject, $message)
    {
        self::$mails[] = ['to' => $to, 'subject' => $subject, 'message' => $message];
    }

    public static function send()
    {
        foreach (self::$mails as $mail) {
            Util::sendEmail($mail['to'], $mail['subject'], $mail['message']);
        }
        self::$mails = [];
    }
}

/*
 //In your script you can call anywhere
MailSpool::addMail('contact@example.com', 'Hello', 'Hello from the spool');

register_shutdown_function('App\Libs\MailSpool::send');
or

register_shutdown_function(function(){
    MailSpool::send();
});

exit(); // You need to call this to send the response immediately
 */