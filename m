Subject: Re: zeroing of bss segments
To: erammsu@kieraypc01.p.y.ki.era.ericsson.se (Marcus Sundberg)
Date: Mon, 17 Apr 2000 13:46:29 +1000 (EST)
Cc: kd@flaga.is, linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <kfy66tkr4kr.fsf@kieraypc01.p.y.ki.era.ericsson.se> from "Marcus Sundberg" at Apr 14, 2000 07:10:44 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20000417034629.BEE611B172@elph.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Marcus Sundberg writes:
> No, I was referring to the cache line size patch (including removing
> memset.S) as your problem sounded like what one can experience
> without it. No idea then.

I've been tripped up by this too; upgraded my glibc and applied the patches,
but forgot to nuke memset.S. Is anyone working towards getting a proper fix
for this into the mainline glibc?

Regards,
Graham

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
