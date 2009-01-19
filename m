Return-Path: <noname1.c@hotmail.com>
Received: from blu0-omc4-s8.blu0.hotmail.com (blu0-omc4-s8.blu0.hotmail.com
	[65.55.111.147]) by ozlabs.org (Postfix) with ESMTP id 6E245DDF2F
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Jan 2009 21:52:56 +1100 (EST)
Message-ID: <BLU127-W329ABEB411D1862CA610B9B5D30@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_beed88d8-759a-40b3-8bee-4337e111c456_"
From: =?gb2312?B?z/LT7g==?= <noname1.c@hotmail.com>
To: <linuxppc-dev@ozlabs.org>
Subject: MPC8313 init ram
Date: Mon, 19 Jan 2009 18:52:55 +0800
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--_beed88d8-759a-40b3-8bee-4337e111c456_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit


Now i'm porting the u-boot to my board refer to the mpc8313erdb.
I see that in the header file mpc8313erdb.h there is a define: 
#define CFG_INIT_RAM_ADDR 0xFD000000
In the memory map ,this address does not locate at any window.
So what is the ram?
_________________________________________________________________
MSN9.0正式版让您轻松关注好友动态，展现精彩自我。
http://im.live.cn/msn9/ 
--_beed88d8-759a-40b3-8bee-4337e111c456_
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
Now i'm porting the u-boot to my board refer to the mpc8313erdb.<BR>
I see that in the header file mpc8313erdb.h there is a define: <BR>
#define CFG_INIT_RAM_ADDR&nbsp;0xFD000000<BR>
In the memory map ,this address&nbsp;does not locate at any window.<BR>
So what is the ram?<RTE_TEXT></RTE_TEXT><BR><br /><hr />更多热辣资讯尽在新版MSN首页！ <a href='http://cn.msn.com/' target='_new'>立刻访问！</a></body>
</html>
--_beed88d8-759a-40b3-8bee-4337e111c456_--
