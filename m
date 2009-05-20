Return-Path: <hong-jun.chen@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3D047DE153
	for <linuxppc-dev@ozlabs.org>; Wed, 20 May 2009 10:40:00 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n4K0dhVv022269
	for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2009 17:39:55 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id n4K0dfWC020013
	for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2009 19:39:42 -0500 (CDT)
Date: Wed, 20 May 2009 08:39:37 +0800
From: "=?utf-8?B?SG9uZ2p1biBDaGVu?=" <hong-jun.chen@freescale.com>
To: "=?utf-8?B?UGlvdHIgWmnEmWNpaw==?=" <kosmo@semihalf.com>,
	"=?utf-8?B?Sm9obiBSaWdieQ==?=" <jrigby@gmail.com>
References: <1241640919-4650-12-git-send-email-wd@denx.de>
	<200905190937411866001@freescale.com>
	<200905191003.42964.kosmo@semihalf.com>
Subject: =?utf-8?B?UmU6IFJlOiBbUEFUQ0ggMTEvMTJdIG1wYzUxMjE6IEFkZGVkIE1QQzUxMnggRE1BIGRyaXZlci4=?=
Message-ID: <200905200839363701969@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="=====003_Dragon718532387783_====="
Cc: =?utf-8?B?bGludXhwcGMtZGV2QG96bGFicy5vcmc=?= <linuxppc-dev@ozlabs.org>,
	=?utf-8?B?V29sZmdhbmcgRGVuaw==?= <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


This is a multi-part message in MIME format.

--=====003_Dragon718532387783_=====
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 8bit

Hi John,

Did you use DMA driver in our FEC driver before?

Best Regards,



Hongjun Chen
2009-05-20



发件人： Piotr Zięcik
发送时间： 2009-05-19 16:05:05
收件人： Hongjun Chen
抄送： Wolfgang Denk; linuxppc-dev@ozlabs.org
主题： Re: [PATCH 11/12] mpc5121: Added MPC512x DMA driver.

Tuesday 19 May 2009 03:37:47 Hongjun Chen wrote:
> Since you have reuse most part of our BSP, why should you reinvent wheel
> for MPC512x DMA? We have one ready DMA driver, which has been used by AC97,
> ATA, VIU etc.
>

Answer is simple. The old one does not fit Linux DMA API. New one uses 
existing infrastructure which makes DMA engine aviable for existing consumers
in Linux kernel. For example network stack. Support for I/O  <- > memory 
transfers will be added when more consumers arrive.

-- 
Best Regards.
Piotr Zięcik

--=====003_Dragon718532387783_=====
Content-Type: text/html;
	charset="utf-8"
Content-Transfer-Encoding: 8bit

﻿<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=Content-Type content="text/html; charset=utf-8">
<META content="MSHTML 6.00.2900.3492" name=GENERATOR>
<STYLE>
<!--
 /* Font Definitions */
 @font-face
	{font-family:宋体;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Verdana;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
@font-face
	{font-family:"\@宋体";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	text-align:justify;
	text-justify:inter-ideograph;
	font-size:10.5pt;
	font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:Verdana;
	color:windowtext;
	font-weight:normal;
	font-style:normal;
	text-decoration:none none;}
 /* Page Definitions */
 @page Section1
	{size:595.3pt 841.9pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;
	layout-grid:15.6pt;}
div.Section1
	{page:Section1;}
-->
</STYLE>
</HEAD>
<BODY>
<DIV><FONT face=Verdana color=#0000ff size=2>Hi John,</FONT></DIV>
<DIV><FONT face=Verdana color=#0000ff size=2></FONT>&nbsp;</DIV>
<DIV><FONT face=Verdana color=#0000ff size=2>Did you use DMA driver in our FEC 
driver before?</FONT></DIV>
<DIV><FONT face=Verdana size=2></FONT>&nbsp;</DIV>
<DIV><FONT face=Verdana color=#0000ff size=2>Best Regards,</FONT></DIV>
<DIV align=left>
<DIV align=left><FONT face=Verdana size=2>
<HR style="WIDTH: 122px; HEIGHT: 2px" SIZE=2>
</FONT></DIV>
<DIV><FONT color=#c0c0c0><FONT face=Verdana size=2>Hongjun Chen</FONT></DIV>
<DIV><FONT face=Verdana size=2>2009-05-20</FONT></FONT></DIV></DIV>
<DIV><FONT face=Verdana size=2>
<HR>
</FONT></DIV>
<DIV><FONT face=Verdana><FONT size=2><STRONG>发件人：</STRONG> Piotr 
Zięcik</FONT></FONT></DIV>
<DIV><FONT face=Verdana><FONT size=2><STRONG>发送时间：</STRONG> 
2009-05-19&nbsp;16:05:05</FONT></FONT></DIV>
<DIV><FONT face=Verdana><FONT size=2><STRONG>收件人：</STRONG> Hongjun 
Chen</FONT></FONT></DIV>
<DIV><FONT face=Verdana><FONT size=2><STRONG>抄送：</STRONG> Wolfgang Denk; 
linuxppc-dev@ozlabs.org</FONT></FONT></DIV>
<DIV><FONT face=Verdana><FONT size=2><STRONG>主题：</STRONG> Re: [PATCH 11/12] 
mpc5121: Added MPC512x DMA driver.</FONT></FONT></DIV>
<DIV><FONT face=Verdana size=2></FONT>&nbsp;</DIV>
<DIV><FONT face=Verdana size=2>
<DIV>Tuesday&nbsp;19&nbsp;May&nbsp;2009&nbsp;03:37:47&nbsp;Hongjun&nbsp;Chen&nbsp;wrote:</DIV>
<DIV>&gt;&nbsp;Since&nbsp;you&nbsp;have&nbsp;reuse&nbsp;most&nbsp;part&nbsp;of&nbsp;our&nbsp;BSP,&nbsp;why&nbsp;should&nbsp;you&nbsp;reinvent&nbsp;wheel</DIV>
<DIV>&gt;&nbsp;for&nbsp;MPC512x&nbsp;DMA?&nbsp;We&nbsp;have&nbsp;one&nbsp;ready&nbsp;DMA&nbsp;driver,&nbsp;which&nbsp;has&nbsp;been&nbsp;used&nbsp;by&nbsp;AC97,</DIV>
<DIV>&gt;&nbsp;ATA,&nbsp;VIU&nbsp;etc.</DIV>
<DIV>&gt;</DIV>
<DIV>&nbsp;</DIV>
<DIV>Answer&nbsp;is&nbsp;simple.&nbsp;The&nbsp;old&nbsp;one&nbsp;does&nbsp;not&nbsp;fit&nbsp;Linux&nbsp;DMA&nbsp;API.&nbsp;New&nbsp;one&nbsp;uses&nbsp;</DIV>
<DIV>existing&nbsp;infrastructure&nbsp;which&nbsp;makes&nbsp;DMA&nbsp;engine&nbsp;aviable&nbsp;for&nbsp;existing&nbsp;consumers</DIV>
<DIV>in&nbsp;Linux&nbsp;kernel.&nbsp;For&nbsp;example&nbsp;network&nbsp;stack.&nbsp;Support&nbsp;for&nbsp;I/O&nbsp; 
&lt;- &gt;&nbsp;memory&nbsp;</DIV>
<DIV>transfers&nbsp;will&nbsp;be&nbsp;added&nbsp;when&nbsp;more&nbsp;consumers&nbsp;arrive.</DIV>
<DIV>&nbsp;</DIV>
<DIV>--&nbsp;</DIV>
<DIV>Best&nbsp;Regards.</DIV>
<DIV>Piotr&nbsp;Zięcik</DIV></FONT></DIV></BODY></HTML>

--=====003_Dragon718532387783_=====--
