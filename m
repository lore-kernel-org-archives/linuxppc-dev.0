Message-ID: <40B6DEC8.2070605@intracom.gr>
Date: Fri, 28 May 2004 09:40:08 +0300
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: Dan Malek <dan@embeddededge.com>
Cc: Tom Rini <trini@kernel.crashing.org>,
	Kumar Gala <kumar.gala@motorola.com>,
	Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: 8xx-2.6 | Prolog
References: <40B4880B.1000801@intracom.gr> <B89F9AE2-AFF4-11D8-89B7-003065F9B7DC@embeddededge.com>
In-Reply-To: <B89F9AE2-AFF4-11D8-89B7-003065F9B7DC@embeddededge.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek wrote:

>
> On May 26, 2004, at 8:05 AM, Pantelis Antoniou wrote:
>
>> Awaiting comments.
>
>
> The interrupt stuff in patch 1 was wrong when it was done in 2.4
> and I'm disappointed to see it again in 2.6.  Unfortunately, I
> don't have time to fix it now, but it will get done properly when I
> implement the similar thing for the 8560.

Well, I had to do something. request_8xxirq & friends are unusable.

>
> In patch 4, get rid of that #if 0 around the machine check exception.
> If the code works, just check it in.  We can't define update_mmu_cache
> as a null function.  It performs a necessary function of cache
> management.  We may just be lucky because the caches on the 8xx
> are small, but this is a subtle bug waiting to happen.

OK for the #if 0.
I don't know what update_mmu_cache really does that screws up so bad.
Didn't really had to look into the matter.

>
> Why did you need to include patch 5 and 6?  These should have
> been done and checked into the trees long ago.

For completeness. So that with the patches in it would at least compile.

>
> In patch 8, why is the 8xx FEC driver dependent upon NETTA and
> NETPHONE?  All 8xx boards should use this driver, and it would have
> been nice if you would have done board specific files for all other
> 8xx boards that are supported, even if they couldn't be tested.  The
> price of making such major changes that affect everyone :-)

Well, as I explained to Tom, that was intentional :).

How many of the boards in the kernel are working,
or have someone working on them?

IMHO it's time to clean up the mess a bit.

>
> I did not check these in.  Tom can you do so and make sure other
> 8xx boards will at least compile?  I'll fix up the stuff I don't like
> later :-)
>
> Thanks.
>
>     -- Dan
>
Regards

Pantelis


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
