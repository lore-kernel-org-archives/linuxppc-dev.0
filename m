Return-Path: <carcadiz@hotmail.com>
Received: from blu139-omc3-s19.blu139.hotmail.com
	(blu139-omc3-s19.blu139.hotmail.com [65.55.175.219])
	by ozlabs.org (Postfix) with ESMTP id E8877DDE0A
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Feb 2008 22:34:55 +1100 (EST)
Message-ID: <BLU106-W20B00A907B0D9DAD5014E2CA1D0@phx.gbl>
From: "Pedro Luis D. L." <carcadiz@hotmail.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: TQM5200 2.6-denx SM501 voyager enabling problem.
Date: Fri, 22 Feb 2008 12:29:45 +0100
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hello,
I'm working right now with a TQM5200 microcontroller on a STX5200 board.
I'm having problems to enable SM501 video output using 2.6-denx kernel. The=
 system is working properly using 2.4 kernel and I can have graphical outpu=
t, so I can be sure that there's no hardware problem.
With 2.6 I have used the tqm5200_defconfig configuration file and then I ha=
ve enabled the following features in the kernel:
 - Device Drivers -> Multifunction Device Drivers -> Support forSilicon Mot=
ion SM501.
 - Device Drivers -> Graphic Support ->  Support for frame buffer devices.
 - Device Drivers -> Graphic Support ->  Support for frame buffer devices -=
> Silicon Motion SM501 framebuffer support.
 - Device Drivers -> Character devices -> Virtual Terminal.
 - Device Drivers -> Character devices -> Support for console on virtual te=
rminal.
But I still can't make the SM501 driver initialized at booting time and the=
re's no framebuffer video device available. /dev/fb and /dev/fb0 nodes are =
already created.
I'm using 1.3.1 u-boot from denx repository compiled with  CONFIG_STK52XX=
=3Dy and CONFIG_MINIFAP=3Dy options, and video=3Dvoyager:fp options is pass=
ed to the kernel at booting.

I'm sure there's something I'm missing to enable in the kernel. Maybe someo=
ne can sent me a hint. I would appreciate any!

Pedro L.



_________________________________________________________________
MSN Noticias
http://noticias.msn.es/comunidad.aspx=
