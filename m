To: kd@flaga.is
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: zeroing of bss segments
References: <OF8CAAF2F9.EEBDCA16-ON002568C1.00597EFF@flaga.is>
From: Marcus Sundberg <erammsu@kieraypc01.p.y.ki.era.ericsson.se>
Date: 14 Apr 2000 19:10:44 +0200
In-Reply-To: kd@flaga.is's message of "Fri, 14 Apr 2000 16:20:41 +0000"
Message-ID: <kfy66tkr4kr.fsf@kieraypc01.p.y.ki.era.ericsson.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


kd@flaga.is writes:

> Well if you are talking about floating point patch and the cache line size
> patch then I have them applied.
> Are there any other patched floating around that are necessay for the
> mpc823?

No, I was referring to the cache line size patch (including removing
memset.S) as your problem sounded like what one can experience
without it. No idea then.

//Marcus
--
Signature under construction, please come back later.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
