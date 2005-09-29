Return-Path: <mfend@harris.com>
Received: from mlbe2k2.cs.myharris.net (mlbe2k2.cs.myharris.net
	[137.237.90.89]) by ozlabs.org (Postfix) with ESMTP id 235356839F
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 29 Sep 2005 23:45:08 +1000 (EST)
Message-ID: <8D4C69676E66D511A1CB00508BBBB192052D435D@ranmx1.cs.myharris.net>
From: "Fend, Matthias" <mfend@harris.com>
To: linuxppc-embedded@ozlabs.org
Date: Thu, 29 Sep 2005 09:45:06 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: AW: mpc8xx and LCD
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

hi,=20

>>Can you send a couple of links to the modules you are considering?

there are some 320x240 from EDT (Emerging Display Technologies) with =
S1D13305
S1D13700
http://www.actron.de/graphic_displays_edt.htm

also from Powertip a 320x240 with S1D13305/ S1D13704 is available
http://www.actron.de/graphic_displays_powertip.htm

and also from ampire is one ... (available /w or w/o Epson's S1D =
controller)
http://www.ampire.com.tw/AmpireCatalogue/P082-AT320240Q3.pdf


matthias

-----Urspr=FCngliche Nachricht-----
Von: Mark Chambers [mailto:markc@mail.com]=20
Gesendet: Donnerstag, 29. September 2005 14:52
An: Fend, Matthias; linuxppc-embedded@ozlabs.org
Betreff: Re: mpc8xx and LCD

mpc8xx and LCD>hello,
>We want to use mpc860/855 with a 320x240 graphic lcd module.
>Now there are many possibilities to interface such a module, but I =
guess
this is not the first time
>someone will need a LCD display. So I'm trying to find out the most =
common
way to implement the
>desired functionality.
>At the moment I think we should use a lcd controller from Epson =
(S1D13700
or S1D13305) since they are
>working on Linux framebuffer device driver for it. But I'm not sure =
how to
design the hardware interface ... all
>the LCD modules I found provide only a reduced number of port pins so =
that
the controller only can be used
>in indirect-mode, so I'm not sure whether to connect the module =
directly to
the CPUs bus or use some
>GPIO pins for this...
>Has anybody else implemented a LCD into a mpc8xx (not 823) board
successfully ?
>Are there some good resources somewhere in the web about this topic ?
>thanks for your recommendations,
> mattthias

Can you send a couple of links to the modules you are considering?

Mark Chambers
