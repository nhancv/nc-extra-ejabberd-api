<?php
/**
 * Created by IntelliJ IDEA.
 * User: nhancao
 * Date: 10/24/16
 * Time: 10:54 PM
 */

namespace App\Libs;


use Illuminate\Support\Facades\DB;
use PHPMailer;

class Util
{
    public static function sendEmail($email, $subject, $body, $forwardAdmin = false)
    {
        $mail = new PHPMailer();
        $mail->isSMTP();
        $mail->SMTPOptions = array(
            'ssl' => array(
                'verify_peer' => false,
                'verify_peer_name' => false,
                'allow_self_signed' => true
            )
        );
        $mail->CharSet = 'UTF-8';
        $mail->Host = env('EMAIL_HOST', '');
        $mail->Port = (int)env('EMAIL_PORT', 0);
        $mail->SMTPAuth = true;
        $mail->Username = env('EMAIL_USERNAME', '');
        $mail->Password = env('EMAIL_PASSWORD', '');
        $mail->From = env('EMAIL_FROM', '');
        $mail->FromName = env('EMAIL_FROM_NAME', '');
        if ($forwardAdmin) {
            $mail->addReplyTo(env('EMAIL_ADMIN', ''));
        }
        $mail->WordWrap = 50;
        $mail->isHTML(true);
        $mail->addAddress($email);
        $mail->Subject = $subject;
        $mail->Body = $body;
        $mailSend = $mail->send();
        $mail->smtpClose();
        return $mailSend;
    }

}