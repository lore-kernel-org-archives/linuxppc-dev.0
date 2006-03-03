Return-Path: <SStrublic@hypercom.com>
Received: from fatman.hypercom.com (cipher.hypercom.com [208.248.82.254])
	by ozlabs.org (Postfix) with ESMTP id 9ABD0679E7
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  4 Mar 2006 07:44:48 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Linux on PPC
Date: Fri, 3 Mar 2006 13:28:02 -0700
Message-ID: <482F3C06ECF00C44AEC226520C6FCB1A51ED6A@EXCHANGEVS.HYPERCOM.COM>
From: "Steve Strublic" <SStrublic@hypercom.com>
To: "David Hawkins" <dwh@ovro.caltech.edu>,
	"Rune Torgersen" <runet@innovsys.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: linuxppc-embedded-bounces+sstrublic=3Dhypercom.com@ozlabs.org
> [mailto:linuxppc-embedded-bounces+sstrublic=3Dhypercom.com@ozlabs.org]
On
> Behalf Of David Hawkins
> Sent: Friday, March 03, 2006 1:07 PM
> To: Rune Torgersen
> Cc: linuxppc-embedded@ozlabs.org
> Subject: Re: Linux on PPC
>=20
>=20
> >>Right, thats I made sure to say; Physical Memory Map.
> >>
> >>For example, on the Artesyn manual on their PrPMC they give a
> >>physical memory map, and in the Yosemite board, there is a
> >>physical memory map. I know many of the memory areas can be
> >>redefined in hardware to have a different memory location, but
> >>its still a physical address.
> >>
> >
> > Still not right. Even the physical memory is software settable. What
> > matters is what chip-select things are hooked up to, and then map
those
> > chip selects correctly (size, base address, access with and so on)
>=20
> Hi Rune,
>=20
> Thanks for responding.
>=20
> Thats what I meant with 'redefined in hardware'. But yes, redefined
> up to the limit of the wiring on the board of course (chip-selects
> and bus widths). That's where having the board schematic is
> invaluable.
>=20
> But ok, I'm pretty sure I get the point, and hopefully the
> original poster understands a bit more too.
>=20
> Given a board that you expect to run Linux on, I would imagine
> you would select hardware settings consistent with making
> Linux happy, i.e., defining 'in software' (the bootloader)
> the physical address map (eg. like the Embedded Planet reference
> manual for the 440EP Yosemite board), and then setup U-Boot and
> Linux to program the TLBs to translate to those same addresses.
>=20
> When looking at the Yosemite board, I booted U-Boot and compared
> device dcr settings to the recommended ones in the EP manual. Then
> when I booted Linux, I took a look and found that on the whole, Linux
> didn't touch too much of the things setup by U-Boot, i.e., the
> responsibility for setting up the Linux environment was mainly
> the job of the bootloader.
>=20
> So, if I had a board with a custom bootloader, I would be
> concerned that the bootloader might not know enough about
> Linux, to setup the hardware correctly.

The boot loader should, ideally, NOT know anything about Linux except
for knowing that since a Linux is being loaded, it requires some
information at boot time, and the format in which to provide said
information.

Steve

>=20
> Does that sound right?
>=20
> Dave
>=20
>=20
>=20
>=20
>=20
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
