MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <14801.3419.973780.175624@esb.bbn.com>
Date: Tue, 26 Sep 2000 16:55:55 -0400
From: R Shapiro <rshapiro@bbn.com>
To: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
Cc: daenzerm@student.ethz.ch,
        Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: xf 4.0.1 + ati driver with rage II/rage pro
In-Reply-To: <Pine.LNX.4.10.10009262127370.21452-100000@zirkon.biophys.uni-duesseldorf.de>
References: <39D0F7EB.C0415571@relog.ch>
	<Pine.LNX.4.10.10009262127370.21452-100000@zirkon.biophys.uni-duesseldorf.de>
Reply-To: rshapiro@bbn.com
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michael Schmitz writes:
 > > > (--) ATI(0): VideoRam: 1 kByte (EDO)
 > >
 > > That's quite little VRAM :)
 >
 > Yep, that can't really be the 2048 bug anymore.


Fwiw the probed VideoRam on my rev. b beige G3 is also some
ridiculously small number (though not as small as this) yet it runs
the ati driver without any problems.  That one has a single monitor
and Rage Pro video.


 > But that's also quite a lot of mach64 cards. Are there really two GI's in
 > the machine?

It's a three-headed machine: two Rage Pro cards plus the onboard Rage
II.  If I set all three Devices to use fbdev, X happily drives all
three displays (in xinerama, even).  It's only the ati driver that
causes the trouble.



 > You will have to pass multipe atyfb= kernel parameters to make the kernel
 > initialize one framebuffer device for each.

Right now my kernel args are

 video=atyfb:vmode:20,cmode:8

I don't know the syntax for specifying multiple atyfb's.

I'm using BootX to boot.  I tried miBoot but I couldn't get X 4.0.1 to
run at all that way, even with the fbdev driver.  I don't think quik
booting works on this machine, so BootX seems to be the only option.



 > Also helpful: a dump of the OF device tree.

Remind me how to get that and I'll try to generate one.



--
rshapiro@bbn.com


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
