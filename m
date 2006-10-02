Return-Path: <bunk@stusta.de>
Received: from mailout.stusta.mhn.de (mailout.stusta.mhn.de [141.84.69.5])
	by ozlabs.org (Postfix) with SMTP id E33BE67C31
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Oct 2006 11:44:30 +1000 (EST)
Date: Tue, 3 Oct 2006 01:44:28 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Judith Lebzelter <judith@osdl.org>
Subject: Re: Undefined '.bus_to_virt',
	'.virt_to_bus' causes compile error on Powerpc 64-bit
Message-ID: <20061002234428.GE3278@stusta.de>
References: <20061002214954.GD665@shell0.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061002214954.GD665@shell0.pdx.osdl.net>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Oct 02, 2006 at 02:49:54PM -0700, Judith Lebzelter wrote:

> Hello:

Hi Judith,

> For the automated cross-compile builds at OSDL, powerpc 64-bit 
> 'allmodconfig' is failing.  The warnings/errors below appear in 
> the 'modpost' stage of kernel compiles for 2.6.18 and -mm2 kernels.

known for ages - the drivers need fixing.

You might want to convince Andrew accepting my patch to make 
virt_to_bus/bus_to_virt give compile warnings on i386 for making
people more aware of this problem...

> Thanks;
> Judith Lebzelter
> OSDL
> 
> -----------
> 
>   Building modules, stage 2.
>   MODPOST 1658 modules
> WARNING: Can't handle masks in drivers/ata/ahci:FFFF05
> WARNING: ".virt_to_bus" [sound/oss/sscape.ko] undefined!
> WARNING: ".virt_to_bus" [sound/oss/sound.ko] undefined!
> WARNING: ".bus_to_virt" [sound/oss/cs46xx.ko] undefined!
> WARNING: ".virt_to_bus" [sound/oss/cs46xx.ko] undefined!
> WARNING: ".bus_to_virt" [drivers/scsi/tmscsim.ko] undefined!
> WARNING: ".bus_to_virt" [drivers/scsi/BusLogic.ko] undefined!
> WARNING: ".virt_to_bus" [drivers/net/wan/lmc/lmc.ko] undefined!
> WARNING: ".virt_to_bus" [drivers/message/i2o/i2o_config.ko] undefined!
> WARNING: ".bus_to_virt" [drivers/block/cpqarray.ko] undefined!
> WARNING: ".bus_to_virt" [drivers/atm/zatm.ko] undefined!
> WARNING: ".virt_to_bus" [drivers/atm/zatm.ko] undefined!
> WARNING: ".bus_to_virt" [drivers/atm/horizon.ko] undefined!
> WARNING: ".virt_to_bus" [drivers/atm/firestream.ko] undefined!
> WARNING: ".bus_to_virt" [drivers/atm/firestream.ko] undefined!
> WARNING: ".bus_to_virt" [drivers/atm/ambassador.ko] undefined!
> WARNING: ".virt_to_bus" [drivers/atm/ambassador.ko] undefined!
> make[1]: *** [__modpost] Error 1
> make: *** [modules] Error 2
> 

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
