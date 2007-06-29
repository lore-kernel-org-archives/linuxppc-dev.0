Return-Path: <Wei.Zhang@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E7CEADDF0D
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Jun 2007 14:02:21 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l5T42GFj008756
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Jun 2007 21:02:16 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l5T42Er8009325
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Jun 2007 23:02:15 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH 1/5 v2] Add the explanation and a sample of RapidIO DTS
	sector to the document of booting-without-of.txt file.
Date: Fri, 29 Jun 2007 12:01:47 +0800
Message-ID: <46B96294322F7D458F9648B60E15112C6F3281@zch01exm26.fsl.freescale.net>
In-Reply-To: <5f0438212493766009684d63e41c85cc@kernel.crashing.org>
References: <11829333481420-git-send-email-wei.zhang@freescale.com>
	<11829333481977-git-send-email-wei.zhang@freescale.com>
	<5f0438212493766009684d63e41c85cc@kernel.crashing.org>
From: "Zhang Wei-r63237" <Wei.Zhang@freescale.com>
To: "Segher Boessenkool" <segher@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi, Segher,=20
=20
> > +    - #address-cells : Address representation for=20
> "rapidio" devices.
> > +      This field represents the number of cells needed to represent
> > +      the RapidIO address of the registers.  For=20
> supporting more than
> > +      32-bits RapidIO address, this field should be <2>.
> > +      See 1) above for more details on defining #address-cells.
>=20
> What does the RapidIO standard say about number of address
> bits?  You want to follow that, so all RapidIO devices can
> use the same #address-cells, not just the FSL ones.  Also,
> are there different kinds of address spaces on the bus, or
> is it just one big memory-like space?
>=20
>=20

I've checked the specification of RapidIO. The supporting of RapidIO
extended address modes are 66, 50 and 34 bit.
The Freescale's silicons is only support 34 bit address now.
Do you mean I should not use words -- 'should be <2>'?
The #address-cells should be assigned according the address mode
supported by silicon.

Thanks!
Wei.
