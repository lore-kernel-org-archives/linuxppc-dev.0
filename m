Return-Path: <jdl@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 25E20DDE2E
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Sep 2007 06:40:03 +1000 (EST)
Subject: Re: "atomic" 64-bit math on 32-bit ppc's?
From: Jon Loeliger <jdl@freescale.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <b976a70bd1942da7e31b9a409b2de569@kernel.crashing.org>
References: <46DD3CE2.4060301@genesi-usa.com> <20070904113937.GA3994@iram.es>
	<20070904184810.GG18280@ld0162-tx32.am.freescale.net>
	<e1d766f8390851a75a6fe83800484ab7@kernel.crashing.org>
	<20070906134354.GA16153@ld0162-tx32.am.freescale.net>
	<b976a70bd1942da7e31b9a409b2de569@kernel.crashing.org>
Content-Type: text/plain
Message-Id: <1189456795.25425.93.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Mon, 10 Sep 2007 15:39:55 -0500
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-09-06 at 09:09, Segher Boessenkool wrote:
> >> Either way, it's a bit late to change this, no?
> >
> > Sure, I was just whining due to having been bitten by this sort of bug 
> > in
> > the past. :-)
> 
> Write a song about it, it's therapeutical it seems!

One of these things is not like the others,
One of these things just doesn't belong,
Can you tell which thing is not like the others 
By the time I finish my song?

Never mind.

jdl
