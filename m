Message-Id: <l03130301b6e64356789c@[24.218.240.205]>
In-Reply-To: <Pine.LNX.4.21.0103270151180.23261-100000@like.mine.nu>
References: <l03130302b6e460bd2e0b@[24.218.240.205]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Tue, 27 Mar 2001 08:20:03 -0500
To: phandel@cise.ufl.edu
From: "Michael R. Zucca" <mrz5149@acm.org>
Subject: Re: Sound stoppage
Cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 4:58 AM -0500 3/27/01, phandel@cise.ufl.edu wrote:
>On Sun, 25 Mar 2001, Michael R. Zucca wrote:
>
>> I'm having a problem with sound stopping when I'm trying to use it at the
>> same time as X.
>
>I've been noticing this problem for years with my PowerCenter Pro 210, and
>it still occurs with 2.4.x.  I do have a 2.2.10 Cort built that does not
>have this bug, although we can't figure out what was different.
>
>By the way, try moving your mouse slowly while music is playing, as fast
>mouse movements / window drags acerbate this bug.

I'd be willing to bet this is the dbdma bug Iain mentioned. Like the dma
controller's getting wedged and the driver waits and waits for it to
complete a transaction. I can wait for the fix.

Thanks everybody!

____________________________________________________________________
 Michael Zucca - mrz5149@acm.org - http://www.mdc.net/~mrz5149/
 "I will choose a path that's clear. I will choose Freewill. "
  --Rush, Freewill
____________________________________________________________________


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
