Message-ID: <3819E3D7.B9D7E4F3@chpc.utah.edu>
Date: Fri, 29 Oct 1999 12:13:43 -0600
From: Lou Langholtz <ldl@chpc.utah.edu>
MIME-Version: 1.0
To: Cort Dougan <cort@ppc.kernel.org>
Cc: linuxppc-dev@lists.linuxppc.org, gdt@linuxppc.org
Subject: Re: linux-2.2.13pre15 stability w/ head.S patch
References: <3818908A.8A6539B6@chpc.utah.edu> <19991028212456.B13879@chimaera.ppc.kernel.org>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Cort Dougan wrote:

> The Linus tree is in sync with by the 2.2 and 2.3 right now.  Have you
> tried 2.3.24 and/or 2.3.13?

That's great news. My bandwidth is so limited that checking this fact is
impracticle. So this helps a lot to know. I haven't tried 2.3.24 or 2.3.13 or
2.2.13 out yet either. Seems like 2.2.14's due out soon and I figured I'd just
wait.

> The changes here should only affect the boot since that's the only place
> they do anything.  Are you sure this change improved stability and now the
> recent changes to PPP from Paul? . . .

It was more speculation in part based on diff'ing different releases to see how
much PPC specific changes had occured. I've also seen reference by others on
the linuxppc-dev list that seemed to point to this code improving things
stability wise. Maybe I just misunderstood or something. I'm kind of too
crunched for time right now to dig this out --- sorry about that. I'll try
being more thourough later on when I get more time or maybe the problem will
have just been totally fixed.

Whatever the case, thanks for considering it.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
