Return-Path: <galak@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 5D281682D5
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 17 Sep 2005 02:42:09 +1000 (EST)
Date: Fri, 16 Sep 2005 11:41:55 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Message-ID: <Pine.LNX.4.61.0509161138130.20199@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: bseip config doesn't build
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Anyone have any ideas why the bseip_defconfig doesnt build.  I get the 
following error:

  CC      arch/ppc/8xx_io/enet.o
arch/ppc/8xx_io/enet.c:705:2: #error Exactly ONE pair of PA_ENET_[RT]XD, PB_ENET_[RT]XD must be defined
arch/ppc/8xx_io/enet.c: In function `scc_enet_init':
arch/ppc/8xx_io/enet.c:726: error: `PA_ENET_TCLK' undeclared (first use in this function)
arch/ppc/8xx_io/enet.c:726: error: (Each undeclared identifier is reported only once
arch/ppc/8xx_io/enet.c:726: error: for each function it appears in.)
arch/ppc/8xx_io/enet.c:726: error: `PA_ENET_RCLK' undeclared (first use in this function)
arch/ppc/8xx_io/enet.c:732: error: `PC_ENET_CLSN' undeclared (first use in this function)
arch/ppc/8xx_io/enet.c:732: error: `PC_ENET_RENA' undeclared (first use in this function)
arch/ppc/8xx_io/enet.c:739: error: `SICR_ENET_MASK' undeclared (first use in this function)
arch/ppc/8xx_io/enet.c:740: error: `SICR_ENET_CLKRT' undeclared (first use in this function)
arch/ppc/8xx_io/enet.c:918:2: #error Configuration Error: define exactly ONE of PB_ENET_TENA, PC_ENET_TENA, PE_ENET_TENA
arch/ppc/8xx_io/enet.c:932: error: `PB_BSE_POWERUP' undeclared (first use in this function)
arch/ppc/8xx_io/enet.c:932: error: `PB_BSE_FDXDIS' undeclared (first use in this function)
arch/ppc/8xx_io/enet.c:936: error: `PC_BSE_LOOPBACK' undeclared (first use in this function)
make[1]: *** [arch/ppc/8xx_io/enet.o] Error 1
make: *** [arch/ppc/8xx_io] Error 2

- kumar
