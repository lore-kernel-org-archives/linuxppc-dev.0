Message-Id: <199905050555.WAA23579@soda.CSUA.Berkeley.EDU>
To: Tom Rini <tmrini@ntplx.net>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: USB under LinuxPPC 
In-Reply-To: Your message of "Tue, 04 May 1999 20:05:49 EDT."
             <Pine.LNX.4.05.9905042004520.667-100000@pc.wackyland.com>
Date: Tue, 04 May 1999 22:55:45 -0700
From: Sriranga Veeraraghavan <ranga@CSUA.Berkeley.EDU>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



> Er, SMP uusbd?  uusbd currently doesn't have all the locking requires for
> SMP to work. Linus' simple USB code might work on SMP, but doens't have an
> OHCI driver that works yet.
 
I tried to make some simple patches to the uusb code to support
locking using the same locking strategy as the vmscan.c and other
kernel files, but there were too many things to fix.

Where can I pick up a copy of Linus's USB driver? It does not seem to
be included with my 2.2.5 kernel sources.

I am about to reveal my limited knowledge of USB, but what is the OHCI
driver and will I need it to use a USB mouse or keyboard?

Anyway, I wish I had the time to do a complete patch. I really would
like to get usb running on my 7600. But if it is a tradeoff between
SMP and USB, I'll pick 800 bogoMIPS over a three button mouse. :-)


----ranga <ranga@soda.berkeley.edu>

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
