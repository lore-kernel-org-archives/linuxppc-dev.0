Date: Fri, 4 May 2001 16:06:04 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Sven LUTHER <luther@dpt-info.u-strasbg.fr>,
	linuxppc-dev@lists.linuxppc.org, debian-powerpc@lists.debian.org
Subject: Re: Success! (was Re: External Monitor under Pismo)
Message-ID: <20010504160604.A14752@lambda.u-strasbg.fr>
References: <20010504153459.A14533@lambda.u-strasbg.fr> <20010504135729.16644@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010504135729.16644@mailhost.mipsys.com>; from benh@kernel.crashing.org on Fri, May 04, 2001 at 03:57:29PM +0200
From: Sven LUTHER <luther@dpt-info.u-strasbg.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, May 04, 2001 at 03:57:29PM +0200, Benjamin Herrenschmidt wrote:
> >> Note that if you don't want to mess with XFree, I recently added the
> >> ability to control the CRT & LCD outputs of the Rage M3 to aty128fb in my
> >> rsync tree. The tool to control it is on www.penguinppc.org/~benh
> >
> >BTW, the recently released ibook is said to only have the capacity to mirror,
> >not act as an independent display ? can that be or is it something limited in
> >the mac drivers ? It has a 8MB embedded rage mobility 128, same as the
> >titanium i think.
>
> Don't know. Note that the support I added to aty128fb uses one head only. It
> just allow you to turn on/off the LCD and CRT output, but it's only mirroring.

So mirroring will work, i guess.

for dual head you will need X, isn't it, fbdev seems broken (well at least
those using fbgen) for dualhead anyway. Don't know if aty128fb uses fbdev.

BTW, how does the rage 128 work, it has 1 accel engine that draws to the
framebuffer memory, and one or more ramdac or digital out ports that send the
fb data to the displays.

So i suppose the you will need to use a trick similar to the matrox one to get
dual headed accelerated X to work.

But could it be possible to block this in hardware, and thus force mirroring
only operation ?

How many different rage 128 mobility are around anyway ?

Friendly,

Sven Luther

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
