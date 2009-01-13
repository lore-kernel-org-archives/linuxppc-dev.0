Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0A429DE017
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jan 2009 07:59:54 +1100 (EST)
Subject: Re: Please pull from 'next' branch (2.6.29)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <Pine.LNX.4.64.0901130917190.21289@blarg.am.freescale.net>
References: <Pine.LNX.4.64.0901130917190.21289@blarg.am.freescale.net>
Content-Type: text/plain
Date: Wed, 14 Jan 2009 07:59:44 +1100
Message-Id: <1231880384.22571.46.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2009-01-13 at 09:21 -0600, Kumar Gala wrote:
> Please pull from 'next' branch of
> 
> (this is my last pull request of 'next' for 2.6.29.  I would like to see
> the 'powerpc: Unify opcode definitions and support' patch go in but leave
> that for you to pull in directly).

This is really very very very late for these changes, most of them
aren't bug fixes at all...

> 	master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git next
> 
> to receive the following updates:
> 
>  arch/powerpc/Kconfig                           |   18 +
>  arch/powerpc/boot/dts/mpc8315erdb.dts          |   68 ++++++
>  arch/powerpc/boot/dts/mpc8377_mds.dts          |   64 ++++++
>  arch/powerpc/boot/dts/mpc8377_rdb.dts          |   64 ++++++
>  arch/powerpc/boot/dts/mpc8378_mds.dts          |   64 ++++++
>  arch/powerpc/boot/dts/mpc8378_rdb.dts          |   64 ++++++
>  arch/powerpc/include/asm/reg_booke.h           |    1
>  arch/powerpc/kernel/Makefile                   |    1
>  arch/powerpc/kernel/cpu_setup_fsl_booke.S      |   31 +++
>  arch/powerpc/kernel/cputable.c                 |    8
>  arch/powerpc/kernel/head_booke.h               |    6
>  arch/powerpc/kernel/head_fsl_booke.S           |   85 +++++---
>  arch/powerpc/mm/fsl_booke_mmu.c                |   93 ++++-----
>  arch/powerpc/platforms/83xx/Makefile           |    1
>  arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c |  209 +++++++++++++++++++++
>  arch/powerpc/platforms/83xx/mpc831x_rdb.c      |    2
>  arch/powerpc/platforms/83xx/mpc837x_mds.c      |   10 -
>  arch/powerpc/platforms/83xx/mpc837x_rdb.c      |    2
>  arch/powerpc/platforms/Kconfig                 |   11 +
>  arch/powerpc/sysdev/fsl_pci.c                  |  244 ++++++++++++++++++++++---
>  drivers/i2c/chips/Kconfig                      |   11 -
>  drivers/i2c/chips/Makefile                     |    1
>  drivers/i2c/chips/mcu_mpc8349emitx.c           |  209 ---------------------
>  include/linux/pci_ids.h                        |    8
>  24 files changed, 941 insertions(+), 334 deletions(-)
> 
> Anton Vorontsov (4):
>       powerpc/fsl_pci: Add MPC83xx PCI-E controller RC mode support
>       powerpc/83xx: Add PCI-E support for all MPC83xx boards with PCI-E
>       powerpc/83xx: Make serial ports work on MPC8315E-RDB w/ FSL U-Boots
>       powerpc/83xx: Move mcu_mpc8349emitx driver out of drivers/i2c/chips/
> 
> Kumar Gala (2):
>       powerpc/fsl-booke: Cleanup init/exception setup to be runtime
>       powerpc/e500mc: Doorbells need to be taken w/exceptions disabled
> 
> Trent Piepho (3):
>       powerpc/fsl-booke: Remove code duplication in lowmem mapping
>       powerpc/fsl-booke: Allow larger CAM sizes than 256 MB
>       powerpc/fsl-booke: Make CAM entries used for lowmem configurable
