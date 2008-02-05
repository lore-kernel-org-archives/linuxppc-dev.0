Return-Path: <hans.lehmann@ritter-elektronik.de>
Received: from mail.textile.saurer.com (mail.textile.saurer.com
	[193.158.88.134]) by ozlabs.org (Postfix) with ESMTP id C86EEDDE30
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  6 Feb 2008 00:39:54 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: Reboot at die_probe
Date: Tue, 5 Feb 2008 14:39:48 +0100
Message-ID: <D75C3E75C6176746B68E0EF7245F616F611B24@SRVEXC01.sts.saurer.vpn>
From: "Lehmann, Hans (Ritter Elektronik)" <hans.lehmann@ritter-elektronik.de>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi ,

i have strange problems with my cf card driver on our MPC5200 embedded
board. The cf card is mapped to memory space and interrupt is connected
to IRQ1(rising edge sensitive). First the driver was written for Kernel
2.6.14 and worked pretty. Now I  ported it to Kernel 2.6.24 and get
strange behaviour I do not understand.
After I load the modul, the kernel start to reboot when i call function
ide_device_add(). The reboot appears while device responses in function
"actual_try_to_identify" (ide-probe.c), after kernel sent the identify
command (0xec) to status/command register (hwif->outb(cmd,
DIE_COMMAND_REG;).=20
To figure out whether card will be identify correct, I changed irq from
edge sensitive to level sensitive and card will be identified proper,
but get error "lost interrupt".

I habe no idea what happend.

Kindly regards

Hans
 =20
