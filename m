Message-Id: <199903240643.AAA25012@wolfram.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: PB G3 Video (for the developers) 
In-reply-to: <199903240106.PAA30761@uhhepm.phys.hawaii.edu> 
References: <199903240106.PAA30761@uhhepm.phys.hawaii.edu>
Date: Wed, 24 Mar 1999 00:43:55 -0600
From: Brian Downing <bdowning@wolfram.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 23 Mar 1999 15:06:11 -1000 (HST), Dean Takemori writes:
 > [snip]
 > 
 > The rest of the post can be found at:
 > http://lists.linuxppc.org/listarcs/linuxppc-dev/199903/msg00209.html
 > 
 > For what it's worth, I hand patched a 2.2.4 kernel with the 
 > included patch, and got atyfb to work on my PB G3 series.
 > Finally.  I can actually scroll in nedit in real time now.

Same here.  X is fast now!

Interestingly enough, my video card (which reports the same version
as the post mentioned above) takes a 40 MHz mclk, not a 100 MHz one.
I also had to turn off backing-store in X - otherwise I got strange
graphical glitches (like the twm menu coming up blank until the options
were highlighted with the mouse).

-bcd
--
**               Brian Downing
**  UNIX Systems Administrator
**        bdowning@wolfram.com

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
