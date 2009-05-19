Return-Path: <hong-jun.chen@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BAA99DE0C9
	for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2009 11:39:59 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n4J1dsGY009143
	for <linuxppc-dev@ozlabs.org>; Mon, 18 May 2009 18:39:55 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n4J1dqTL007596
	for <linuxppc-dev@ozlabs.org>; Mon, 18 May 2009 20:39:53 -0500 (CDT)
Date: Tue, 19 May 2009 09:37:47 +0800
From: "Hongjun Chen" <r66092@freescale.com>
To: "Wolfgang Denk" <wd@denx.de>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
References: <1241640919-4650-12-git-send-email-wd@denx.de>
Subject: Re: [PATCH 11/12] mpc5121: Added MPC512x DMA driver.
Message-ID: <200905190937411866001@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="=====003_Dragon268623510562_====="
Cc: Piotr Ziecik <kosmo@semihalf.com>, Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


This is a multi-part message in MIME format.

--=====003_Dragon268623510562_=====
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 8bit

Since you have reuse most part of our BSP, why should you reinvent wheel for MPC512x DMA? We have one ready DMA driver, which has been used by AC97, ATA, VIU etc.




Hongjun Chen
2009-05-19



发件人： Wolfgang Denk
发送时间： 2009-05-07 04:15:18
收件人： linuxppc-dev@ozlabs.org
抄送： Piotr Ziecik; Wolfgang Denk
主题： [PATCH 11/12] mpc5121: Added MPC512x DMA driver.

From: Piotr Ziecik <kosmo@semihalf.com>

This patch adds initial version of MPC512x DMA driver.
Only memory to memory transfers are currenly supported.

Signed-off-by: Piotr Ziecik <kosmo@semihalf.com>
Signed-off-by: Wolfgang Denk <wd@denx.de>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: John Rigby <jcrigby@gmail.com>
---
 arch/powerpc/boot/dts/mpc5121ads.dts         |    2 +-
 arch/powerpc/platforms/512x/mpc512x_shared.c |    1 +
 drivers/dma/Kconfig                          |    7 +
 drivers/dma/Makefile                         |    1 +
 drivers/dma/mpc512x_dma.c                    |  642 ++++++++++++++++++++++++++
 drivers/dma/mpc512x_dma.h                    |  192 ++++++++
 6 files changed, 844 insertions(+), 1 deletions(-)
 create mode 100644 drivers/dma/mpc512x_dma.c
 create mode 100644 drivers/dma/mpc512x_dma.h
_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-dev

--=====003_Dragon268623510562_=====
Content-Type: text/html;
	charset="gb2312"
Content-Transfer-Encoding: 8bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=Content-Type content="text/html; charset=gb2312">
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
<DIV><FONT face=Verdana color=#0000ff size=2>Since you have reuse most part of 
our BSP, why should&nbsp;you reinvent wheel for MPC512x DMA? We have one 
ready&nbsp;DMA driver, which has been used by AC97, ATA, VIU etc.</FONT></DIV>
<DIV><FONT face=Verdana size=2></FONT>&nbsp;</DIV>
<DIV align=left>
<DIV align=left><FONT face=Verdana size=2>
<HR style="WIDTH: 122px; HEIGHT: 2px" SIZE=2>
</FONT></DIV>
<DIV><FONT color=#c0c0c0><FONT face=Verdana size=2>Hongjun Chen</FONT></DIV>
<DIV><FONT face=Verdana size=2>2009-05-19</FONT></FONT></DIV></DIV>
<DIV><FONT face=Verdana size=2>
<HR>
</FONT></DIV>
<DIV><FONT face=Verdana><FONT size=2><STRONG>发件人：</STRONG> Wolfgang 
Denk</FONT></FONT></DIV>
<DIV><FONT face=Verdana><FONT size=2><STRONG>发送时间：</STRONG> 
2009-05-07&nbsp;04:15:18</FONT></FONT></DIV>
<DIV><FONT face=Verdana><FONT size=2><STRONG>收件人：</STRONG> 
linuxppc-dev@ozlabs.org</FONT></FONT></DIV>
<DIV><FONT face=Verdana><FONT size=2><STRONG>抄送：</STRONG> Piotr Ziecik; Wolfgang 
Denk</FONT></FONT></DIV>
<DIV><FONT face=Verdana><FONT size=2><STRONG>主题：</STRONG> [PATCH 11/12] mpc5121: 
Added MPC512x DMA driver.</FONT></FONT></DIV>
<DIV><FONT face=Verdana size=2></FONT>&nbsp;</DIV>
<DIV><FONT face=Verdana size=2><!-- Converted from text/plain format -->
<P><FONT size=2>From: Piotr Ziecik &lt;kosmo@semihalf.com&gt;<BR><BR>This patch 
adds initial version of MPC512x DMA driver.<BR>Only memory to memory transfers 
are currenly supported.<BR><BR>Signed-off-by: Piotr Ziecik 
&lt;kosmo@semihalf.com&gt;<BR>Signed-off-by: Wolfgang Denk 
&lt;wd@denx.de&gt;<BR>Cc: Grant Likely &lt;grant.likely@secretlab.ca&gt;<BR>Cc: 
John Rigby 
&lt;jcrigby@gmail.com&gt;<BR>---<BR>&nbsp;arch/powerpc/boot/dts/mpc5121ads.dts&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
|&nbsp;&nbsp;&nbsp; 2 +-<BR>&nbsp;arch/powerpc/platforms/512x/mpc512x_shared.c 
|&nbsp;&nbsp;&nbsp; 1 
+<BR>&nbsp;drivers/dma/Kconfig&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
|&nbsp;&nbsp;&nbsp; 7 
+<BR>&nbsp;drivers/dma/Makefile&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
|&nbsp;&nbsp;&nbsp; 1 
+<BR>&nbsp;drivers/dma/mpc512x_dma.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
|&nbsp; 642 
++++++++++++++++++++++++++<BR>&nbsp;drivers/dma/mpc512x_dma.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
|&nbsp; 192 ++++++++<BR>&nbsp;6 files changed, 844 insertions(+), 1 
deletions(-)<BR>&nbsp;create mode 100644 
drivers/dma/mpc512x_dma.c<BR>&nbsp;create mode 100644 
drivers/dma/mpc512x_dma.h<BR>_______________________________________________<BR>Linuxppc-dev 
mailing list<BR>Linuxppc-dev@ozlabs.org<BR><A 
href="https://ozlabs.org/mailman/listinfo/linuxppc-dev">https://ozlabs.org/mailman/listinfo/linuxppc-dev</A><BR></FONT></P></FONT></DIV></BODY></HTML>

--=====003_Dragon268623510562_=====--
