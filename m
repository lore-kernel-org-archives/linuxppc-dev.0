Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CBFC4DDF74
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Dec 2008 18:06:34 +1100 (EST)
Subject: Re: [PATCH 4/16] powerpc/fsl-booke: Fix problem with _tlbil_va
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20081215175953.aeb8d836.sfr@canb.auug.org.au>
References: <1229319836.100184.344640589620.qpush@grosgo>
	<20081215054518.EC239DDFED@ozlabs.org>
	<20081215175953.aeb8d836.sfr@canb.auug.org.au>
Content-Type: text/plain
Date: Mon, 15 Dec 2008 18:04:18 +1100
Message-Id: <1229324658.26324.108.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Kumar Gala <kumar.gala@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-12-15 at 17:59 +1100, Stephen Rothwell wrote:
> Hi Ben,
> 
> On Mon, 15 Dec 2008 16:44:21 +1100 Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> >
> > From: Kumar Gala <galak@kernel.crashing.org>
> > 
> > An example calling sequence which we did see:
> 
> This one is already in Linus' tree as of today.

Ah indeed, it wasn't in powerpc yet which is why I left in there, since
that's what my series is based on.

I expect a few of those near the top of the pile to also go separate
ways via Kumar or Josh...

I grouped all them to make the dependency chain clear and because that
way it actually builds on top of today's powerpc master :-)

Once we are passed reviews etc... we can always sort out the details on
how to merge the various bits. Hopefully soon since it's now getting
some fairly good testing by Kumar and I and some of them already has
-some- amount of review.

Cheers,
Ben.
