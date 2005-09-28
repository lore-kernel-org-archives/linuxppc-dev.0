Return-Path: <stefan.nickl@kontron.com>
Received: from kom-exchfe.kontron-modular.com (mail.e2brain.de
	[62.159.155.200]) by ozlabs.org (Postfix) with ESMTP id 5F10A68403
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 28 Sep 2005 18:49:12 +1000 (EST)
From: Stefan Nickl <Stefan.Nickl@kontron.com>
To: Roberto Pavon Sierra <r.pavon-sierra@hima.com>
In-Reply-To: <000701c5c3fa$99fcd090$8700a8c0@SN7855>
References: <000701c5c3fa$99fcd090$8700a8c0@SN7855>
Content-Type: text/plain; charset=ISO-8859-1
Date: Wed, 28 Sep 2005 10:49:06 +0200
Message-Id: <1127897346.14270.65.camel@lucy.pep-kaufbeuren.de>
Mime-Version: 1.0
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: Driver radeonfb for ATI M6 video controller
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, 2005-09-28 at 09:02 +0200, Roberto Pavon Sierra wrote:
> Hi,
>=20
> i try to initialize my video card ATI M6. I installed the driver radeonfb
> (kernel linux 2.6.12) for ATI M6 in ppc, but this driver cann=B4t read th=
e
> BIOS-serial flash and takes always default values and not the initializat=
ion
> values from the BIOS.
> Can someone help me with this problem? must i install too a XF86-emulator=
 in
> my board (ppc 440GX)? Can i initialize this video card without BIOS?

We tried that too :-}  Without BIOS initialisation, the chip won't work.

The x86 emulation approach was led by a company
http://www.scitechsoft.com,
but I seems they got to know the chips well enough in the meantime to
program them directly...

The emulator was based on x86emu, and the last time I saw it was in one
of the {linux,free}bios projects. I actually ran it once with a M6 BIOS
on a PPC,
but it didn't work right away and I didn't wanted to dig in there at the
time.

While I would be interested to hear about any progess you can make with
ATI on PPC, I'll tell that we gave up on that and settled for another
chip.
You may want to have a look at Siliconmotion's SM501 or Fujitsu's
Coral-P.

Regards,

--=20
Stefan Nickl
Kontron Modular Computers
