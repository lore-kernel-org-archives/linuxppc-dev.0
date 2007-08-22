Return-Path: <Mark_Gibson@Trimble.com>
Received: from snvl-smtp1.trimble.com (snvl-smtp1.trimble.com [155.63.64.31])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "snvl-smtp1.trimble.com", Issuer "Trimble CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 3B524DDEC7
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 23 Aug 2007 08:49:18 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Getting lite5200 debian X11 up and running with CoralP 
Date: Wed, 22 Aug 2007 15:41:27 -0700
Message-ID: <37882A527B66E049AA08BCD291CEE35E0596592B@uss-am-xch-02.am.trimblecorp.net>
From: "Mark Gibson" <Mark_Gibson@Trimble.com>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,
I've been working on getting the lite5200 board running with the Denx
supplied coralP X11 drivers. I have the Fujitsu PCI card and the console
is working on it.  The denx site has tons of info and really got me up
and running in record time.  The X11 drivers and video are exactly what
I need to get going, but I have now started to drown in my lack of
experience.=20

I followed the denx app note to get debian up:
http://www.denx.de/wiki/DULG/AN2004_08_DebianOnPowerpcInstallationHowto

I used the 2.4.25 Kernel from denx (modified a bit to support USB HID
and to change the PCI address for my CoralPA card).



I have had two problems - both related to X11 / X / XF86.

1 - I have used apt to retrieve X and can run it using the generic
framebuffer. I get the cross-hatch background and the 'X' cursor only.
The only window manager APT will let me get is olvm, which I can't seem
to get to start up. I have a feeling that using debian-woody has left me
with a too-limited set of X packages (or the supporting libs/etc) to get
past this.
    =3D=3D Has anyone had debian-woody and the zvideo app running??

2 - When I use the denx drivers from the denx site I have this issue:
  (II) Module mb86290: vendor=3D"The XFree86 Project"
        compiled for 4.3.0.1, module version =3D 0.1.0
        Module class: XFree86 Video Driver
        ABI class: XFree86 Video Driver, version 0.6
  (EE) module ABI minor version (6) is newer than the server's version
(4)
  (II) UnloadModule: "mb86290"
  (II) Unloading /usr/X11R6/lib/modules/drivers/mb86290_drv.o
  (EE) Failed to load module "mb86290" (module requirement mismatch, 0)
  =20

Any insight would be appreciated.

Thanks,
Mark
