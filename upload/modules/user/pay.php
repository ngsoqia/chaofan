<?php
defined('_VALID') or die('Restricted Access!');
require $config['BASE_DIR']. '/classes/filter.class.php';

// Added to enforce these paths
$basedir = dirname(dirname(dirname(__FILE__)));
$config['BASE_DIR'] 	= $basedir;
$config['LOG_DIR'] 		= $basedir.'/tmp/logs';
$payType = 0;		// 1: 卡级别高升级    2: 卡级别低

if ( isset($_POST['submit_card_pay']) ) {
    $filter     = new VFilter();
    $card_number = $filter->get('card_number');
    $card_pass   = $filter->get('card_pass');
    $confirmInfo = $filter->get('confirm_info');

    if ( $card_number == '' ) {
        $errors[]           = '请输入充值卡号！';
    } else {
        $card['number'] = $card_number;
    }

    if ( $card_pass == '' ) {
        $errors[]           = '请输入充值卡密码！';
    } else {
        $card['pass']  = $card_pass;
    }

    if ( !$errors ) {
        $sql = "select * from user_card where number='" . $card['number'] . "' and pass='" . $card['pass'] . "'";
        $rs = $conn->execute($sql);
		$cards = $rs->getrows();
		if(count($cards)==0){
			$errors[]   = '输入的充值卡账号或密码错误！';
		}
		if ( !$errors ) {
			$card   = $cards[0];
			if($card['used']==1){
				$errors[]   = '该充值卡已被使用！';
			}
			if($user['vip_level']==7){
				$errors[]   = '您已经是终生超级VIP，无需再进行充值！';
			}
			if(!$errors){
				$conn->StartTrans();
				if(intval($user['vip_level'])<3){
					// 原来是普通会员
					$vipTime = time();
					if($card['card_type']==1){
						$vipTime += 30*24*60*60;
					}else{
						$vipTime += 365*24*60*60;
					}
					$sql = "UPDATE signup SET vip_level='" . $card['vip_level'] . "', vip_time='" . $vipTime . "' WHERE UID = " .$uid;
					$conn->execute($sql);
					$user['vip_time'] = $vipTime;
					$user['vip_level'] = $card['vip_level'];
				}else if(intval($card['vip_level']) == intval($user['vip_level'])){
					// 续时
					$vipTime = $user['vip_time'];
					if($card['card_type']==1){
						$vipTime += 30*24*60*60;
					}else{
						$vipTime += 365*24*60*60;
					}
					$sql = "UPDATE signup SET vip_level='" . $card['vip_level'] . "', vip_time='" . $vipTime . "' WHERE UID = " .$uid;
					$conn->execute($sql);
					$user['vip_time'] = $vipTime;
				}else if(intval($card['vip_level']) > intval($user['vip_level'])){
					if($card['vip_level']==7){
						// 7级，终身VIP
						$vipTime = time()*2;
						$sql = "UPDATE signup SET vip_level='" . $card['vip_level'] . "', vip_time='" . $vipTime . "' WHERE UID = " .$uid;
						$conn->execute($sql);
						$user['vip_time'] = $vipTime;
						$user['vip_level'] = $card['vip_level'];
					}else{
						// 升级VIP，原时间折合成高级VIP时间
						$payType = 1;
						$radio = 1.0 * $config['level_price_'.$user['vip_level']] / $config['level_price_'.$card['vip_level']];
						$errors[] = $radio;
						$vipTimeDlta = ($user['vip_time'] - time()) * $radio;
						$vipTime = $user['vip_time'];
						if($card['card_type']==1){
							$vipTime = time() + 30*24*60*60 + $vipTimeDlta;
						}else{
							$vipTime = time() + 365*24*60*60 + $vipTimeDlta;
						}
						$sql = "UPDATE signup SET vip_level='" . $card['vip_level'] . "', vip_time='" . $vipTime . "' WHERE UID = " .$uid;
						$conn->execute($sql);
						$user['vip_time'] = $vipTime;
						$user['vip_level'] = $card['vip_level'];
					}
				}else if(intval($card['vip_level']) < intval($user['vip_level'])){
					// VIP不变，充值卡时间折合成当前用户等级时间
					$payType = 0;
					$radio = 1.0 * $config['level_price_'.$card['vip_level']] / $config['level_price_'.$user['vip_level']];
					$errors[] = $radio;
					$vipTimeDlta = 0;
					if($card['card_type']==1){
						$vipTimeDlta = 30*24*60*60 * $radio;
					}else{
						$vipTimeDlta = 365*24*60*60 * $radio;
					}
					$vipTime = $user['vip_time'] + $vipTimeDlta;
					$sql = "UPDATE signup SET vip_time='" . $vipTime . "' WHERE UID = " .$uid;
					$conn->execute($sql);
					$user['vip_time'] = $vipTime;
				}
				$sql = "UPDATE user_card SET used='1', user_id='" . $uid. "', usetime='" . time() . "' where id=" . $card['id'];
				$conn->execute($sql);
				//$conn->RollbackTrans();
				
				$ret = $conn->CompleteTrans();
				if($ret){
					$messages[] = '充值成功！';
				}else{
					$errors[]   = '充值失败！';
				}
			}
            
        }
    }
}

if(!isset($confirmInfo)){
	$smarty->assign('pay_type', $payType);
}
$smarty->assign('card', $card);
?>
