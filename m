Return-Path: <joe@perches.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 688DDB6EDF
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 11 Aug 2009 05:53:08 +1000 (EST)
Received: from mail.perches.com (136-022.dsl.LABridge.com [206.117.136.22])
	by ozlabs.org (Postfix) with ESMTP id C85DBDDD0C
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Aug 2009 05:53:05 +1000 (EST)
Subject: Linux MAINTAINERS section FREESCALE HIGHSPEED USB DEVICE DRIVER
From: Joe Perches <joe@perches.com>
To: Li Yang <leoli@freescale.com>
Content-Type: text/plain
Date: Mon, 10 Aug 2009 12:08:52 -0700
Message-Id: <1249931332.8895.54.camel@Joe-Laptop.home>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Guennadi Liakhovetski <lg@denx.de>,
	linux-usb@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi.

This entry, copied below, is no longer correct.

The "F:" entry got renamed by commit 
54e4026b64a970303349b952866641a7804ef594

New file: drivers/usb/gadget/fsl_udc_core.c

Are you still maintaining this file?
You did not sign-off on the rename.

What should be done here?

cheers, Joe

FREESCALE HIGHSPEED USB DEVICE DRIVER
M:	Li Yang <leoli@freescale.com>
L:	linux-usb@vger.kernel.org
L:	linuxppc-dev@ozlabs.org
S:	Maintained
F:	drivers/usb/gadget/fsl_usb2_udc.c
