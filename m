Return-Path: <olh@suse.de>
Received: from mx1.suse.de (mail.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D4BF867A6C
	for <linuxppc-dev@ozlabs.org>; Mon,  6 Mar 2006 18:49:57 +1100 (EST)
Date: Mon, 6 Mar 2006 08:49:53 +0100
From: Olaf Hering <olh@suse.de>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] return to OF via trap, not exit
Message-ID: <20060306074953.GE24869@suse.de>
References: <20060304191026.GA9815@suse.de>
	<200603061212.12815.michael@ellerman.id.au>
	<20060306073834.GA24869@suse.de>
	<590CA2B3-AACE-4B69-930D-9A66A42FFC83@kernel.crashing.org>
	<20060306074339.GC24869@suse.de>
	<1912CD56-027C-491D-B2A2-EA44AB4DDD14@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1912CD56-027C-491D-B2A2-EA44AB4DDD14@kernel.crashing.org>
Cc: Michael Ellerman <michael@ellerman.id.au>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 On Mon, Mar 06, Segher Boessenkool wrote:

> >>> Which is likely ok because it saves us from typing .registers
> >>> manually.
> >>
> >> I can't say that's a great argument.  How about doing the trap thing
> >> on "known-bad" platforms only?
> >
> > Can you do anything at that time anyway? I mean, reset-all pending
> > either way.
> 
> You can boot a different kernel, or try to work out what went wrong.

No, I cant, all resources are possible busy. Either way, maybe checking
what type stdout is and trap or exit depending on that.
And I dont see whats bad about 'trap handler called', other than being
verbose.
