Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DEC5ADDE23
	for <linuxppc-dev@ozlabs.org>; Sun, 18 Feb 2007 09:45:47 +1100 (EST)
Received: from [72.183.106.80] (helo=[192.168.1.100])
	by nommos.sslcatacombnetworking.com with esmtp (Exim 4.63)
	(envelope-from <galak@kernel.crashing.org>) id 1HIYJM-0000hk-JK
	for linuxppc-dev@ozlabs.org; Sat, 17 Feb 2007 16:45:44 -0600
Mime-Version: 1.0 (Apple Message framework v752.2)
In-Reply-To: <Pine.LNX.4.64.0702171636550.11791@localhost.localdomain>
References: <Pine.LNX.4.64.0702171636550.11791@localhost.localdomain>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <0E049496-0CC4-4F58-9699-2EC6A134B124@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Please pull from 'for_paulus' branch
Date: Sat, 17 Feb 2007 16:44:49 -0600
To: Linux PPC Dev ML <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 17, 2007, at 4:38 PM, Kumar Gala wrote:

> Please pull from 'for_paulus' branch of
> master.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git
>
> to receive the following updates:
>
>  arch/powerpc/boot/dts/mpc8313erdb.dts      |   62 -
>  arch/powerpc/boot/dts/mpc8323emds.dts      |  344 ---------
>  arch/powerpc/boot/dts/mpc832x_mds.dts      |  333 ++++++++
>  arch/powerpc/boot/dts/mpc8349emitx.dts     |   60 -
>  arch/powerpc/boot/dts/mpc8349emitxgp.dts   |   39 -
>  arch/powerpc/boot/dts/mpc834x_mds.dts      |  164 ++--
>  arch/powerpc/boot/dts/mpc8360emds.dts      |  374 ---------
>  arch/powerpc/boot/dts/mpc836x_mds.dts      |  363 +++++++++
>  arch/powerpc/boot/dts/mpc8540ads.dts       |  142 +--
>  arch/powerpc/boot/dts/mpc8541cds.dts       |  108 +-
>  arch/powerpc/boot/dts/mpc8548cds.dts       |  129 +--
>  arch/powerpc/boot/dts/mpc8555cds.dts       |  108 +-
>  arch/powerpc/boot/dts/mpc8560ads.dts       |  157 +---
>  arch/powerpc/boot/dts/mpc8568mds.dts       |   96 +-
>  arch/powerpc/configs/mpc832x_mds_defconfig | 1083 +++++++++++++++++ 
> +++++++++++
>  arch/powerpc/configs/mpc832xemds_defconfig | 1083  
> ----------------------------
>  arch/powerpc/configs/mpc8360emds_defconfig | 1082  
> ----------------------------
>  arch/powerpc/configs/mpc836x_mds_defconfig | 1099 +++++++++++++++++ 
> ++++++++++++
>  arch/powerpc/configs/mpc8568mds_defconfig  |   32
>  arch/powerpc/platforms/83xx/Kconfig        |    8
>  arch/powerpc/platforms/83xx/Makefile       |    2
>  arch/powerpc/platforms/83xx/mpc8313_rdb.c  |   11
>  arch/powerpc/platforms/83xx/mpc832x_mds.c  |   65 -
>  arch/powerpc/platforms/83xx/mpc834x_itx.c  |   23
>  arch/powerpc/platforms/83xx/mpc834x_mds.c  |   27
>  arch/powerpc/platforms/83xx/mpc8360e_pb.c  |  237 ------
>  arch/powerpc/platforms/83xx/mpc836x_mds.c  |  206 +++++
>  arch/powerpc/platforms/85xx/Kconfig        |    8
>  arch/powerpc/platforms/85xx/Makefile       |    2
>  arch/powerpc/platforms/85xx/mpc8568_mds.c  |  246 ------
>  arch/powerpc/platforms/85xx/mpc85xx_ads.c  |   14
>  arch/powerpc/platforms/85xx/mpc85xx_cds.c  |   15
>  arch/powerpc/platforms/85xx/mpc85xx_mds.c  |  234 ++++++
>  arch/powerpc/platforms/86xx/mpc86xx_hpcn.c |    9
>  arch/powerpc/sysdev/qe_lib/ucc_fast.c      |  163 +---
>  arch/powerpc/sysdev/qe_lib/ucc_slow.c      |  137 +--
>  include/asm-powerpc/ucc_slow.h             |    8
>  37 files changed, 3994 insertions(+), 4279 deletions(-)
>
> Jon Loeliger (2):
>       [POWERPC] 8[56]xx: Remove obsolete setting of ROOT_DEV for  
> 85xx and 86xx platforms.
>       [POWERPC] 86xx: Add missing of_node_put() in  
> mpc86xx_hpcn_init_irq().
>
> Kumar Gala (10):
>       [POWERPC] 83xx: Cleaned up 83xx platform dts files
>       [POWERPC] 83xx: Cleaning up machine probing and board initcalls
>       [POWERPC] 83xx: Remove obsolete setting of ROOT_DEV.
>       [POWERPC] 83xx: use default value of loops_per_jiffy
>       [POWERPC] 83xx: Use of_platform_bus_probe to setup QE devices
>       [POWERPC] 83xx: Updated and renamed MPC8360PB to MPC836x MDS
>       [POWERPC] 83xx: Renamed MPC8323 MDS dts and defconfig to  
> match other boards
>       [POWERPC] 85xx: Cleaned up platform dts files
>       [POWERPC] 85xx: Cleaning up machine probing
>       [POWERPC] 85xx: Renamed MPC8568 MDS board code to match other  
> boards
>
> Timur Tabi (1):
>       [POWERPC] QE: clean up ucc_slow.c and ucc_fast.c

For anyone that wants to gripe at me for not having the diffs for my  
patches on the list feel free to.  I was too lazy generate split out  
patches/diffs and email all of them to the list.  I need to get git- 
send-email working, just haven't had time.

The tree's on kernel.org, and if someone wants a particular patch  
mailed to the list let me know and I'm happy to send it.

- k
