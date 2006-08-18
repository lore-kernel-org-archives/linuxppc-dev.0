Return-Path: <claus.gindhart@kontron.com>
Received: from mail.kontron-modular.com (mail.e2brain.de [62.159.155.200])
	by ozlabs.org (Postfix) with ESMTP id 985B3679FC
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Aug 2006 16:25:36 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: USB-Driver for Freescale ehci-fsl.c on Kernel 2.6.17
Date: Fri, 18 Aug 2006 08:25:31 +0200
Message-ID: <DADA32856852FC458E0F96B664A6F55E011E23F8@kom-mailsrv1.kontron-modular.com>
From: "Claus Gindhart" <claus.gindhart@kontron.com>
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

Hi,

currently i am migrating an existing Linux-BSP for the MPC8347/9 from =
Kernel 2.6.13 to 2.6.17 with flattened device tree.

Now, i recognized, that the Makefile and Kconfig in drivers/usb/host do =
not have any entries to configure and compile the ehci-fsl.c driver.

Does this mean, that ehci-fsl.c is no longer required, because the =
generic EHCI-driver now handles this; or is it just the case, that USB =
for Freescale processor was not yet tested on Kernel 2.6.17 ?

--=20
Mit freundlichen Gruessen / Best regards

Claus Gindhart
SW R&D
Kontron Modular Computers
phone :++49 (0)8341-803-374
mailto:claus.gindhart@kontron-modular.com
http://www.kontron.com

-----BEGIN GEEK CODE BLOCK-----
  Version: 3.1
  GU d- s++:>++:+ a+ C++$ !U !P L++>$ E-- W+(-) N- o?
  K? w !O !M V !PS PE- Y+ PGP+ t 5? X R* tv- b+ DI+++
  D-- G e++> h--- !r x+++
------END GEEK CODE BLOCK------
=20
