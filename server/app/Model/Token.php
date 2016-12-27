<?php
/**
 * Created by IntelliJ IDEA.
 * User: nhancao
 * Date: 11/6/16
 * Time: 4:16 PM
 */

namespace App\Model;


class Token
{
    private $id;
    private $createTime;

    /**
     * Token constructor.
     * @param $id
     * @param $createTime
     */
    public function __construct($id, $createTime)
    {
        $this->id = $id;
        $this->createTime = $createTime;
    }

    /**
     * @return mixed
     */
    public function getId()
    {
        return $this->id;
    }

    /**
     * @return mixed
     */
    public function getCreateTime()
    {
        return $this->createTime;
    }

    public function getResponse()
    {
        $res = array();
        $res["id"] = $this->getId();
        $res["createTime"] = $this->getCreateTime();
        return $res;
    }


}