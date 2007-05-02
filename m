Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5F021DDF0F
	for <linuxppc-dev@ozlabs.org>; Wed,  2 May 2007 18:11:42 +1000 (EST)
Subject: [PATCH] fix drivers/usb for appletouch
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-usb-devel <linux-usb-devel@lists.sourceforge.net>
Content-Type: text/plain
Date: Wed, 02 May 2007 07:20:15 +0200
Message-Id: <1178083216.13233.2.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds drivers/usb/input/ to the build when only APPLETOUCH is
selected from the input drivers.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>

---
And I keep wondering why appletouch.ko isn't installed... :)

--- wireless-dev.orig/drivers/usb/Makefile	2007-05-02 07:07:32.549196053 +0200
+++ wireless-dev/drivers/usb/Makefile	2007-05-02 07:17:30.179196053 +0200
@@ -25,6 +25,7 @@ obj-$(CONFIG_USB)		+= storage/
 
 obj-$(CONFIG_USB_ACECAD)	+= input/
 obj-$(CONFIG_USB_AIPTEK)	+= input/
+obj-$(CONFIG_USB_APPLETOUCH)	+= input/
 obj-$(CONFIG_USB_ATI_REMOTE)	+= input/
 obj-$(CONFIG_USB_KBTAB)		+= input/
 obj-$(CONFIG_USB_MTOUCH)	+= input/
