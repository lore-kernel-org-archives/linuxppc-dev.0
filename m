Message-ID: <D73A25AA6E54D511AD74009027B1110F237026@ORION>
From: Ken Applebaum <applebaumk@embeddedplanet.com>
To: "'RSR - Dominioni Piero'" <pdominioni@rsr.it>,
	Dan Malek <dan@embeddededge.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: Lite LCD on MBX860
Date: Thu, 28 Feb 2002 09:48:56 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


For some reason, this request has come up a lot lately. we make an 860 board
and a video board with an Epson video controller on it.

The 860 does not have video out, but you can certainly attach a video chip
to it. We used the Epson SED1386 which is now called the S1D13806. You can
find the Linux driver at:
http://www.erd.epson.com/vdc/html/contents/S1D13806.htm#drivers

Ken

-----Original Message-----
From: RSR - Dominioni Piero [mailto:pdominioni@rsr.it]
Sent: Thursday, February 28, 2002 2:40 AM
To: Dan Malek
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Litle LCD on MBX860



Hi all.
 I wanted to connect a LCD to a MPC823-based board and to use
microwindows too .

Dan Malek answered:
> You aren't going to connect an LCD to the MBX860 and see anything.
> There isn't any LCD controller on the 860.  You need an 823 or
> some external graphics controller.

Correct.
But what happens when the externel controller is provided?
Is there a LinuxPPC driver for it?
Does the LCD device become such as a character device
(or something like that) that needs a suitable node in /dev
with its own driver to be registered?

I tryed to configure Wolfgang's 2.4.4-2001-11-24 kernel for
TQM860L and while (obviously) there is no LCD driver for
860, the framebuffer is still there...
Does it mean that anyway it is possible to use a LCD with MPC860?
Thank you for any answer!
Bye

Piero


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
