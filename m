Message-Id: <l03130301b3b2ec750e23@[216.67.46.46]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Wed, 14 Jul 1999 21:46:08 -0400
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
From: "Michael R. Zucca" <mrz5149@acm.org>
Subject: Minor atyfb problems/observations
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Ok, with the latest fifo patch in place I no-longer get the flickering
pixels on the left side of my screen. However, I think there's another
problem which may not be X-Server related.

I use the drag-style for windows which draws an outline of the window
rather than a solid window.
When I do this I get a sort of flickering of black down the left side when
I'm dragging the window
around. What could be the cause of that problem?

I have also noted that my card, an XClaimVR with RagePRO tends to like a
MCLK of 75. 63 is a bit too
slow and a clock rate of 100 causes windows to have their contents get
garbled when I use solid window movement.

One other item of note is that the XFree68 server has a problem with 16 bit
color mode. It seems to present colors a little brighter than it should
while the accelerated X-pmac server seems to have no trouble with this mode.


_______________________________________________________________________
 Michael Zucca - mrz5149@acm.org - http://www.mdc.net/~mrz5149/
 "I will choose a path that's clear. I will choose Freewill. "
  --Rush, Freewill
_______________________________________________________________________



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
