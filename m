Message-ID: <3988AE56.BBA10EFA@student.ethz.ch>
Date: Thu, 03 Aug 2000 01:27:18 +0200
From: Michel Dänzer <daenzerm@student.ethz.ch>
MIME-Version: 1.0
To: Iain Sandoe <iain@sandoe.co.uk>
CC: linuxppc-dev@lists.linuxppc.org, Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: Updated DMASOUND patches
References: <200008021950.UAA23533@hyperion.valhalla.net>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Iain Sandoe wrote:

> 2.4.0-test5
>
> This is much more flaky **with identical code**  there is no crashing (yet)
> - but a strong tendency for almost any activity to cut off the sound.
> opening the mixer control is a really good way of doing it.  Once the panel
> is open you can restart the sound and all is hunky-dory... but...

I've noticed that 2.4.0-test4 is much more sluggish than any 2.2 kernel I've
used. Turning on DMA for the HD (yep, didn't do it automatically) helps a bit,
but not totally.


> I guess I'm a little suspicious of the new wait-queue stuff (that's really
> the only major change to the sound side).

There's a whole new kernel around the sound driver ;)


Michel


--
The three Rs of Microsoft support: Retry, Reboot, Reinstall.
______________________________________________________________________________
Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
Debian GNU/Linux (powerpc,i386) user \   member of XFree86, Team *AMIGA*, AUGS


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
