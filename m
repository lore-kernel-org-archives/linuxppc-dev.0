MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <14796.42915.582391.766766@ipa.ne.mediaone.net>
Date: Sat, 23 Sep 2000 08:52:51 -0400
From: R Shapiro <reshapiro@mediaone.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: xf 4.0.0/1 with rage II/rage pro -- should the ati driver work?
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


[I'm posting to dev since xf 4 support for linuxppc still seems to be
in the development stage]

Subject says it all, really.  I can't get the xf 4.0.x driver to work
either on a rev. a beige G3 with rage II or a rev. b beige G3 with
rage pro.  Should it be working, or am I wasting my time trying?  Fwiw
the r128 driver works great on my G4....

Specifics: with the ati driver selected, xf throws away my mode def,
since it thinks (incorrectly) that there isn't enough vram, and then
quits since it can't find any valid modes. In both cases I'm running
4.0.1 from Franz Sirl's linuxppc page.  I also tried 4.0.0 from the
Howarth page and got exactly the same results.  I haven't tried
compiling xf myself but I'm perfectly willing to do so if that's
likely to help (eg if there are some known ati patches missing from
the Sirl rpms).

The rev. a machine is running 2.2.15pre3 from the 2000 cd, booted via
BootX with "no video driver" checked.  The rev. b machine is running a
2.2.16 kernel compiled from kernel.org sources, booted directly from
OF.  Both are started with kernel args video=atyfb:vmode:20,cmode:16.

I can run xf 4.0.x using the fbdev driver, more or less, with an
otherwise identical XF86Config, though xf with fbdev is noticably
slower than Xpmac.rev10.  Also the screen is oddly "wrapped" on the
rage II machine with the fbdev driver: I can see the full screen but
the virtual edge starts about 75% in, instead of matching the physical
edge, and then wraps around.  I don't see this artifact on the rage
pro G3.

Eventually I want to get multiple monitors going.  I already have what
I think is a valid config file for it, but I'm guessing I'll never be
able to do it with fbdev.

A search of the lists on this topic suggested only that there were
some known issues with the ati driver some time ago, but I couldn't
find anything like a definitive answer specific to the beige G3s.

If you have any suggestions at all, please cc: me directly -- I'll see
it more quickly that way.

Thanks -

--
reshapiro@mediaone.net


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
