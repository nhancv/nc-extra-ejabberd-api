<?php
/**
 * Created by IntelliJ IDEA.
 * User: nhancao
 * Date: 10/14/16
 * Time: 11:34 PM
 */

namespace App\Libs;


class Jsonx
{
    public static function json_encode_utf8($struct)
    {
        return preg_replace("/\\\\u([a-f0-9]{4})/e", "iconv('UCS-4LE','UTF-8',pack('V', hexdec('U$1')))", json_encode($struct));
    }

    public static function json_decode_nice($json, $assoc = FALSE)
    {
        $json = str_replace(array("\n", "\r"), "", $json);
        $json = preg_replace('/([{,]+)(\s*)([^"]+?)\s*:/', '$1"$3":', $json);
        $res = json_decode($json, $assoc);
        return $res;
    }
}