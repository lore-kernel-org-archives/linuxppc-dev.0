Date: Wed, 26 Apr 2000 15:40:26 -0700
From: Tim Wojtulewicz <Tim.Wojtulewicz@NAU.EDU>
Subject: Re: Dual head on a Powerbook
In-reply-to: <200004262125.XAA14159@macocotte.inria.fr>
To: Jean-Jacques.Levy@inria.fr, linuxppc-dev@lists.linuxppc.org
Message-id: <p04310101b52d1fabac8e@[134.114.15.89]>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
References: <200004262125.XAA14159@macocotte.inria.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 11:25 PM +0200 4/26/00, Jean-Jacques Levy wrote:
>Already asked this question on Sun, 21 Nov 1999. And on Mon, 3 Jan 2000.
>On Tue, 4 Jan 2000, there was following answer from Benh:
>
>  "features like mirroring and multi-head provided by the
>   Rage LT and LT Pro video controllers of the PowerBook are not enabled by
>   Linux drivers. I know Brad Midgley is working on implementing the LT Pro
>   multihead. It would probably be possible to more easily enable simple
>   mirroring if someone takes the time to hack into the driver."
>
>In the linuxcare web page, it's mentioned that
>
>   "the video acceleration problem is truly weird, you can write to
>    certain registers and only some bits go in, the other bits are stuck."
>
>Myself, for a presentation, I boot (No Video Driver option) with video
>on the external projector, and blank screen on LCD. It works; it's
>very unconvenient; it's with Xpmac (otherwise too slow).
>
>I would love to know current status. Is it not simpler to make a patch
>for video mirroring? Which is enough for presentations.  Multihead is
>a luxurious solution.
>
>-JJ-

I've tried a couple of things, including setting up the video
settings in MacOS and restarting to linux.  That doesn't work.  At
the point where the display is first "initiailized", some text
appears on the external monitor.  I haven't been able to read the
message completely and write it down, but I know it has some thing to
do with "OF quiescence" and "fake <something>".  I'm not to
experienced with the PPC drivers and such, so I would have no idea
what these mean.

My current setup is now:  Pismo Powerbook, LinuxPPC 2000, current
linux-pmac-stable kernel (2.2.15-pre19), Xpmac.rev10

Tim
--

-------
Tim Wojtulewicz           Tim.Wojtulewicz@nau.edu
(520)523-2543             http://dana.ucc.nau.edu/~tjw4

In the Windows world, you are one click away from
harming yourself -- Elias Levy, Bugtraq

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
