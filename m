Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id 1BAA3679E9
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  4 Mar 2006 06:51:32 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Linux on PPC
Date: Fri, 3 Mar 2006 13:39:25 -0600
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B8595AC@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: "David Hawkins" <dwh@ovro.caltech.edu>,
	"Wolfgang Denk" <wd@denx.de>
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

=20
> From:  David Hawkins
> Sent: Friday, March 03, 2006 10:53
> To: Wolfgang Denk
> Cc: linuxppc-embedded@ozlabs.org
> Subject: Re: Linux on PPC
>=20
> Right, thats I made sure to say; Physical Memory Map.
>=20
> For example, on the Artesyn manual on their PrPMC they give a
> physical memory map, and in the Yosemite board, there is a
> physical memory map. I know many of the memory areas can be
> redefined in hardware to have a different memory location, but
> its still a physical address.
>=20

Still not right. Even the physical memory is software settable. What
matters is what chip-select things are hooked up to, and then map those
chip selects correctly (size, base address, access with and so on)
