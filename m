Return-Path: <noname1.c@hotmail.com>
Received: from blu0-omc4-s12.blu0.hotmail.com (blu0-omc4-s12.blu0.hotmail.com
	[65.55.111.151]) by ozlabs.org (Postfix) with ESMTP id C3BC0DDDA0
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Feb 2009 01:46:18 +1100 (EST)
Message-ID: <BLU127-W16625432C3103A605192F9B5AA0@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_f09916dd-c62f-46b2-877c-f8c299d3507a_"
From: =?gb2312?B?z/LT7g==?= <noname1.c@hotmail.com>
To: <linuxppc-dev@ozlabs.org>
Subject: Confusing of using SPIE register in MPC8377E
Date: Fri, 27 Feb 2009 22:41:12 +0800
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--_f09916dd-c62f-46b2-877c-f8c299d3507a_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit


I'm writing a spi driver for MPC8377E.

I use a GPIO as the chip select signal.

I'm tring to use the NE or NF bits to decide when to read or when the transmit is over.

But I found that I have just write the command,the NE is set.Also I found that the transmit is not over the GPIO has been pulled up.

 

So I don't know what the real meaning of these two bits.Or it just indicates that the register can be write but not the operation has been over.

 

Can anyone give me a help?

Or anyone who has ever written the spi driver can give a source code for reference.

 

Thank you!

_________________________________________________________________
MSN新版在线社交网络，与您的MSN好友更全面互动！
http://im.live.cn/msn9/ 
--_f09916dd-c62f-46b2-877c-f8c299d3507a_
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
font-size: 10pt;
font-family:Verdana
}
</style>
</head>
<body class='hmmessage'>
I'm writing a spi driver for&nbsp;MPC8377E.<BR>
I use a GPIO as the chip select signal.<BR>
I'm&nbsp;tring to&nbsp;use&nbsp;the&nbsp;NE or NF bits to decide when to read or when&nbsp;the transmit is over.<BR>
But&nbsp;I&nbsp;found that I have just write the command,the NE is set.Also I&nbsp;found that the transmit is not over the GPIO has been pulled up.<BR>
&nbsp;<BR>
So I&nbsp;don't know what&nbsp;the real&nbsp;meaning of these two bits.Or it just&nbsp;indicates that&nbsp;the register can be&nbsp;write but not the operation has been over.<BR>
&nbsp;<BR>
Can anyone give me a help?<BR>
Or anyone who has ever written the spi driver can give a source code for reference.<BR>
&nbsp;<BR>
Thank you!<BR><br /><hr />MSN 9.0 正式版上线，捆绑免费25G网络硬盘！ <a href='http://im.live.cn/msn9/' target='_new'>立刻下载！</a></body>
</html>
--_f09916dd-c62f-46b2-877c-f8c299d3507a_--
