Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 133F9DE1C8
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jun 2008 02:08:25 +1000 (EST)
Message-Id: <875E181C-F64C-4763-978A-CD8CB41049E6@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20080523163854.GA16137@polina.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [PATCH 1/7] [POWERPC] sysdev: implement FSL GTM support
Date: Tue, 10 Jun 2008 11:08:17 -0500
References: <20080523163811.GA12181@polina.dev.rtsoft.ru>
	<20080523163854.GA16137@polina.dev.rtsoft.ru>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 23, 2008, at 11:38 AM, Anton Vorontsov wrote:

> GTM stands for General-purpose Timers Module and able to generate
> timer{1,2,3,4} interrupts. These timers are used by the drivers that
> need time precise interrupts (like for USB transactions scheduling for
> the Freescale USB Host controller as found in some QE and CPM chips),
> or these timers could be used as wakeup events from the CPU deep-sleep
> mode.
>
> Things unimplemented:
> 1. Cascaded (32 bit) timers (1-2, 3-4).
>   This is straightforward to implement when needed, two timers should
>   be marked as "requested" and configured as appropriate.
> 2. Super-cascaded (64 bit) timers (1-2-3-4).
>   This is also straightforward to implement when needed, all timers
>   should be marked as "requested" and configured as appropriate.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> Documentation/powerpc/booting-without-of.txt |   32 ++
> arch/powerpc/Kconfig                         |    6 +
> arch/powerpc/sysdev/Makefile                 |    1 +
> arch/powerpc/sysdev/fsl_gtm.c                |  434 +++++++++++++++++ 
> +++++++++
> include/asm-powerpc/fsl_gtm.h                |   47 +++
> 5 files changed, 520 insertions(+), 0 deletions(-)
> create mode 100644 arch/powerpc/sysdev/fsl_gtm.c
> create mode 100644 include/asm-powerpc/fsl_gtm.h


applied.

- k
