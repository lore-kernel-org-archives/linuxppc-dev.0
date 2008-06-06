Return-Path: <gregkh@suse.de>
Received: from mx2.suse.de (ns2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3CA72DE1A8
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Jun 2008 08:58:16 +1000 (EST)
Subject: patch usb-ohci-ppc-of-use-linux-of_platform.h-instead-of-asm.patch
	added to gregkh-2.6 tree
To: sfr@canb.auug.org.au, gregkh@suse.de, greg@kroah.com,
	linuxppc-dev@ozlabs.org, tnt@246tNt.com
From: <gregkh@suse.de>
Date: Fri, 06 Jun 2008 15:52:29 -0700
In-Reply-To: <20080523163758.4edcdef4.sfr@canb.auug.org.au>
Message-ID: <12127927494073@kroah.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


This is a note to let you know that I've just added the patch titled

     Subject: USB: ohci-ppc-of: use linux/of_platform.h instead of asm

to my gregkh-2.6 tree.  Its filename is

     usb-ohci-ppc-of-use-linux-of_platform.h-instead-of-asm.patch

This tree can be found at 
    http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/


>From sfr@canb.auug.org.au  Fri Jun  6 15:16:28 2008
From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 23 May 2008 16:37:58 +1000
Subject: USB: ohci-ppc-of: use linux/of_platform.h instead of asm
To: Sylvain Munaut <tnt@246tNt.com>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Greg KH <greg@kroah.com>
Message-ID: <20080523163758.4edcdef4.sfr@canb.auug.org.au>



Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/usb/host/ohci-ppc-of.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/host/ohci-ppc-of.c
+++ b/drivers/usb/host/ohci-ppc-of.c
@@ -14,8 +14,8 @@
  */
 
 #include <linux/signal.h>
+#include <linux/of_platform.h>
 
-#include <asm/of_platform.h>
 #include <asm/prom.h>
 
 


Patches currently in gregkh-2.6 which might be from sfr@canb.auug.org.au are

bad/battery-class-driver.patch
usb/usb-ohci-ppc-of-use-linux-of_platform.h-instead-of-asm.patch
