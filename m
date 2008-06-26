Return-Path: <bunk@kernel.org>
Received: from smtp5.pp.htv.fi (smtp5.pp.htv.fi [213.243.153.39])
	by ozlabs.org (Postfix) with ESMTP id 39AF2DE04A
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jun 2008 02:23:29 +1000 (EST)
Date: Thu, 26 Jun 2008 19:21:18 +0300
From: Adrian Bunk <bunk@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 48/60] microblaze_v4: headers simple files - empty or
	redirect to asm-generic
Message-ID: <20080626162118.GG22025@cs181140183.pp.htv.fi>
References: <1214483429-32360-1-git-send-email-monstr@seznam.cz>
	<1214483429-32360-48-git-send-email-monstr@seznam.cz>
	<1214483429-32360-49-git-send-email-monstr@seznam.cz>
	<200806261735.12738.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <200806261735.12738.arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
	Michal Simek <monstr@monstr.eu>, vapier.adi@gmail.com,
	matthew@wil.cx, microblaze-uclinux@itee.uq.edu.au,
	linux-kernel@vger.kernel.org, drepper@redhat.com,
	linuxppc-dev@ozlabs.org, will.newton@gmail.com, hpa@zytor.com,
	monstr@seznam.cz, John.Linn@xilinx.com, john.williams@petalogix.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jun 26, 2008 at 05:35:11PM +0200, Arnd Bergmann wrote:
> On Thursday 26 June 2008, monstr@seznam.cz wrote:
> > +
> > +#ifndef _ASM_MICROBLAZE_NAMEI_H
> > +#define _ASM_MICROBLAZE_NAMEI_H
> > +
> > +#ifdef __KERNEL__
> > +
> > +/* This dummy routine maybe changed to something useful
> > + * for /usr/gnemul/ emulation stuff.
> > + * Look at asm-sparc/namei.h for details.
> > + */
> > +#define __emul_prefix() NULL
> > +
> > +#endif /* __KERNEL__ */
> > +
> > +#endif /* _ASM_MICROBLAZE_NAMEI_H */
> 
> Could you move this to asm-generic? Note that the comment is wrong,
> asm-sparc doesn't actually implement it any more, only ia64, mips and
> arm have an implementation that actually does something interesting
> here.

The comment could be nuked (as well as the #ifdef __KERNEL__), but for 
the one #define an asm-generic header would IMHO be overkill.

> 	Arnd <><

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
