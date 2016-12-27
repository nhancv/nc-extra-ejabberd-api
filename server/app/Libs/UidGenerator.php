<?php
/**
 * Created by IntelliJ IDEA.
 * User: nhancao
 * Date: 10/23/16
 * Time: 10:51 PM
 */

namespace App\Libs;


class UidGenerator
{
    /**Generate custom length unique id
     * @param int $length
     * @return mixed|string
     */
    public static function GeneratorUidL($length = 10)
    {
        //set the random id length
        $random_id_length = $length;
        //generate a random id encrypt it and store it in $rnd_id
        $hash = '$2y$07$BCryptRequires22Chrcte/VlQH0piJtjXl.0t1XkA8pw9dMXTpOq';
        $rnd_id = crypt(uniqid(rand(), 1), $hash);
        //to remove any slashes that might have come
        $rnd_id = strip_tags(stripslashes($rnd_id));
        //Removing any . or / and reversing the string
        $rnd_id = str_replace(".", "", $rnd_id);
        $rnd_id = strrev(str_replace("/", "", $rnd_id));
        //finally I take the first 10 characters from the $rnd_id
        $rnd_id = substr($rnd_id, 0, $random_id_length);
        return $rnd_id;
    }

    /**Generate uid with style unique id
     * @return string
     * XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX (8 letters)-(4 letters)-(4 letters)-(4 letters)-(12 letters)
     */
    public static function GeneratorUid()
    {
        $s = strtoupper(md5(uniqid(rand(), true)));
        $guidText =
            substr($s, 0, 8) . '-' .
            substr($s, 8, 4) . '-' .
            substr($s, 12, 4) . '-' .
            substr($s, 16, 4) . '-' .
            substr($s, 20);
        return $guidText;
    }

    /**
     * Gen next code with begin 1
     * @param int $length is number of 0
     * @return int
     */
    public static function GenNextCode($length = 5)
    {
        $min = '1';
        $max = '9';
        for ($i = 1; $i <= $length; $i++) {
            $min .= '0';
            $max .= '9';
        }
        return mt_rand(intval($min), intval($max));
    }

}