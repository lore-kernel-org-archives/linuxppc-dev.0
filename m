Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 46747DDF17
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Sep 2008 10:46:47 +1000 (EST)
Subject: Re: [PATCH] fix compile failure with non modular builds
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
In-Reply-To: <1221005505.23271.18.camel@localhost.localdomain>
References: <1221005058.23271.16.camel@localhost.localdomain>
	<1221005387.14835.14.camel@pasglop>
	<1221005505.23271.18.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 10 Sep 2008 10:46:39 +1000
Message-Id: <1221007599.14835.16.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-09-09 at 19:11 -0500, James Bottomley wrote:
> On Wed, 2008-09-10 at 10:09 +1000, Benjamin Herrenschmidt wrote:
> > On Tue, 2008-09-09 at 19:04 -0500, James Bottomley wrote:
> > > commit deac93df26b20cf8438339b5935b5f5643bc30c9
> > > Author: James Bottomley <James.Bottomley@HansenPartnership.com>
> > > Date:   Wed Sep 3 20:43:36 2008 -0500
> > > 
> > >     lib: Correct printk %pF to work on all architectures
> > > 
> > > Broke the non modular builds by moving an essential function into
> > > modules.c.  Fix this by moving it out again and into asm/sections.h as
> > > an inline.  To do this, the definition of struct ppc64_opd_entry has
> > > been lifted out of modules.c and put in asm/elf.h where it belongs.
> > > 
> > > Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> > 
> > Ouch. Ack.
> 
> Actually, this is for your powerpc tree, so we actually run it through
> some extended config testing this time ...

Or rather Paul's tree :-)

He's on the way to Portland and I'm flying out tomorrow, but I'll make
sure it gets picked up.

I must admit that none of my test configs I think has module support
turned off (even if I tend to have all the stuff I need built-in).

Cheers,
Ben.
