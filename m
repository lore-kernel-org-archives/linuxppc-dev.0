Message-Id: <200006030628.IAA00691@piglet.grunz.lu>
Date: Sat, 3 Jun 2000 08:28:25 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: [patch] VRAM detection in controlfb
To: toe@unlserve.unl.edu
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.LNX.3.96LJ1.1b7.1000531195040.22480A-101000@ofey.inetnebr.com>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Takashi,

On  31 May, this message from Takashi Oe echoed through cyberspace:
> [...]
>> If I hear no opposition, I'll send this off to Alan; it might make it
>> into 2.4.0-final.
>
> Actually, I have sent a similar patch to DanJ a few weeks ago.

Do you mind if I merge yours and my patch to keep your bugfixes and
enhancements, and my command line code? I think mine is easier in the
sense that you can _exactly_ specify what is in the box, including
indicating the bank for 2MB configs.

For those with multiple display adapters, do you think an option
controlfb:off might make sense? As there is no way to control which card
gets assigned which framebuffer device, that might help in certain
situations...

> The patch
> attached includes a few bug fixes as well as a feature enhancement in that
> it is now possible to program all aspects of control frame buffer
> geometry/timings to your liking; that is, you can use xvidtune to ruin
> your monitor if you are not careful.

I've had a quick try in XFree 4, but that didn't work. How did you do
that?

Also, when running Xfree 4, I get a wrapped-around screen in the sense
that the leftmost ~200 pixels appear on the _right_ side of the monitor.
Might that be the offset of pixel #1 in the framebuffer? Although,
that's around 100 bytes IIRC, so wouldn't explain the 200 pixels at 32
bit/pixel.... FWIW, I'm running Jack Howarth's XF4-12a RPMs.

Thanks

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
