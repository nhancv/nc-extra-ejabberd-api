<?php
/**
 * Created by IntelliJ IDEA.
 * User: nhancao
 * Date: 12/25/16
 * Time: 11:17 AM
 */

namespace App\Libs;


use Exception;
use Illuminate\Http\Response;

class HeaderResponse
{
    public static function downloadHeader($fileSize, $fileName)
    {
        try {
            $allowOrigin = $_SERVER['HTTP_ORIGIN'];
        } catch (Exception $e) {
            $allowOrigin = env('CLIENT_HOST', 'localhost');
        }
        header('Access-Control-Allow-Origin: ' . $allowOrigin);
        header('Access-Control-Allow-Credentials: true');
        header('Access-Control-Allow-Methods: HEAD, GET, POST, PUT, PATCH, DELETE');
        header('Content-Description: File Transfer');
        header('Content-Type: application/octet-stream');
        header('Content-Disposition: attachment; filename="' . $fileName . '"');
        header('Expires: 0');
        header('Cache-Control: must-revalidate');
        header('Pragma: public');
        header('Content-Length: ' . $fileSize);
    }

    public static function closeHeader()
    {
        try {
            $allowOrigin = $_SERVER['HTTP_ORIGIN'];
        } catch (Exception $e) {
            $allowOrigin = env('CLIENT_HOST', 'localhost');
        }
        header('Access-Control-Allow-Origin: ' . $allowOrigin);
        header('Access-Control-Allow-Credentials: true');
        header('Access-Control-Allow-Methods: HEAD, GET, POST, PUT, PATCH, DELETE');
        header('Access-Control-Allow-Headers: Origin, Content-Type, Accept');
        header('Access-Control-Max-Age: 86400');
        header('Content-Type: application/json;charset=UTF-8');
        header('X-Content-Type-Options: nosniff');
        header('X-Frame-Options: SAMEORIGIN');
        header('X-XSS-Protection: 1; mode=block');

    }

    public static function normalHeader(Response $response)
    {
        try {
            $allowOrigin = $_SERVER['HTTP_ORIGIN'];
        } catch (Exception $e) {
            $allowOrigin = env('CLIENT_HOST', 'localhost');
        }

        return $response
            ->header('Access-Control-Allow-Origin', $allowOrigin)
            ->header('Access-Control-Allow-Credentials', 'true')
            ->header('Access-Control-Allow-Methods', 'HEAD, GET, POST, PUT, PATCH, DELETE')
            ->header('Access-Control-Allow-Headers', 'Origin, Content-Type, Accept')
            ->header('Access-Control-Max-Age', '86400')//1 day
            ->header('Content-Type', 'application/json;charset=UTF-8')
            ->header('X-Content-Type-Options', 'nosniff')
            ->header('X-Frame-Options', 'SAMEORIGIN')
            ->header('X-XSS-Protection', '1; mode=block');
    }

    public static function mobileHeader(Response $response)
    {
        return self::normalHeader($response)
            ->header('Accept', 'application/yk-mobile+json');
    }

    public static function webHeader(Response $response)
    {
        return self::webHeader($response)
            ->header('Accept', 'application/yk-web+json');
    }

}