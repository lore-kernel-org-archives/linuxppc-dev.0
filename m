Message-Id: <200004040704.DAA18307@shell.faradic.net>
Date: Tue, 04 Apr 2000 03:04:31 EDT
From: jingai <jingai@floatingpenguins.com>
To: "Timothy A. Seufert" <tas@mindspring.com>; jingai@floatingpenguins.com; linuxppc-dev@lists.linuxppc.org
Subject: Re: Re: DMA Sound split & Atari800
Reply-To: jingai@floatingpenguins.com
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> At 1:25 AM -0400 4/3/00, jingai wrote:
> >I am trying to build Atari800 (the emulator) with sound support, and so
far
> >I have been successful, except that the output is very 'jittery.'
>
> Do you know whether this behavior is unique on Linux for PowerPC?
> That is, does it also do it on x86?  It may just be a problem with
> the emulator; emulation of the sound chips on old computers is a
> tricky job.

I am assuming that this is not a problem with the x86 port, since the sound
support for UNIX is geared towards Linux on x86, and I have yet to read
such a complaint on the Atari800 mailing list..

> It could also be a bug in the emulator.  For example, it may be
> assuming that the sound chip has a buffer length similar to whatever
> is common on x86, causing it to screw up when it's in a different
> world.

That's what I am thinking, but as I said, I just haven't had the time to
delve much into the PPC sound stuff in the kernel... so I was just asking
for some help.. I may try again this weekend if I don't have to work, but
then my girlfriend would probably hate me even more :)  I'm already
spending a good 12-16 hours/day at work... (some advice for everyone:
never accept a job at a small company that's been around for 15 years, has
10 software products, and no current developers.. all of this ==
nightmares, headaches, lack of sleep, etc :)

-j

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
