Date: Thu, 29 Jul 2004 22:34:54 +0100
To: paulus@samba.org
Cc: trini@kernel.crashing.org, linuxppc-dev@lists.linuxppc.org,
	barbieri@gmail.com
Subject: [8/9] Support for old IBM PReP boxes
Message-ID: <20040729213454.GA5922@george.solinno.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: leigh@solinno.co.uk (Leigh Brown)
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


The planar id is only a byte, so why waste 8 characters displaying
it?


diff -urNX /home/leigh/.diffex linux-2.6.8-rc2-bk8.prev/arch/ppc/platforms/prep_setup.c linux-2.6.8-rc2-bk8/arch/ppc/platforms/prep_setup.c
--- linux-2.6.8-rc2-bk8.prev/arch/ppc/platforms/prep_setup.c	2004-07-29 20:43:53.000000000 +0100
+++ linux-2.6.8-rc2-bk8/arch/ppc/platforms/prep_setup.c	2004-07-29 20:55:49.000000000 +0100
@@ -814,7 +814,7 @@
 	{
 	case _PREP_IBM:
 		reg = inb(PREP_IBM_PLANAR);
-		printk(KERN_INFO "IBM planar ID: %08x", reg);
+		printk(KERN_INFO "IBM planar ID: %02x", reg);
 		switch (reg) {
 			case PREP_IBM_SANDALFOOT:
 				prep_gen_enable_l2();

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
