Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao10.cox.net (fed1rmmtao10.cox.net [68.230.241.29])
	by ozlabs.org (Postfix) with ESMTP id 0828E2BC0F
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Sep 2004 17:01:37 +1000 (EST)
Date: Tue, 28 Sep 2004 00:01:24 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Message-ID: <20040928000124.H30772@home.com>
References: <AE8972FB-0E3A-11D9-BC8B-000A95A4DC02@kernel.crashing.org>
	<4158DD68.2060707@sonartech.com.au>
	<20040927221323.A30581@home.com>
	<C617C694-1110-11D9-8370-000A95A4DC02@kernel.crashing.org>
	<20040927224825.B30772@home.com>
	<7C908338-1113-11D9-8370-000A95A4DC02@kernel.crashing.org>
	<20040927231438.D30772@home.com>
	<F80E3944-1116-11D9-8370-000A95A4DC02@kernel.crashing.org>
	<20040927233749.E30772@home.com>
	<FB412DE8-1119-11D9-8370-000A95A4DC02@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <FB412DE8-1119-11D9-8370-000A95A4DC02@kernel.crashing.org>;
	from segher@kernel.crashing.org on Tue, Sep 28, 2004 at
	01:45:27AM -0500
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

On Tue, Sep 28, 2004 at 01:45:27AM -0500, Segher Boessenkool wrote:
> >> Sure.  But the interrupt _assignment_ should be done by firmware.
> >
> > I can't argue with ideaology.
> 
> It's not ideology; it's what the PCI spec says.
> 
> >> p.s.  And I know this isn't always practically possible; but why
> >> then support a product like that at all, in the Open Source
> >> community?
> >
> > By this reasoning, we should also not support the many BIOS/OF
> > platforms that report incorrect data and have to have their
> > reported data fixed up by the kernel. That's gross too by the
> > same measure.
> 
> There is a difference between patching some errors and doing
> all the work yourself.

I see your point of view and disagree.

> But hey, let not me stop you from doing this.
 
Don't worry, you won't. :)

-Matt
