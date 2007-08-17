Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 30831DDE3B
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Aug 2007 23:24:34 +1000 (EST)
In-Reply-To: <Pine.LNX.4.64.0708170000160.20987@blarg.am.freescale.net>
References: <Pine.LNX.4.64.0708170000160.20987@blarg.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <1B3B9B5A-34D3-41DA-83F8-AFDE30DDFD3F@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Please pull from 'fixes-2.6.23' branch
Date: Fri, 17 Aug 2007 08:26:21 -0500
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 17, 2007, at 12:02 AM, Kumar Gala wrote:

> Please pull from 'fixes-2.6.23' branch of
>
> 	master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git  
> fixes-2.6.23
>
> to receive the following updates:
>
>  arch/powerpc/boot/dts/mpc8544ds.dts        |   88 ++++------
>  arch/powerpc/boot/dts/mpc8641_hpcn.dts     |  114 ++----------
>  arch/powerpc/kernel/traps.c                |    4
>  arch/powerpc/platforms/85xx/Kconfig        |    1
>  arch/powerpc/platforms/85xx/mpc8544_ds.c   |  214  
> +-----------------------
>  arch/powerpc/platforms/86xx/Kconfig        |    1
>  arch/powerpc/platforms/86xx/mpc86xx_hpcn.c |  224  
> +------------------------
>  arch/powerpc/platforms/Kconfig             |    8
>  arch/powerpc/platforms/Makefile            |    3
>  arch/powerpc/platforms/fsl_uli1575.c       |  255 +++++++++++++++++ 
> ++++++++++++
>  arch/powerpc/sysdev/rtc_cmos_setup.c       |   15 +
>  include/asm-powerpc/reg_booke.h            |   12 +
>  12 files changed, 386 insertions(+), 553 deletions(-)
>
> Becky Bruce (1):
>       [POWERPC] Fix FSL BookE machine check reporting
>
> Kumar Gala (2):
>       [POWERPC] Add interrupt resource for RTC CMOS driver
>       [POWERPC] Fix interrupt routing and setup of ULI M1575 on FSL  
> boards

I've added the following fix to this branch:

[PATCH] [POWERPC] Fix 8xx compile failure

- k
