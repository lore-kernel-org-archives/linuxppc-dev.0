Return-Path: <eemingliu@hotmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 1126CB7100
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  1 Jul 2009 20:24:38 +1000 (EST)
Received: from col0-omc2-s12.col0.hotmail.com (col0-omc2-s12.col0.hotmail.com
	[65.55.34.86]) by ozlabs.org (Postfix) with ESMTP id 8EDC3DDD1B
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Jul 2009 20:24:37 +1000 (EST)
Message-ID: <COL107-W41E84129BE81739BC96295B22E0@phx.gbl>
Content-Type: multipart/alternative;
	boundary="_6f5c4520-7b72-4b2a-9fa4-90e5d39b17ba_"
From: LiuMing <eemingliu@hotmail.com>
To: <lada.podivin@gmail.com>, <linuxppc-dev@ozlabs.org>
Subject: RE: ppc405ex + gigabit ethernet
Date: Wed, 1 Jul 2009 10:19:28 +0000
In-Reply-To: <e35801cc0906300658q45d5ea00ub939ba73185efd72@mail.gmail.com>
References: <e35801cc0906300658q45d5ea00ub939ba73185efd72@mail.gmail.com>
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--_6f5c4520-7b72-4b2a-9fa4-90e5d39b17ba_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 8bit


Hi,

According to our experience on PPC405 + Gigabit Enet, your result is already very reasonable. For UDP transmission, it can be around 400 Kb/s because of the CPU bottleneck (in our case 300 MHz ppc405). If you want to further improve it, a faster CPU is needed to process the TCP/IP stack, or you may buy commercial TCP/IP stack rather than using the free Linux one. 

 

BR

Ming
 


Date: Tue, 30 Jun 2009 15:58:53 +0200
Subject: ppc405ex + gigabit ethernet
From: lada.podivin@gmail.com
To: linuxppc-dev@ozlabs.org

Hi,

I benchmarked performance of my network, which contains ppc405EX (Kilauea board, kernel 2.6.30 from Denx) connected with a linux desktop via gigabit ethernet. I used the netperf tool: 

netperf -t UDP_STREAM -H 192.168.1.1 -- -m 32768

So I was sending UDP packets to the desktop. The resulting speed was about 370 Kb/s. I tried to send the packets to several different computers - with the same result. So the ppc board is the bottleneck in this case.

Is there any possibility to improve the gigabit capabilities of the ppc405EX? Is there anyone who achieved a better performance with ppc4xx boards?

Thanks!

Best,
Lada Podivin


_________________________________________________________________
MSN 表情魔法书，改变你的对话时代！
http://im.live.cn/emoticons/
--_6f5c4520-7b72-4b2a-9fa4-90e5d39b17ba_
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
Hi,<BR>
According to our experience on PPC405 + Gigabit Enet, your result is already very reasonable. For UDP transmission, it can be around 400 Kb/s because of the&nbsp;CPU bottleneck (in our case 300 MHz ppc405). If you want to&nbsp;further improve it, a faster CPU is needed to process the TCP/IP stack, or you may buy&nbsp;commercial TCP/IP stack&nbsp;rather than using the free Linux one. <BR>
&nbsp;<BR>
BR<BR>
Ming<BR>&nbsp;<BR>
<HR id=stopSpelling>
Date: Tue, 30 Jun 2009 15:58:53 +0200<BR>Subject: ppc405ex + gigabit ethernet<BR>From: lada.podivin@gmail.com<BR>To: linuxppc-dev@ozlabs.org<BR><BR>Hi,<BR><BR>I benchmarked performance of my network, which contains ppc405EX (Kilauea board, kernel 2.6.30 from Denx) connected with a linux desktop via gigabit ethernet. I used the netperf tool: <BR><BR>netperf -t UDP_STREAM -H 192.168.1.1 -- -m 32768<BR><BR>So I was sending UDP packets to the desktop. The resulting speed was about 370 Kb/s. I tried to send the packets to several different computers - with the same result. So the ppc board is the bottleneck in this case.<BR><BR>Is there any possibility to improve the gigabit capabilities of the ppc405EX? Is there anyone who achieved a better performance with ppc4xx boards?<BR><BR>Thanks!<BR><BR>Best,<BR>Lada Podivin<BR><BR><br /><hr />立刻下载 MSN 保护盾，保障 MSN 安全稳定！ <a href='http://im.live.cn/safe/' target='_new'>现在就下载！</a></body>
</html>
--_6f5c4520-7b72-4b2a-9fa4-90e5d39b17ba_--
