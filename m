Date: Thu, 27 May 2004 15:34:24 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Dan Malek <dan@embeddededge.com>
Cc: Pantelis Antoniou <panto@intracom.gr>,
	Kumar Gala <kumar.gala@motorola.com>,
	Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: 8xx-2.6 | Prolog
Message-ID: <20040527223423.GM6763@smtp.west.cox.net>
References: <40B4880B.1000801@intracom.gr> <B89F9AE2-AFF4-11D8-89B7-003065F9B7DC@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <B89F9AE2-AFF4-11D8-89B7-003065F9B7DC@embeddededge.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, May 27, 2004 at 11:44:21AM -0400, Dan Malek wrote:

>
> On May 26, 2004, at 8:05 AM, Pantelis Antoniou wrote:
>
> >Awaiting comments.
[snip]
> ... We can't define update_mmu_cache
> as a null function.  It performs a necessary function of cache
> management.  We may just be lucky because the caches on the 8xx
> are small, but this is a subtle bug waiting to happen.

Are you certain?  This is something in 2.4, and while I am having weird
problems locally (that I can't rule out as being hw issues), adding that
change in is what gets me a working init=/bin/bash.

> I did not check these in.  Tom can you do so and make sure other
> 8xx boards will at least compile?  I'll fix up the stuff I don't like
> later :-)

I'm going to be checking this all in momentarily.  On my system right
now, I can get both of my rpxlite's to init=/bin/bash, mostly working,
if and only if I use the new uart driver and if I configure it for SMC1
AND SCC1 (which seems wrong).

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
