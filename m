Return-Path: <vitb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5663BDDFE9
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jul 2008 03:50:55 +1000 (EST)
Date: Thu, 24 Jul 2008 21:50:32 +0400
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: Jochen Friedrich <jochen@scram.de>
Subject: Re: [PATCH] watchdog: delete unused driver mpc8xx_wdt.c
Message-ID: <20080724215032.0d940f0f@vitb-lp.dev.rtsoft.ru>
In-Reply-To: <488857CD.6080007@scram.de>
References: <488857CD.6080007@scram.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, wim@iguana.be, "Kernel,
	Linux" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

В Thu, 24 Jul 2008 12:22:05 +0200
Jochen Friedrich <jochen@scram.de> пишет:

> The watchdog driver mpc8xx_wdt.c was a device interface to
> arch/ppc/syslib/m8xx_wdt.c for MPC8xx hardware. Now that ARCH=ppc is
> gone, this driver is of no more use. For ARCH=powerpc, MPC8xx hardware
> is supported by mpc8xxx_wdt.c.
> 
> Signed-off-by: Jochen Friedrich <jochen@scram.de>

Acked-by: Vitaly Bordug <vitb@kernel.crashing.org>

-Vitaly
