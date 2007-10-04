Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [208.123.74.7])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E3FB5DDE00
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Oct 2007 22:48:31 +1000 (EST)
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 2/5] Add initial MPC8610 HPCD Platform files. 
In-Reply-To: Your message of "Wed, 03 Oct 2007 23:35:18 CDT."
	<44FE7AFC-1883-49A1-A781-6D966653EDF4@kernel.crashing.org>
References: <1191442173.21463.77.camel@ld0161-tx32>
	<20071004134115.cc099dd1.sfr@canb.auug.org.au>
	<44FE7AFC-1883-49A1-A781-6D966653EDF4@kernel.crashing.org>
Date: Thu, 04 Oct 2007 07:48:24 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1IdQ7s-0006DC-8I@jdl.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Xianghua Xiao <x.xiao@freescale.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day Kumar Gala mumbled:
> 
> On Oct 3, 2007, at 10:41 PM, Stephen Rothwell wrote:
> 
> > On Wed, 03 Oct 2007 15:09:33 -0500 Jon Loeliger <jdl@freescale.com>  
> > wrote:
> >>
> >> +++ b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
> >> +#include <linux/stddef.h>
> >> +#include <linux/kernel.h>
> >> +#include <linux/pci.h>
> >> +#include <linux/kdev_t.h>
> >> +#include <linux/delay.h>
> >> +#include <linux/seq_file.h>
> >> +
> >> +#include <asm/system.h>
> >> +#include <asm/time.h>
> >> +#include <asm/machdep.h>
> >> +#include <asm/pci-bridge.h>
> >> +#include <asm/mpc86xx.h>
> >> +#include <asm/prom.h>
> >
> > You should include linux/of.h as well to use the of_ accessor  
> > functions.
> 
> added.
> 
> - k

Thanks, Kumar.

jdl
