To: Björn Lundberg <bjorn.lundberg@inu.se>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Performance 2.2.13 and USB work
References: <20000229054521.6C2385064E@brixi.research.canon.com.au> <38BCE4EF.85135592@inu.se>
From: Marcus Sundberg <erammsu@kieraypc01.p.y.ki.era.ericsson.se>
Date: 06 Mar 2000 16:11:25 +0100
In-Reply-To: Björn Lundberg's message of "Wed, 01 Mar 2000 10:37:51 +0100"
Message-ID: <kfyput8rv4y.fsf@kieraypc07.p.y.ki.era.ericsson.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Björn Lundberg <bjorn.lundberg@inu.se> writes:

> We've been using 2.2.5 and wanted to move up to 2.2.13
>
> So, we made a diff on all changes we've done on Malek's 2.2.5 and
> applied that to 2.2.13.
> We then ran a test on it and found 2.2.13 was 3 times slower than 2.2.5!
>
> We haven't analyzed what made the difference (or in fact what changes
> we've introduced to 2.2.13 with the patch, other than the reported
> conflicts).
>
> Is there anyone that experienced the same fenomena?
> What might be the reason for this?

The fact that Dan's 2.2.13 uses write through cache is one thing that
will affect performance. Grep for DC_SFWT in kernel/head.S and change
the #if 0 to #if 1.

I don't know if that's the only reason, but we don't get any
performance degradation here with 2.2.13.

//Marcus
--
Signature under construction, please come back later.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
