Message-ID: <1880.80.7.99.14.1086887460.squirrel@www.solinno.co.uk>
Date: Thu, 10 Jun 2004 18:11:00 +0100 (BST)
Subject: [RFC][PATCH 9/9] Support for old IBM PReP boxes
From: "Leigh Brown" <leigh@solinno.co.uk>
To: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


How annoying, I forgot the subject on that one.

An easy one.  Since the planar id is a byte, it seems a shame to waste all
those extra digits.


diff -urNX .diffex linux-2.6.6-prev/arch/ppc/platforms/prep_setup.c
linux-2.6.6/arch/ppc/platforms/prep_setup.c
--- linux-2.6.6-prev/arch/ppc/platforms/prep_setup.c	2004-06-09
13:56:43.000000000 +0100
+++ linux-2.6.6/arch/ppc/platforms/prep_setup.c	2004-06-09
14:00:31.000000000 +0100
@@ -815,7 +815,7 @@
 	{
 	case _PREP_IBM:
 		reg = inb(PREP_IBM_PLANAR);
-		printk(KERN_INFO "IBM planar ID: %08x", reg);
+		printk(KERN_INFO "IBM planar ID: %02x", reg);
 		switch (reg) {
 			case PREP_IBM_SANDALFOOT:
 				prep_gen_enable_l2();


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
