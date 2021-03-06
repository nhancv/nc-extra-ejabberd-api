<?php
namespace App\Model;
use Exception;

/**
 * Created by IntelliJ IDEA.
 * User: nhancao
 * Date: 5/9/16
 * Time: 5:03 PM
 */
class MAes
{
    const M_CBC = 'cbc';
    const M_CFB = 'cfb';
    const M_ECB = 'ecb';
    const M_NOFB = 'nofb';
    const M_OFB = 'ofb';
    const M_STREAM = 'stream';

    protected $key;
    protected $cipher;
    protected $data;
    protected $mode;
    protected $IV;

    /**
     *
     * @param type $data
     * @param type $key
     * @param type $blockSize
     * @param type $mode
     */
    function __construct($data = null, $key = null, $blockSize = null, $mode = null)
    {
        $this->setData($data);
        $this->setKey($key);
        $this->setBlockSize($blockSize);
        $this->setMode($mode);
        $this->setIV("");
    }

    /**
     *
     * @param type $data
     */
    public function setData($data)
    {
        $this->data = $data;
    }

    /**
     *
     * @param type $key
     */
    public function setKey($key)
    {
        $this->key = $key;
    }

    /**
     *
     * @param type $blockSize
     */
    public function setBlockSize($blockSize)
    {
        switch ($blockSize) {
            case 128:
                $this->cipher = MCRYPT_RIJNDAEL_128;
                break;

            case 192:
                $this->cipher = MCRYPT_RIJNDAEL_192;
                break;

            case 256:
                $this->cipher = MCRYPT_RIJNDAEL_256;
                break;
        }
    }

    /**
     *
     * @param type $mode
     */
    public function setMode($mode)
    {
        switch ($mode) {
            case MAes::M_CBC:
                $this->mode = MCRYPT_MODE_CBC;
                break;
            case MAes::M_CFB:
                $this->mode = MCRYPT_MODE_CFB;
                break;
            case MAes::M_ECB:
                $this->mode = MCRYPT_MODE_ECB;
                break;
            case MAes::M_NOFB:
                $this->mode = MCRYPT_MODE_NOFB;
                break;
            case MAes::M_OFB:
                $this->mode = MCRYPT_MODE_OFB;
                break;
            case MAes::M_STREAM:
                $this->mode = MCRYPT_MODE_STREAM;
                break;
            default:
                $this->mode = MCRYPT_MODE_ECB;
                break;
        }
    }

    /**
     * @return type
     * @throws Exception
     */
    public function encrypt()
    {

        if ($this->validateParams()) {
            return trim(base64_encode(
                mcrypt_encrypt(
                    $this->cipher, $this->key, $this->data, $this->mode, $this->getIV())));
        } else {
            throw new Exception('Invlid params!');
        }
    }

    /**
     *
     * @return boolean
     */
    public function validateParams()
    {
        if ($this->data != null &&
            $this->key != null &&
            $this->cipher != null
        ) {
            return true;
        } else {
            return FALSE;
        }
    }

    protected function getIV()
    {
        if ($this->IV == "") {
            $this->IV = mcrypt_create_iv(mcrypt_get_iv_size($this->cipher, $this->mode), MCRYPT_RAND);
        }
        return $this->IV;
    }

    public function setIV($IV)
    {
        $this->IV = $IV;
    }

    /**
     *
     * @return type
     * @throws Exception
     */
    public function decrypt()
    {
        if ($this->validateParams()) {
            return trim(mcrypt_decrypt(
                $this->cipher, $this->key, base64_decode($this->data), $this->mode, $this->getIV()));
        } else {
            throw new Exception('Invlid params!');
        }
    }

}
