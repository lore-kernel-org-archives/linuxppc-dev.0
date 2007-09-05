Return-Path: <vitb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 886BEDDE17
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Sep 2007 17:40:10 +1000 (EST)
Date: Wed, 5 Sep 2007 11:39:57 +0400
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 3/9] 8xx: Add pin and clock setting functions.
Message-ID: <20070905113957.2ed9e498@localhost.localdomain>
In-Reply-To: <20070831204418.GA3461@ld0162-tx32.am.freescale.net>
References: <20070828201127.GA24068@ld0162-tx32.am.freescale.net>
	<20070828201719.GC24260@ld0162-tx32.am.freescale.net>
	<20070830013833.4c4d5d0b@localhost.localdomain>
	<20070831204418.GA3461@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 31 Aug 2007 15:44:18 -0500
Scott Wood wrote:

> > > +	u32 mask = 7;
> > > +  
> > gotta at least briefly explain the clue here, too.  
> 
> I'm not sure what you mean... what exactly are you asking me to
> explain?
> 
> Note that this code is mostly duplicated from the existing CPM2
> version.
> 
Then it would be good to mention that in short comment block before function.


> > We're adding helper functions and should be ready that something
> > somewhere won't work as expected.  
> 
> Could you elaborate on what you expect to possibly not work, or what
> we should do to "be ready"?
Some new PQ-like board being added to powerpc. I mean, each newly-added non-static function should have some sort of
description unless it(function) is completely self-explanatory.

Just a few words either here as a comment or in patch description, what the function supposed to do
and which way, so that someone not familiar with cpm/cpm2,  would quickly understand
what's happening in there.

-- 
Sincerely, Vitaly
