Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: "Stefan Roese" <stefan.roese@esd-electronics.com>
To: "Linuxppc-Embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: AW: bootloader for deeply embedded 405CR 
Date: Mon, 9 Apr 2001 09:08:27 +0200
Message-ID: <EFEAIMDCOOOHIEPHDNFJCEALCMAA.stefan.roese@esd-electronics.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <20010407205019.369DC28418@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> > Does anyone have a minimal 405GP/CR bootloader that I
> > could use as an example? Or perhaps a FAQ on how to bring
> > up a deeply embedded 405 using the Abatron box?
>
> Did you try to run our Open Source Firmware "PPCBoot" on your  board?
> The Walnut is one of the many supported configurations.

Yes, you should give PPCBoot a try. There is also a PPC405CR implementation
available - "canbt". This board is running PPCBoot as a boot loader firmware
and Linux as OS.

Stefan Roese

*******************************************
esd gmbh
Vahrenwalder Str. 205
D-30165 Hannover
Phone: +49-511-37298-0
Fax:   +49-511-37298-198
email: stefan.roese@esd-electronics.com
www:   http://www.esd-electronics.de
*******************************************


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
