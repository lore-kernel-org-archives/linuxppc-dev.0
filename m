Message-ID: <2C1BAF8F8E1DD611862B0002A5D4C3FC02B6D052@renexch3.rennes.thmulti.com>
From: Fillod Stephane <stephane.fillod@thomson.net>
To: "'Sergey Urvanov'" <abs@dts.ru>,
	linuxppc-embedded@lists.linuxppc.org
Subject: RE: ioperm
Date: Tue, 27 Apr 2004 11:49:46 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>Anybody seen this error?

No :)

>I'm getting it while trying to compile  for a ppc405EP based board,
>using the ELDK 2.1 toolchain (ppc_4xx).

Don't use ioperm. There's no io bus, only memory bus.

Please have a look at Denx's FAQ for accessing memory bus:


http://www.denx.de/twiki/bin/view/PPCEmbedded/DeviceDrivers#Section_Accessin
gPeripheralsFromUserSpace

For more information, please follow this thread:
	http://lists.linuxppc.org/linuxppc-embedded/200403/msg00059.html


> #define BASEPORT 0x378

I don't know what your BASEPORT is, but it looks very wrong.


Welcome in ppc world.

Regards,
Stéphane

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
