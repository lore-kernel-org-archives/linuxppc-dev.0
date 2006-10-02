Return-Path: <judith@osdl.org>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id BB2E767C0C
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Oct 2006 07:49:58 +1000 (EST)
Date: Mon, 2 Oct 2006 14:49:54 -0700
From: Judith Lebzelter <judith@osdl.org>
To: linux-kernel@vger.kernel.org
Subject: Undefined '.bus_to_virt',
	'.virt_to_bus' causes compile error on Powerpc 64-bit
Message-ID: <20061002214954.GD665@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello:

For the automated cross-compile builds at OSDL, powerpc 64-bit 
'allmodconfig' is failing.  The warnings/errors below appear in 
the 'modpost' stage of kernel compiles for 2.6.18 and -mm2 kernels.

Thanks;
Judith Lebzelter
OSDL

-----------

  Building modules, stage 2.
  MODPOST 1658 modules
WARNING: Can't handle masks in drivers/ata/ahci:FFFF05
WARNING: ".virt_to_bus" [sound/oss/sscape.ko] undefined!
WARNING: ".virt_to_bus" [sound/oss/sound.ko] undefined!
WARNING: ".bus_to_virt" [sound/oss/cs46xx.ko] undefined!
WARNING: ".virt_to_bus" [sound/oss/cs46xx.ko] undefined!
WARNING: ".bus_to_virt" [drivers/scsi/tmscsim.ko] undefined!
WARNING: ".bus_to_virt" [drivers/scsi/BusLogic.ko] undefined!
WARNING: ".virt_to_bus" [drivers/net/wan/lmc/lmc.ko] undefined!
WARNING: ".virt_to_bus" [drivers/message/i2o/i2o_config.ko] undefined!
WARNING: ".bus_to_virt" [drivers/block/cpqarray.ko] undefined!
WARNING: ".bus_to_virt" [drivers/atm/zatm.ko] undefined!
WARNING: ".virt_to_bus" [drivers/atm/zatm.ko] undefined!
WARNING: ".bus_to_virt" [drivers/atm/horizon.ko] undefined!
WARNING: ".virt_to_bus" [drivers/atm/firestream.ko] undefined!
WARNING: ".bus_to_virt" [drivers/atm/firestream.ko] undefined!
WARNING: ".bus_to_virt" [drivers/atm/ambassador.ko] undefined!
WARNING: ".virt_to_bus" [drivers/atm/ambassador.ko] undefined!
make[1]: *** [__modpost] Error 1
make: *** [modules] Error 2
