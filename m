Message-Id: <200011210659.HAA00750@piglet.grunz.lu>
Date: Tue, 21 Nov 2000 07:59:23 +0100 (CET)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: controlfb problem (on XFree86-4.0.1 off the penguinppc.org deve
 lopment tree)
To: jens_tingleff@yahoo.com
cc: linuxppc-dev@lists.linuxppc.org, ajoshi@unixbox.com
In-Reply-To: <20001121002310.28257.qmail@web1608.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

On  20 Nov, this message from Jens Tingleff echoed through cyberspace:
> I had a look through the linuxppc-dev mailing list, and found a few
> patches to controlfb. I collected a few and made them fit in (from
> messages in September).

I see those are patches to XFree. I have no problem with controlfb,
running XFree 4.0.1 from fsirl's R5 RPMs on devel.linuxppc.org, with the
exception of the screen being displaced to the right (IIRC).

That problem I fixed for me with a patch you can find here:

http://www.cpu.lu/~mlan/linux/dev/xf4.html

> the result is that I get Xwin (yay!), if only in 15bpp (no big problem)

I only tried 1152 x 870 @ 32 bpp; that works perfectly fine for me...

Cheers

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
