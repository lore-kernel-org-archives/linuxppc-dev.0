Message-ID: <40BAFB5E.7030704@intracom.gr>
Date: Mon, 31 May 2004 12:31:10 +0300
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
Cc: Dan Malek <dan@embeddededge.com>,
	Kumar Gala <kumar.gala@motorola.com>,
	Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: 8xx-2.6 | Prolog
References: <40B4880B.1000801@intracom.gr> <B89F9AE2-AFF4-11D8-89B7-003065F9B7DC@embeddededge.com> <20040527223423.GM6763@smtp.west.cox.net>
In-Reply-To: <20040527223423.GM6763@smtp.west.cox.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Tom Rini wrote:

>On Thu, May 27, 2004 at 11:44:21AM -0400, Dan Malek wrote:
>
>
>
>>On May 26, 2004, at 8:05 AM, Pantelis Antoniou wrote:
>>
>>
>>
>>>Awaiting comments.
>>>
>>>
>[snip]
>
>
>>... We can't define update_mmu_cache
>>as a null function.  It performs a necessary function of cache
>>management.  We may just be lucky because the caches on the 8xx
>>are small, but this is a subtle bug waiting to happen.
>>
>>
>
>Are you certain?  This is something in 2.4, and while I am having weird
>problems locally (that I can't rule out as being hw issues), adding that
>change in is what gets me a working init=/bin/bash.
>
>
>
>>I did not check these in.  Tom can you do so and make sure other
>>8xx boards will at least compile?  I'll fix up the stuff I don't like
>>later :-)
>>
>>
>
>I'm going to be checking this all in momentarily.  On my system right
>now, I can get both of my rpxlite's to init=/bin/bash, mostly working,
>if and only if I use the new uart driver and if I configure it for SMC1
>AND SCC1 (which seems wrong).
>
>
>
Problem persists.

While it no longer crashes it is unbearably slow.

I suspect that it does not update properly the page
tables on a data/instruction access fault.

Regards

Pantelis

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
