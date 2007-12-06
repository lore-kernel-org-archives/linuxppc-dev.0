Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6D666DDE37
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  6 Dec 2007 19:41:23 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1J0CIJ-0005TF-UH
	for linuxppc-embedded@ozlabs.org; Thu, 06 Dec 2007 00:41:19 -0800
Message-ID: <14188430.post@talk.nabble.com>
Date: Thu, 6 Dec 2007 00:41:19 -0800 (PST)
From: Misbah khan <misbah_khan@engineer.com>
To: linuxppc-embedded@ozlabs.org
Subject: Problem in compiling Kernel for USB Host support.
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi all ..

I am facing problem in compiling kernel for USB Support. while selecting the
option i have selected the USB host configuration but while compiling i am
getting the following error :-


-----------------------------------------------------------------------------------------
drivers/built-in.o(.text+0x7a1f8): In function `usb_register':
drivers/usb/core/usb.c:174: undefined reference to `usbfs_update_special'
drivers/built-in.o(.text+0x7a264): In function `usb_deregister':
drivers/usb/core/usb.c:202: undefined reference to `usbfs_update_special'
drivers/built-in.o(.text+0x7d058): In function `usb_new_device':
drivers/usb/core/hub.c:1269: undefined reference to `usbfs_add_device'
drivers/built-in.o(.text+0x7f2e8): In function `usb_register_bus':
drivers/usb/core/hcd.c:758: undefined reference to `usbfs_add_bus'
drivers/built-in.o(.text+0x7f3f0): In function `usb_deregister_bus':
drivers/usb/core/hcd.c:786: undefined reference to `usbfs_remove_bus'
drivers/built-in.o(.init.text+0x3974): In function `usb_init':
drivers/usb/core/usb.c:1487: undefined reference to `usbfs_init'
drivers/built-in.o(.init.text+0x39a4):drivers/usb/core/usb.c:1500: undefined
reference to `usbfs_cleanup'
drivers/built-in.o(.exit.text+0x6ac): In function `usb_exit':
drivers/usb/core/usb.c:1522: undefined reference to `usbfs_cleanup'
make: *** [vmlinux] Error 1

-----------------------------------------------------------------------------------------------

This is for PPC8272-ads board using Montavista Linux. Can any body suggest
me that what else configuration is required (which i had missed ) is giving
this error ????


Looking forward for your help 

----Misbah <><
-- 
View this message in context: http://www.nabble.com/Problem-in-compiling-Kernel-for-USB-Host-support.-tf4954748.html#a14188430
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
