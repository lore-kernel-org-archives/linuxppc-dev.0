Return-Path: <cthomas@Soneticom.com>
Received: from Soneticom.com (soneticom.com [209.114.210.150])
	by ozlabs.org (Postfix) with ESMTP id 00241DDF41
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  5 Apr 2007 05:42:45 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: MPC8555CDS ELDK build issue
Date: Wed, 4 Apr 2007 15:43:11 -0400
Message-ID: <3C02138692C13C4BB675FE7EA2409529327F9A@bluefin.Soneticom.local>
From: "Clint Thomas" <cthomas@Soneticom.com>
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

Hey,

Using the ELDK 4.1, I am trying to compile the linux sources for the
MPC8555CDS. I installed the source tree provided with ELDK 4.1 (2.6.19)
and the associated crosstools. The only factors I changed in the kernel
config were to set the processor arch to e500 and the platform to
8555CDS. When I run make, this is where it fails.

CC      arch/ppc/syslib/mpc85xx_devices.o
arch/ppc/syslib/mpc85xx_devices.c:99: error: 'F1_RXCLK' undeclared here
(not in a function)
arch/ppc/syslib/mpc85xx_devices.c:99: error: 'F1_TXCLK' undeclared here
(not in a function)
arch/ppc/syslib/mpc85xx_devices.c:117: error: 'F2_RXCLK' undeclared here
(not in a function)
arch/ppc/syslib/mpc85xx_devices.c:117: error: 'F2_TXCLK' undeclared here
(not in a function)
arch/ppc/syslib/mpc85xx_devices.c:135: error: 'F3_RXCLK' undeclared here
(not in a function)
arch/ppc/syslib/mpc85xx_devices.c:135: error: 'F3_TXCLK' undeclared here
(not in a function)
make[1]: *** [arch/ppc/syslib/mpc85xx_devices.o] Error 1
make: *** [arch/ppc/syslib] Error 2


This is the exact same build error I get when compiling with the same
cross-tools, using several other version of the Linux kernel. Any of the
Freescale guys know why this is? Thanks

Clint Thomas
