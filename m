Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D0774DDE26
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Dec 2008 05:31:21 +1100 (EST)
Message-Id: <51A41F18-046E-4227-813D-0EC46E2FFEE4@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <Pine.LNX.4.64.0812301139490.20609@blarg.am.freescale.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: Please pull from 'next' branch
Date: Tue, 30 Dec 2008 12:31:15 -0600
References: <Pine.LNX.4.64.0812301139490.20609@blarg.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 30, 2008, at 11:40 AM, Kumar Gala wrote:

> Please pull from 'next' branch of
>
> 	master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git next
>
> to receive the following updates:
>
> Documentation/powerpc/dts-bindings/fsl/board.txt |   32 +++
> arch/powerpc/boot/dts/mpc836x_mds.dts            |   43 ++++-
> arch/powerpc/boot/dts/mpc836x_rdk.dts            |   19 ++
> arch/powerpc/boot/dts/mpc8641_hpcn.dts           |   56 +++---
> arch/powerpc/configs/85xx/mpc8572_ds_defconfig   |   43 +++--
> arch/powerpc/include/asm/qe.h                    |   37 ++++
> arch/powerpc/include/asm/qe_ic.h                 |   21 ++
> arch/powerpc/platforms/83xx/mpc831x_rdb.c        |    2
> arch/powerpc/platforms/83xx/mpc832x_mds.c        |    9 -
> arch/powerpc/platforms/83xx/mpc832x_rdb.c        |    5
> arch/powerpc/platforms/83xx/mpc836x_mds.c        |   81 +++++++++
> arch/powerpc/platforms/83xx/mpc836x_rdk.c        |    6
> arch/powerpc/platforms/83xx/mpc837x_mds.c        |    1
> arch/powerpc/platforms/83xx/mpc837x_rdb.c        |    2
> arch/powerpc/platforms/83xx/mpc83xx.h            |    1
> arch/powerpc/platforms/85xx/mpc85xx_ds.c         |    7
> arch/powerpc/platforms/85xx/smp.c                |    1
> arch/powerpc/platforms/Kconfig                   |   11 +
> arch/powerpc/platforms/Kconfig.cputype           |    2
> arch/powerpc/sysdev/Makefile                     |    1
> arch/powerpc/sysdev/fsl_pci.c                    |    7
> arch/powerpc/sysdev/fsl_soc.h                    |    5
> arch/powerpc/sysdev/qe_lib/gpio.c                |  195 +++++++++++++ 
> ++++++++++
> arch/powerpc/sysdev/simple_gpio.c                |  155 +++++++++++++ 
> +++++
> arch/powerpc/sysdev/simple_gpio.h                |   12 +
> 25 files changed, 684 insertions(+), 70 deletions(-)
>
> Anton Vorontsov (11):
>      powerpc: Implement get_brgfreq() and get_baudrate() stubs
>      powerpc/83xx: Fix sparse warnings in board files
>      powerpc/83xx: Fix sparse warnings in mpc836x_mds.c
>      powerpc/qe: Implement QE Pin Multiplexing API
>      powerpc: Add device tree bindings for BCSR GPIO banks
>      powerpc: Implement GPIO driver for simple memory-mapped banks
>      powerpc/83xx: Add USB Host/Gadget support for MPC8360E-MDS boards
>      powerpc/83xx: Add USB Host support for MPC8360E-RDK boards
>      powerpc/fsl_pci: Fix sparse warnings
>      powerpc/83xx: Fix few build errors with CONFIG_QUICC_ENGINE=n
>      powerpc/qe: Fix few build errors with CONFIG_QUICC_ENGINE=n
>
> Becky Bruce (1):
>      powerpc/86xx: Update 8641hpcn dts file to match latest u-boot
>
> Julia Lawall (1):
>      powerpc/85xx: Add local_irq_restore in error handling code
>
> Kumar Gala (2):
>      powerpc/85xx: Enable SMP support
>      powerpc/85xx: Add SMP support to MPC8572 DS

Updated w/one more patch from Anton:

        powerpc/qe: Select QE_USB with USB_GADGET_FSL_QE

- k
