Date: Mon, 01 May 2000 08:17:53 -0700
From: Matthew Locke <mlocke@jps.net>
Subject: RE: X-server for the mpc823 LCD controller?
In-reply-to: <819E3E914E0AD11194DE00805F0D100B0138B84B@fbi.infocom.dk>
To: Kim Jxrgensen <KIJ@infocom.dk>
Cc: linuxppc-embedded@lists.linuxppc.org
Message-id: <NDBBJCEBJMJJJBIMCFBEEEIOCCAA.mlocke@jps.net>
MIME-version: 1.0
Content-type: text/plain; charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> I would like to run X-windows (or something similar) on my custom mpc823
> board. So I'm looking for a X-server for the mpc823 LCD
> controller, is there
> any one out there?

Check out http://www.microwindows.org  It is a small graphics engine with a
Win32 API and a X-like API.  The current verison supports Embedded Planet's
LinuxPlanet box (0.88pre7, I think)

btw, I am finishing up a touch screen driver for LinuxPlanet that works with
Microwindows.  Check the Montavista ftp site in the next week or so.  I will
make another anouncement when it is there.

>
> I have used the RPXL LCD frame buffer on my RPXL board, with the program
> dispbmp. Is the source code available for this program?

If you bought a LinuxPlanet, you should have the source on the CD from
Embedded Planet.

> Can any existing graphical server use this frame buffer?

I don't think so (execpt microwindows). I am not totally familiar with the
linux fb device, but I believe the lcd driver needs a little more work to
look like a linux fb device. Or you will need to hack the server to use our
lcd driver.

Matthew Locke
Embedded Planet
S/W Development


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
