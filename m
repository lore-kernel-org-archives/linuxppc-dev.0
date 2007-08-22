Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D1546DDEE1
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Aug 2007 01:24:47 +1000 (EST)
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <75EDD900-3B5E-4D08-9311-13B6510EDE6E@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: asm-ppc header issues when building ARCH=powerpc
Date: Wed, 22 Aug 2007 10:19:21 -0500
To: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>
Cc: Paul Mackerras <paulus@samba.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Guys,

I was wondering if I could get your help with looking at the  
following lists and determining if we have an issue or not related  
the following files:

Getting some classification on these would be good.  Possibly  
classifications, doesn't build in ARCH=powerpc, remove include, real  
issue, etc.

- k

./include/asm-powerpc/irq.h:#include <asm/mpc83xx.h>	- protected by ! 
CONFIG_PPC_MERGE

./drivers/ide/ppc/mpc8xx.c:#include <asm/residual.h>

./drivers/mtd/maps/tqm834x.c:#include <asm/ppcboot.h>
./drivers/mtd/maps/pq2fads.c:#include <asm/ppcboot.h>

./drivers/i2c/busses/i2c-ibm_iic.c:#include <asm/ibm4xx.h>
./drivers/mtd/maps/walnut.c:#include <asm/ibm4xx.h>
./include/asm-powerpc/irq.h:#include <asm/ibm4xx.h>	- protected by ! 
CONFIG_PPC_MERGE

./drivers/mtd/maps/ebony.c:#include <asm/ibm44x.h>
./drivers/mtd/maps/ocotea.c:#include <asm/ibm44x.h>
./drivers/mtd/nand/ndfc.c:#include <asm/ibm44x.h>
./include/asm-powerpc/irq.h:#include <asm/ibm44x.h>	- protected by ! 
CONFIG_PPC_MERGE

./drivers/i2c/busses/i2c-ibm_iic.c:#include <asm/ocp.h>
./drivers/net/ucc_geth_mii.c:#include <asm/ocp.h>	- just bogus, needs  
removal
./drivers/net/ibm_emac/ibm_emac_core.c:#include <asm/ocp.h>
./drivers/net/ibm_emac/ibm_emac_core.h:#include <asm/ocp.h>
./drivers/net/ibm_emac/ibm_emac_tah.h:#include <asm/ocp.h>
./drivers/net/ibm_emac/ibm_emac_phy.c:#include <asm/ocp.h>
./drivers/net/ibm_emac/ibm_emac_mal.c:#include <asm/ocp.h>
./drivers/net/ibm_emac/ibm_emac_zmii.h:#include <asm/ocp.h>

./drivers/macintosh/adb-iop.c:#include <asm/bootinfo.h>
./drivers/char/vme_scc.c:#include <asm/bootinfo.h>
./drivers/char/serial167.c:#include <asm/bootinfo.h>
./drivers/serial/dz.c:#include <asm/bootinfo.h>
./drivers/mtd/devices/ms02-nv.c:#include <asm/bootinfo.h>
./drivers/net/macsonic.c:#include <asm/bootinfo.h>
./drivers/net/jazzsonic.c:#include <asm/bootinfo.h>
./drivers/video/pmag-aa-fb.c:#include <asm/bootinfo.h>
./drivers/video/maxinefb.c:#include <asm/bootinfo.h>
./drivers/video/logo/logo.c:#include <asm/bootinfo.h>
./drivers/video/valkyriefb.c:#include <asm/bootinfo.h>
./drivers/video/macfb.c:#include <asm/bootinfo.h>
