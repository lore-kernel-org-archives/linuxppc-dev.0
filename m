Return-Path: <LeoLi@freescale.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 9CBD6B6F31
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 11 Aug 2009 12:37:36 +1000 (EST)
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 23303DDD04
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Aug 2009 12:37:34 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n7B2bT3G007648
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Aug 2009 19:37:30 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id n7B2c9CS021600
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Aug 2009 21:38:10 -0500 (CDT)
From: Li Yang <leoli@freescale.com>
To: gregkh@suse.de, joe@perches.com
Subject: [PATCH] usb/gadget: Update Freescale UDC entry in MAINTAINERS
Date: Tue, 11 Aug 2009 11:11:11 +0800
Message-Id: <1249960271-3400-1-git-send-email-leoli@freescale.com>
Cc: linuxppc-dev@ozlabs.org, lg@denx.de, linux-usb@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Change the F entry for file rename, and make it also cover fsl_qe_udc
driver.  Update the name accordingly.

Signed-off-by: Li Yang <leoli@freescale.com>
---
Liakhovetski,

Is it ok that it also covers your fsl_mx3_udc.c file.  It's much easier
to use the wildcard.
 MAINTAINERS |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b1114cf..cf1e22c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2067,12 +2067,12 @@ S:	Supported
 F:	arch/powerpc/sysdev/qe_lib/
 F:	arch/powerpc/include/asm/*qe.h
 
-FREESCALE HIGHSPEED USB DEVICE DRIVER
+FREESCALE USB PERIPHERIAL DRIVERS
 M:	Li Yang <leoli@freescale.com>
 L:	linux-usb@vger.kernel.org
 L:	linuxppc-dev@ozlabs.org
 S:	Maintained
-F:	drivers/usb/gadget/fsl_usb2_udc.c
+F:	drivers/usb/gadget/fsl*
 
 FREESCALE QUICC ENGINE UCC ETHERNET DRIVER
 M:	Li Yang <leoli@freescale.com>
-- 
1.6.3.1.6.g4bf1f
