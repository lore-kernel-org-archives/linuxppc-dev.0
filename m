Date: Sat, 27 Oct 2001 18:56:47 -0600 (MDT)
From: Derrik Pates <dpates@dsdk12.net>
To: <linuxppc-dev@lists.linuxppc.org>
Subject: GeForce on PPC == _no work_
Message-ID: <Pine.LNX.4.33.0110271844230.15267-100000@andromeda.dsdk12.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Well, I got to install Debian on an Apple G4 Quicksilver tower system. I
have it upgraded with a 2.4.13 kernel, but I can't get the nVidia GeForce2
MX board that the system comes with to work. I managed to locate Ani
Joshi's patches, for the XFree nv driver, and the kernel's 'rivafb'
driver. The system in question has a 1280x1024 flat-panel display
(somewhere around 20" diagonal) connected via the ADC port on the nVidia
board.

My results: the rivafb driver does not work. If I let it use its default
(built-in) settings, it doesn't work right at all. The video is "squished"
into the top of the display (the default mode is 640x480). You can see
what looks like all the pixels that should be there, but the text is, of
course, illegible. Changing the internal parameters to use a 1280x1024
mode causes no video at all - it never clears the initial OpenFirmware
messages at all, but does manage to boot normally (I could hear it
booting, was able to login and reboot cleanly).

The 'nv' driver for XFree was a similar story, but worse. Once I finally
realized I needed to specify the BusID to the driver, starting XFree86
caused pretty pink stripes to appear on the display, followed by a cold
lock (no pings, an SSH session into the box did not respond after starting
XFree86).

Is there any hope for this system? Or is this an exercise in futility
until nVidia decides to port and release their Linux binary drivers for
PPC? I'd like to get X working on this box (I know I won't get 3D with the
'nv' driver - don't care, just want 2D).

Derrik Pates      |   Sysadmin, Douglas School   |    #linuxOS on EFnet
dpates@dsdk12.net |     District (dsdk12.net)    |    #linuxOS on OPN


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
