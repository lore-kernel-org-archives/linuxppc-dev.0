Return-Path: <jdl@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9D074DDD07
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Apr 2007 05:14:56 +1000 (EST)
Subject: Re: [PATCH 1/6] Start split out of common open firmware code
From: Jon Loeliger <jdl@freescale.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <c84b9df8fbe6f6a423cab8c3a4493409@kernel.crashing.org>
References: <20070424223245.78f4fdfb.sfr@canb.auug_.org.au>
	<f64705c9250a93dcb7a4015b9a0d5667@kernel.crashing.org>
	<AF0367BA48C55940A43CCF08DF35553C011ECCD1@az33exm24.fsl.freescale.net>
	<20070424.110456.124867547.davem@davemloft.net>
	<c84b9df8fbe6f6a423cab8c3a4493409@kernel.crashing.org>
Content-Type: text/plain
Message-Id: <1177442063.30493.21.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Tue, 24 Apr 2007 14:14:23 -0500
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	David Miller <davem@davemloft.net>, sfr@canb.auug.org.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-04-24 at 13:18, Segher Boessenkool wrote:
> > I totally disagree that you should be changing anything
> > during these consolidations.
> 
> And I didn't say so, I actually *said* I don't think
> that should be done.
> 
> I was just remarking some really bad workarounds end
> up in more generic code now, and as such need to be
> fixed.  Not now, but *later*.
> 
> > Move the code around in one pass where you can _VERIFY_
> > that things are precisely the same and won't break.
> >
> > Then later you can get fancy and change things however you
> > wish.
> 
> Yes exactly.
> 
> > Everything so far is pure whining, and has nothing to do with
> > the substance of what Stephen is trying to accomplish, a
> > _CODE CONSOLIDATION_.  So please don't get in the way of that
> > effort.
> 
> I'm not standing in the way here, I'm quite happy with
> what Stephen is doing, great job.
> 
> I'm just pointing out some bugs/workarounds in the
> merged code (that were there before, sure) -- it would
> be lovely if they at least could be commented as being
> not-quite-right in the new code so no one reading the
> code will assume it is doing the "right thing".
> 
> 
> Segher

And to be perfectly clear, I agreed with _Segher_
just as he outlines here.

Yes, it needs to be done.  No, it does not happen
in this consolidation step.  It happens in some
subsequent step that should not be forgotten.

jdl
