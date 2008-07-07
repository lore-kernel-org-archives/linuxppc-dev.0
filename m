Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CCFB5DE033
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jul 2008 08:20:18 +1000 (EST)
Subject: Re: [PATCH] powerpc: Use new printk extension %pS to print symbols
	on oops
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
In-Reply-To: <alpine.LFD.1.10.0807071006270.11076@woody.linux-foundation.org>
References: <20080707034436.BEA2DDDF35@ozlabs.org>
	<alpine.LFD.1.10.0807071006270.11076@woody.linux-foundation.org>
Content-Type: text/plain
Date: Tue, 08 Jul 2008 08:20:09 +1000
Message-Id: <1215469209.8970.139.camel@pasglop>
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

On Mon, 2008-07-07 at 10:08 -0700, Linus Torvalds wrote:
> > This changes the oops and backtrace code to use the new %pS
> > printk extension to print out symbols rather than manually
> > calling print_symbol.
> 
> Ok, I ended up committing the suppor for '%pS' early (as a series of 
> smaller patches to make it clearer), just because it makes it easier for 
> different people to start converthing things with the infrastructure in 
> place.
> 
> But I wasn't planning on actually merging any of the conversions until 
> after 2.6.26 (ie there will be no actual _users_ of '%pS' in 2.6.26)

That's ok. I posted the patch for review/comments, I didn't intend
to have it merged before .27 opens.

Cheers,
Ben.
