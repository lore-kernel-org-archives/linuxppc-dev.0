From: phandel@cise.ufl.edu
Date: Sat, 07 Apr 2001 03:39:08 -0700 (PDT)
Subject: Re: DMASOUND->rev6  (2.4.3)(attn: Xine, MOL, PowerComputing, ibook,
 Tumbler)
In-reply-to: <20010405110853.8CFD5DB9DD@atlas.valhalla.net>
To: Iain Sandoe <iain@sandoe.co.uk>
Cc: linuxppc-dev@lists.linuxppc.org
Message-id: <Pine.LNX.4.21.0104070333010.1088-100000@like.mine.nu>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 5 Apr 2001, Iain Sandoe wrote:

> Please include the "i138" in any bug report -it's my local BK cset
> identifier for the patch.
[snip]
>  - fix bug where TX stops when dbdma status comes up "DEAD"
>    so far only reported on PowerComputing clones ... but.
>    (PowerComputing clones - NOT TESTED - please let me know what happens).

Nope, I can still kill sound by merely moving the mouse.  Here is the new
line from the console:

Apr  7 03:31:13 like kernel: dmasound_pmac: tx-irq: xfer died - patching
it up...

...but sound is dead, along with the player app, just as before.

This was with Paul's 2.4.3 (slight patch to work around missing
process_bridge_ranges) and both patches you mentioned in this email.



Thanks,
Peter


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
