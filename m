Message-ID: <367C0A9A.39575D8@jlc.net>
Date: Sat, 19 Dec 1998 15:20:43 -0500
From: Dan Malek <dmalek@jlc.net>
MIME-Version: 1.0
To: "Mark S. Mathews" <mark@absoval.com>
CC: Corey Minyard <minyard@acm.org>, linuxppc-dev@lists.linuxppc.org,
        Cort Dougan <cort@persephone.cs.nmt.edu>
Subject: Re: Restructure of arch/ppc/kernel and include/asm-ppc, part 2
References: <Pine.LNX.3.96.981217133832.9446E-100000@tristar.cc.absoval.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Mark S. Mathews wrote:

> Would it be possible to keep in mind that the MBX is _not_ the only....

There have been many changes placed into the baseline and
many more to come that address these configuration issues.
When I first did the MPC8xx port almost one year ago, I used
the 860 MBX board for that work.  I tried to keep processor
and board modifications separate, but didn't always succeed.

Now that I have ported Linux to several different versions of
the 8xx and as many boards, I can say there is a better method
soon to come.  However, the flexibility of the 8xx will always
guarantee there is something not done correctly to someone's
taste.

An issue I had with the 8xx port that still exists is the amount
of kernel baggage that has to be carried along that is simply
not needed.  Some of it is thrown away as 'init' sections, but
too much still hangs around with no use.  Another souce of
the conditional compilation for 8xx is due to its not prep/chrp
or OF architecture.


> Perhaps have separate config options for the 8xx processor and the board
> design.

I don't know what baseline you are using, but the latest
ones have certainly addressed this.  It should now be
pretty clear what is processor specific and what is board
specific (at least I though I submitted all of that ;-).



    -- Dan



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
