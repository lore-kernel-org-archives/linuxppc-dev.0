Return-Path: <DaveLiu@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0BCCFDE1BD
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Mar 2009 01:22:21 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n2BEMI87025184
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Mar 2009 07:22:19 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id n2BEMGod022181
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Mar 2009 09:22:17 -0500 (CDT)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C9A254.C793533A"
Subject: Re: [PATCH] powerpc: Add support for CoreInt delivery of interrupts
	onMPIC
Date: Wed, 11 Mar 2009 22:20:13 +0800
Message-ID: <D7CCA83BB0796C49BC0BB53B6AB12089136E4B@zch01exm21.fsl.freescale.net>
References: <1236772127-28543-1-git-send-email-galak@kernel.crashing.org>
From: "Liu Dave-R63238" <DaveLiu@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C9A254.C793533A
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable

--- a/arch/powerpc/include/asm/mpic.h
+++ b/arch/powerpc/include/asm/mpic.h
@@ -22,6 +22,7 @@
 #define MPIC_GREG_FEATURE_1		0x00010
 #define MPIC_GREG_GLOBAL_CONF_0		0x00020
 #define		MPIC_GREG_GCONF_RESET			0x80000000
+#define		MPIC_GREG_GCONF_COREINT			0x40000000
 #define		MPIC_GREG_GCONF_8259_PTHROU_DIS		0x20000000
 #define		MPIC_GREG_GCONF_NO_BIAS			0x10000000
 #define		MPIC_GREG_GCONF_BASE_MASK		0x000fffff


according to the latest UM, the MPIC_GREG_GCONF_COREINT should be
0x60000000.

------_=_NextPart_001_01C9A254.C793533A
Content-Type: text/html;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dgb2312">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7653.38">
<TITLE>Re: [PATCH] powerpc: Add support for CoreInt delivery of =
interrupts onMPIC</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>--- a/arch/powerpc/include/asm/mpic.h<BR>
+++ b/arch/powerpc/include/asm/mpic.h<BR>
@@ -22,6 +22,7 @@<BR>
&nbsp;#define MPIC_GREG_FEATURE_1&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00010<BR>
&nbsp;#define =
MPIC_GREG_GLOBAL_CONF_0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00020<BR>
&nbsp;#define&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
MPIC_GREG_GCONF_RESET&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x80000000<BR>
+#define&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MPIC_GREG_GCONF_COREINT =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x40000000<BR>
&nbsp;#define&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
MPIC_GREG_GCONF_8259_PTHROU_DIS =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x20000000<BR>
&nbsp;#define&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MPIC_GREG_GCONF_NO_BIAS =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x10000000<BR>
&nbsp;#define&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
MPIC_GREG_GCONF_BASE_MASK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x000fffff<BR>
<BR>
<BR>
according to the latest UM, the MPIC_GREG_GCONF_COREINT should be<BR>
0x60000000.<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C9A254.C793533A--
