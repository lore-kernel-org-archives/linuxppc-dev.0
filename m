Return-Path: <zippel@linux-m68k.org>
Received: from smtp-vbr11.xs4all.nl (smtp-vbr11.xs4all.nl [194.109.24.31])
	by ozlabs.org (Postfix) with ESMTP id B2A08DDF58
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jul 2008 00:59:53 +1000 (EST)
Date: Thu, 10 Jul 2008 16:59:25 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: linux-next: kbuild tree build failure
In-Reply-To: <1215651082.13950.7.camel@localhost>
Message-ID: <Pine.LNX.4.64.0807101654080.6791@localhost.localdomain>
References: <20080707184038.aaeb8d40.sfr@canb.auug.org.au>
	<Pine.LNX.4.64.0807071424240.6791@localhost.localdomain>
	<1215473798.8138.4.camel@localhost>
	<Pine.LNX.4.64.0807080437550.6791@localhost.localdomain>
	<1215651082.13950.7.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>,
	Sam Ravnborg <sam@ravnborg.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

On Thu, 10 Jul 2008, Michael Ellerman wrote:

> Well yes :)  But I think that's because you're thinking of 
> "end-users" and I'm thinking of "users" like myself - ie. _I_ use
> Kconfig and I do expect myself to be able to type a 64-bit address.

That doesn't really answer my question, why you need this.

> > > --- .config.orig	2008-07-08 09:30:00.000000000 +1000
> > > +++ .config	2008-07-08 09:30:43.000000000 +1000
> > > @@ -370,9 +370,8 @@
> > >  CONFIG_HOTPLUG_PCI_RPA=m
> > >  CONFIG_HOTPLUG_PCI_RPA_DLPAR=m
> > >  # CONFIG_HAS_RAPIDIO is not set
> > > -CONFIG_PAGE_OFFSET=0xc000000000000000
> > > -CONFIG_KERNEL_START=0xc000000002000000
> > > -CONFIG_PHYSICAL_START=0x02000000
> > > +CONFIG_PAGE_OFFSET=0xc0000000
> > > +CONFIG_PHYSICAL_START=0x2000000
> > 
> > Why is this worse? These are constants, you're not supposed to change them 
> > anyway.
> > The remaining values are generated in page.h and should be the same as 
> > before. If that isn't the case and this patch produces a nonworking 
> > kernel, I'd like to hear about it.
> 
> You're right the built kernel is fine. So it's not a bug,

Good, could someone please ack whether the powerpc changes are acceptable?

> but I think it is nicer to have the real values in the .config.

Why?

bye, Roman
