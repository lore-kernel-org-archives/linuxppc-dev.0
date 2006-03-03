Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id 1D9CC679FF
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  4 Mar 2006 07:31:50 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Linux on PPC
Date: Fri, 3 Mar 2006 14:31:49 -0600
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B8595AD@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: "David Hawkins" <dwh@ovro.caltech.edu>
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

> From: David Hawkins [mailto:dwh@ovro.caltech.edu]=20
> Sent: Friday, March 03, 2006 14:07
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
> >=20
> > Still not right. Even the physical memory is software settable. What
> > matters is what chip-select things are hooked up to, and=20
> then map those
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

> Does that sound right?

Yes.
