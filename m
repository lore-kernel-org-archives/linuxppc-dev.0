Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DEF3CDDF40
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Sep 2007 03:37:38 +1000 (EST)
Date: Wed, 5 Sep 2007 12:37:26 -0500
From: Scott Wood <scottwood@freescale.com>
To: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: Re: [PATCH 3/9] 8xx: Add pin and clock setting functions.
Message-ID: <20070905173726.GA26917@ld0162-tx32.am.freescale.net>
References: <20070828201127.GA24068@ld0162-tx32.am.freescale.net>
	<20070828201719.GC24260@ld0162-tx32.am.freescale.net>
	<20070830013833.4c4d5d0b@localhost.localdomain>
	<20070831204418.GA3461@ld0162-tx32.am.freescale.net>
	<20070905113957.2ed9e498@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070905113957.2ed9e498@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Sep 05, 2007 at 11:39:57AM +0400, Vitaly Bordug wrote:
> > Note that this code is mostly duplicated from the existing CPM2
> > version.
> > 
> Then it would be good to mention that in short comment block before function.

The code would very quickly become unreadable if we kept comments around
for every movement of code.  Given the current state of things, it's
pretty much a given that most functions in commproc.c have a
corresponding function in cpm2_common.c, and vice versa.

I'd like to merge some of it at some point.

> > > We're adding helper functions and should be ready that something
> > > somewhere won't work as expected.  
> > 
> > Could you elaborate on what you expect to possibly not work, or what
> > we should do to "be ready"?
> Some new PQ-like board being added to powerpc. I mean, each newly-added
> non-static function should have some sort of description unless
> it(function) is completely self-explanatory.

I thought it was completely self-explanatory.

> Just a few words either here as a comment or in patch description, what
> the function supposed to do and which way, so that someone not familiar
> with cpm/cpm2, would quickly understand what's happening in there.

If they're not familiar with CPM, and want to understand how hardware
setup for it works, the user's manual for one of the chips would be a
good place to start...  As it is, it's pretty clear without knowledge of
the CPM that it's a helper function that sets and clears bits in certain
registers.

Since we seem to have differing views of the target audience, could you
suggest a specific wording that you're looking for?

-Scott
