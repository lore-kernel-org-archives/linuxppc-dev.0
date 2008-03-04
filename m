Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D10C4DDF53
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Mar 2008 03:58:41 +1100 (EST)
Date: Tue, 4 Mar 2008 10:58:17 -0600
From: Scott Wood <scottwood@freescale.com>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: V4L2: __ucmpdi2 undefined on ppc
Message-ID: <20080304165817.GA3853@ld0162-tx32.am.freescale.net>
References: <Pine.SOC.4.61.0612131359430.10721@math.ut.ee>
	<1166053317.909.19.camel@praia>
	<20061214195842.GA14041@athena.road.mcmartin.ca>
	<1166362145.6714.53.camel@pmac.infradead.org>
	<6a89f9d50802060639j4b3a8b7u4e4e596b010ee353@mail.gmail.com>
	<15d7ac5a7542b05fb9b9abb5d4c7a22d@kernel.crashing.org>
	<1204648648.3891.439.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1204648648.3891.439.camel@pmac.infradead.org>
Cc: Stephane Marchesin <marchesin@icps.u-strasbg.fr>, henrik.sorensen@gmail.com,
	paulus@samba.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 04, 2008 at 04:37:28PM +0000, David Woodhouse wrote:
> 
> On Sun, 2008-03-02 at 22:53 +0100, Segher Boessenkool wrote:
> > Every occurrence of r7 here is wrong (and some of the r6).
> 
> Can you elucidate?

They were being used as condition registers rather than GPRs.

> >   Is there any reason to do this in assembler code at all?
> 
> Is there any particular reason not to?

Same reason most of the rest of the kernel is in C rather than assembly.

Of course, a better question is why we don't just link libgcc...

-Scott
