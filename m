Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6BAD0DDEC8
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Feb 2007 08:55:21 +1100 (EST)
Date: Thu, 8 Feb 2007 15:52:41 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Please pull from 'for_paulus' branch
In-Reply-To: <Pine.LNX.4.64.0702081546520.30378@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0702081552020.30378@localhost.localdomain>
References: <Pine.LNX.4.64.0702081546520.30378@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: linuxppc-dev@ozlabs.org, Li Yang <leoli@freescale.com>,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

(initial email was missing the subject).

- k

On Thu, 8 Feb 2007, Kumar Gala wrote:

> Please pull from 'for_paulus' branch of
> master.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git
>
> to receive the following updates:
>
>  Documentation/powerpc/booting-without-of.txt     |    4
>  arch/powerpc/boot/dts/kuroboxHD.dts              |  148 ++
>  arch/powerpc/boot/dts/mpc8313erdb.dts            |  219 +++
>  arch/powerpc/boot/dts/mpc8349emds.dts            |  328 -----
>  arch/powerpc/boot/dts/mpc834x_mds.dts            |  334 +++++
>  arch/powerpc/configs/linkstation_defconfig       |  118 +
>  arch/powerpc/configs/mpc8313_rdb_defconfig       | 1409 +++++++++++++++++++++++
>  arch/powerpc/configs/mpc834x_mds_defconfig       |    9
>  arch/powerpc/kernel/of_platform.c                |    1
>  arch/powerpc/platforms/83xx/Kconfig              |   24
>  arch/powerpc/platforms/83xx/Makefile             |    3
>  arch/powerpc/platforms/83xx/mpc8313_rdb.c        |   99 +
>  arch/powerpc/platforms/83xx/mpc834x_mds.c        |  213 +++
>  arch/powerpc/platforms/83xx/mpc834x_sys.c        |  140 --
>  arch/powerpc/platforms/83xx/mpc834x_sys.h        |   23
>  arch/powerpc/platforms/83xx/mpc83xx.h            |   18
>  arch/powerpc/platforms/embedded6xx/linkstation.c |   12
>  arch/powerpc/sysdev/fsl_soc.c                    |   78 -
>  arch/powerpc/sysdev/qe_lib/ucc_slow.c            |    6
>  include/asm-powerpc/ucc_slow.h                   |    2
>  20 files changed, 2611 insertions(+), 577 deletions(-)
>
> Andy Fleming (1):
>       [POWERPC] QE: Added QE to the list of default scanned OF devices
>
> Guennadi Liakhovetski (1):
>       [POWERPC] Update to linkstation / kurobox support
>
> Kim Phillips (2):
>       [POWERPC] 83xx: Add base support for the MPC8313E RDB
>       [POWERPC] 83xx: add the mpc8313erdb defconfig
>
> Kumar Gala (1):
>       [POWERPC] 83xx: Updated and renamed MPC834x SYS to MPC834x MDS
>
> Li Yang (3):
>       [POWERPC] 83xx: Added new dr_mode property for usb controller on 83xx
>       [POWERPC] 83xx: Add USB setup code for MPC8349E MDS-PB
>       [POWERPC] 83xx: Add platform_device for USB DR peripheral driver
>
> Timur Tabi (1):
>       [POWERPC] QE: Rename ucc_slow_info.us_regs to ucc_slow_info.regs
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>
