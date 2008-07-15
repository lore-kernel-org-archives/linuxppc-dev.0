Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DD394DEB1E
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jul 2008 23:14:26 +1000 (EST)
Message-Id: <A9DE9759-7CF3-4E9E-AB2E-4D7C80137D1E@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20080711230441.GB3854@loki.buserror.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCH 3/6] mpc83xx: Power Management support
Date: Tue, 15 Jul 2008 08:14:17 -0500
References: <20080711230441.GB3854@loki.buserror.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 11, 2008, at 6:04 PM, Scott Wood wrote:

> Basic PM support for 83xx.  Standby is implemented as sleep.
> Suspend-to-RAM is implemented as "deep sleep" (with the processor
> turned off) on 831x.
>
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
> arch/powerpc/Kconfig                      |    2 +-
> arch/powerpc/platforms/83xx/Makefile      |    1 +
> arch/powerpc/platforms/83xx/suspend-asm.S |  533 ++++++++++++++++++++ 
> +++++++++
> arch/powerpc/platforms/83xx/suspend.c     |  388 +++++++++++++++++++++
> arch/powerpc/sysdev/fsl_soc.h             |    1 +
> arch/powerpc/sysdev/ipic.c                |   71 ++++
> include/asm-powerpc/reg.h                 |    4 +
> include/linux/fsl_devices.h               |    6 +
> 8 files changed, 1005 insertions(+), 1 deletions(-)
> create mode 100644 arch/powerpc/platforms/83xx/suspend-asm.S
> create mode 100644 arch/powerpc/platforms/83xx/suspend.c

applied.

- k
