To: linuxppc-dev@lists.linuxppc.org
Subject: R128 Scaling.
From: Stefan Berndtsson <stefan@nocrew.org>
Date: 16 Apr 2002 13:49:12 +0200
Message-ID: <878z7nuamf.fsf@hades.nocrew.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


What is the status of the scaling registers for rage128? I saw a patch
in the archive, that adds scaling capabilities for the framebuffer,
and that seems to work reasonably well.

When running XF4.1, with UseFBDev, I can switch resolutions, and they
scale nicely.

When running XF4.2, with UseFBDev, the situation is more or less the same.

When running XF4.2, without UseFBDev, scaling is no longer available, which
makes sense if it's a patch in the framebuffer.

When running something in DGA (xmame for example), with XF4.1 and UseFBDev,
the resolution is changed by MAME, but it seems it still gets the fullsize
resolution passed to it, because it draws completely distorted graphics.
The area indicates that 1024x768 is passed as resolution even though the
display is set to 640x480 using scaling.

I'm using an ibook (autumn 2001), with 2.4.19-pre6-ben0 patched with the
mentioned framebuffer patch.

The system is debian, with a patched r128_drv.o since the default one
for XF4.1 doesn't do any sensible DGA for me.

The XF4.2 was unpatched in the test, and I'm using the test preview from
Michel Dänzer, as of 2002-04-01.

Will XF4.1/4.2 be able to scale and do DGA on this machine?

It seems, things are close to working, but I might miss some big problem
with it. I assume something is in the way, since it's been out since November,
and it's not in Ben's kernel.

It would be very nice to be able to run MAME and other programs in
fullscreen. :)

/Stefan Berndtsson

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
