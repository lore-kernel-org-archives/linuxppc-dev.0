Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao08.cox.net (fed1rmmtao08.cox.net [68.230.241.31])
	by ozlabs.org (Postfix) with ESMTP id 2DC2C2BC0F
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Sep 2004 16:37:54 +1000 (EST)
Date: Mon, 27 Sep 2004 23:37:49 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Message-ID: <20040927233749.E30772@home.com>
References: <4153A362.8010604@sonartech.com.au>
	<AE8972FB-0E3A-11D9-BC8B-000A95A4DC02@kernel.crashing.org>
	<4158DD68.2060707@sonartech.com.au>
	<20040927221323.A30581@home.com>
	<C617C694-1110-11D9-8370-000A95A4DC02@kernel.crashing.org>
	<20040927224825.B30772@home.com>
	<7C908338-1113-11D9-8370-000A95A4DC02@kernel.crashing.org>
	<20040927231438.D30772@home.com>
	<F80E3944-1116-11D9-8370-000A95A4DC02@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <F80E3944-1116-11D9-8370-000A95A4DC02@kernel.crashing.org>;
	from segher@kernel.crashing.org on Tue, Sep 28, 2004 at
	01:23:53AM -0500
Cc: David Gardiner <daveg@sonartech.com.au>, linuxppc-embedded@ozlabs.org
Subject: Re: powerpc with gigabit card hanging
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Sep 28, 2004 at 01:23:53AM -0500, Segher Boessenkool wrote:
> > It is a
> > non-full-featured firmware thing.  If you take a look at MIPS, ARM,
> > SH, PPC embedded platforms you'll see a similar thing. But wait,
> > you'll even see interrupt routing tables in the decidedly not embedded
> > Alpha architecture. :) Linux does do it, and there is a very clear
> > infrastructure for managing routing tables and standard/non-standard
> > PCI swizzle mechanisms.
> 
> Sure.  But the interrupt _assignment_ should be done by firmware.

I can't argue with ideaology.
 
> > Again, on some platforms, not this one. Let's just agree that
> > not everything is a x86/BIOS or ppc64/pmac/OF machine that
> > has this done in some blackbox firmware.
> 
> Oh, I believe that.  But the firmware should be fixed, not a
> terrible hack added to Linux.
> 
> Segher
> 
> p.s.  And I know this isn't always practically possible; but why
> then support a product like that at all, in the Open Source
> community?

By this reasoning, we should also not support the many BIOS/OF
platforms that report incorrect data and have to have their
reported data fixed up by the kernel. That's gross too by the
same measure.

To answer your question, we support the products because other
than this one minor detail, the platforms generally have merits
that far outweigh the "horrors" of having a very concise interrupt
routing table in the kernel. The same reasoning is true in the case
of BIOS/OF bugs that are worked around. it's not practical to
fix that firmware, but we don't throw away those platforms in
defiance. Frankly, there wouldn't be much of anything in the
kernel (anything with a PCI quirk must go).

More importantly, the maintainers of the kernel, from Linus down
through each architecture have made this practice acceptable
policy for many many years.

-Matt
