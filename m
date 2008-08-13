Return-Path: <zhulida@hotmail.com>
Received: from bay0-omc2-s23.bay0.hotmail.com (bay0-omc2-s23.bay0.hotmail.com
	[65.54.246.159]) by ozlabs.org (Postfix) with ESMTP id 16E26DDEEF
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Aug 2008 12:36:42 +1000 (EST)
Message-ID: <BAY124-W9083C9195E48CB3FE15FBA8730@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_d8107e38-3b1d-4432-807f-0f6d23042575_"
From: =?gb2312?B?1uzA+7Tv?= <zhulida@hotmail.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: serial problem of cpm2
Date: Wed, 13 Aug 2008 10:36:41 +0800
MIME-Version: 1.0
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--_d8107e38-3b1d-4432-807f-0f6d23042575_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit


hi everybody:  These days a problem drive me to read the code about mpc8247 cpm2 smc or scc uart.The problem is that, very very occasionally when my system bring up, I find the serial port can not work. The serial port connects with smc1 and is a console port. when the problem occured, the tx of smc1 is still ok. I send 'break' to the port, and dump the register of smc . The indicators of 'break' len and 'break' times show it reciverd thesignal. Catting /proc/interrupts I find the interrupts counter do not increase.It seemed the irq of smc disabled by systerm. Somehow, when the problem occured, there were a lot of 'break' signal recived the serial port, maybe this is hardware mistake.And the mistake lead the problem. 
       Do anyone troubled with these problem?
_________________________________________________________________
用手机MSN聊天写邮件看空间，无限沟通，分享精彩！
http://mobile.msn.com.cn/
--_d8107e38-3b1d-4432-807f-0f6d23042575_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: 8bit

<html>
<head>
<style>
.hmmessage P
{
margin:0px;
padding:0px
}
body.hmmessage
{
FONT-SIZE: 9pt;
FONT-FAMILY:Tahoma
}
</style>
</head>
<body class='hmmessage'>
<FONT size=4>hi everybody:<BR>&nbsp; These days a problem drive me to read the code about mpc8247 cpm2 smc or scc uart.<BR>The problem is that, very very occasionally when my system bring up, I find the serial <BR>port can not work. The serial port connects with smc1 and is a console port. when the <BR>problem occured, the tx of smc1 is still ok. I send 'break' to the port, and dump the <BR>register of smc . The indicators of 'break' len and 'break' times show it reciverd the<BR>signal. Catting /proc/interrupts I find the interrupts counter do not increase.<BR>It seemed the irq of smc disabled by systerm. Somehow, when the problem occured, there <BR>were a lot of 'break' signal recived the serial port, maybe this is hardware mistake.<BR>And the mistake lead the problem. </FONT><BR>
<FONT size=4>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Do anyone troubled with these problem?</FONT><BR><br /><hr />各位明星最近怎么样？人气榜为您奉上最新动态！ <a href='http://cnweb.search.live.com/xrank/?Form=MEVHAA' target='_new'>现在就看看！</a></body>
</html>
--_d8107e38-3b1d-4432-807f-0f6d23042575_--
