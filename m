Date: Wed, 5 May 1999 13:50:41 -0400 (EDT)
From: Tom Rini <tmrini@ntplx.net>
To: Sriranga Veeraraghavan <ranga@CSUA.Berkeley.EDU>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: USB under LinuxPPC 
In-Reply-To: <199905050555.WAA23579@soda.CSUA.Berkeley.EDU>
Message-ID: <Pine.LNX.4.05.9905051349460.667-100000@pc.wackyland.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 4 May 1999, Sriranga Veeraraghavan wrote:

> 
> > Er, SMP uusbd?  uusbd currently doesn't have all the locking requires for
> > SMP to work. Linus' simple USB code might work on SMP, but doens't have an
> > OHCI driver that works yet.
>  
> I tried to make some simple patches to the uusb code to support
> locking using the same locking strategy as the vmscan.c and other
> kernel files, but there were too many things to fix.
> 
> Where can I pick up a copy of Linus's USB driver? It does not seem to
> be included with my 2.2.5 kernel sources.

It's in 2.2.7.  But it does not have a OHCI controler (ie everything
that's not from intel).

> I am about to reveal my limited knowledge of USB, but what is the OHCI
> driver and will I need it to use a USB mouse or keyboard?

It's the controller you plug your keyboard/mouse into. :)

> Anyway, I wish I had the time to do a complete patch. I really would
> like to get usb running on my 7600. But if it is a tradeoff between
> SMP and USB, I'll pick 800 bogoMIPS over a three button mouse. :-)

Yeah, that's a bit of a shame..

---
Tom Rini (TR1265)
http://dobbstown.yeti.edu/


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
