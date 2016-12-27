<?php
namespace App\Libs;

use App\Model\MAes;
use Exception;

/**
 * Created by IntelliJ IDEA.
 * User: nhancao
 * Date: 5/27/16
 * Time: 6:19 PM
 */
class AesCrypt
{
    public function aesDecrypt($blockSize, $inputKey, $inputMsg)
    {
        try {
            while (strlen($inputKey) < 16) {
                $inputKey .= "\0";
            }
            $aes = new MAes($inputMsg, $inputKey, $blockSize);
            $dec = $aes->decrypt();
            return $dec;
        } catch (Exception $e) {
            return $e->getMessage();
        }
    }

    public function aesEncrypt($blockSize, $inputKey, $inputMsg)
    {
        try {
            while (strlen($inputKey) < 16) {
                $inputKey .= "\0";
            }
            $aes = new MAes($inputMsg, $inputKey, $blockSize);
            $enc = $aes->encrypt();
            $aes->setData($enc);
            return $enc;
        } catch (Exception $e) {
            return $e->getMessage();
        }
    }
}
