Message-Id: <200008151941.VAA00764@piglet.grunz.lu>
Date: Tue, 15 Aug 2000 21:41:43 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: Control fb problem on 8500
To: kevin_myer@iu13.k12.pa.us
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.LNX.4.21.0008151339190.734-100000@pegmatite.iu13.k12.pa.us>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi there,

On  15 Aug, this message from Kevin M. Myer echoed through cyberspace:
> A couple of issues have cropped up with my PowerMac 8500.  I am running
> Paulus' 2.4.0-test6 kernel and my console has developed a sort of mirror
> image on the far right one-eighth of the screen.  Basically, everything on
> the screen is mirrored in that eighth of the screen albeit much
> smaller.  For example, as I type this, tiny white lines are being drawn to
> my right.  If I were to `ls --color` a directory, different color lines
> show up.  This behaviour wasn't there in Paulus' 2.4.0-test1-ac21 kernel
> of a few rsyncs ago.

I've seen this too; but have no explanation. It might be caused by
hardware running on the limit of it's spec; control is quite picky in
this respect. But then again, something changed that made the problems
apear...

> Secondly, the video chip doesn't show up on the PCI bus.  Although XFree86
> 4.0 apparently supports the controlfb (which is what the 8500 has), it
> also needs a BusID to be used.  Am I out of luck with using XFree86 4.0 or
> newer with my machine?  Or generically, is anyone without a card on the
> PCI bus out of luck?

Since control has its own dedicated PCI-like bus (Apple calls it a
'VCI'), it will not show up as a PCI device unless you use a PCI-patched
kernel. The missing BusID is not a problem for XF4, rest assured.
However, XF4 does not support control directly, but rather through the
generic framebuffer driver.

See my page:

http://www.cpu.lu/~mlan/linux/dev/xf4.html

on how to get XF4 to work with control.

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
