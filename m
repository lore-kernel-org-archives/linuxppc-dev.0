Date: Tue, 11 May 1999 16:21:35 -0400 (EDT)
From: Tom Rini <tmrini@ntplx.net>
To: michael cardenas <michael_cardenas@deneba.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: USB Development
In-Reply-To: <3738793B.416467E2@deneba.com>
Message-ID: <Pine.LNX.4.05.9905111618250.654-100000@pc.wackyland.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 11 May 1999, michael cardenas wrote:

> But, I am a programmer, and I'm very interested in helping develop
> linux.

yay. :)

> My question is, where can I get the kernel source to get started and
> what compiler do I use? Is there a kernel build faq? I recently
> purchased the 4.1 cd, but I already had 4.1 installed.

Well.  4.1 ships w/ BootX (and a recent kernel then, yes? 2.1.125?).  Goto
http://cvs.on.openprojects.net (I think that's it) and see howto checkout
the kernel source there.  It's the most current for ppc.

> I'd be willing to install pre r5 if I need to to work on the usb source.

Not needed..  R5 is nice tho <g>.

There are a few "problem" right now.  The current USB dev is being done on
Linus' USB stack.  OHCI (what's in most non-intel chipset based computers)
doesn't work.  OHCI is the main controller.  There is some hope tho.
linux-usb@suse.com is the current list.
http://soap.suitenine.com/usb/ has the current USB-ohci work and links to
the other OHCI driver for Linus' stack (merging soon).

---
Tom Rini (TR1265)
http://dobbstown.yeti.edu/


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
