Return-Path: <Wei.Zhang@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 192F5DDE38
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Jun 2007 18:54:25 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l578sJLP016951
	for <linuxppc-dev@ozlabs.org>; Thu, 7 Jun 2007 01:54:20 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l578sIXl022267
	for <linuxppc-dev@ozlabs.org>; Thu, 7 Jun 2007 03:54:19 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH]: Add 8548 pcie bus number workaround
Date: Thu, 7 Jun 2007 16:54:16 +0800
Message-ID: <46B96294322F7D458F9648B60E15112C307DDE@zch01exm26.fsl.freescale.net>
In-Reply-To: <D373FFB6-49B6-414B-AEEB-65AB62EB5AD5@kernel.crashing.org>
References: <1181186378.10296.41.camel@localhost.localdomain>
	<D373FFB6-49B6-414B-AEEB-65AB62EB5AD5@kernel.crashing.org>
From: "Zhang Wei-r63237" <Wei.Zhang@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>,
	"Zang Roy-r61911" <tie-fei.zang@freescale.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

MPC8641 v2.0 have fixed the errata. And v1.0 is not supported.

Wei.

> -----Original Message-----
> From: linuxppc-dev-bounces+wei.zhang=3Dfreescale.com@ozlabs.org=20
> [mailto:linuxppc-dev-bounces+wei.zhang=3Dfreescale.com@ozlabs.or
> g] On Behalf Of Kumar Gala
> Sent: Thursday, June 07, 2007 2:49 PM
> To: Zang Roy-r61911
> Cc: linuxppc-dev list; Paul Mackerras
> Subject: Re: [PATCH]: Add 8548 pcie bus number workaround
>=20
>=20
> On Jun 6, 2007, at 10:19 PM, Zang Roy-r61911 wrote:
>=20
> >
> > From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
> >
> > Remove legacy pcie support for 8641 chip.
> > General PCI code can fully support 8641 Rev2.0 chip.
> > For 8548 PEX controller, PCIE host controller configure
> > space can only be accessed as "bus->number =3D 0" in
> > the PCI architecture. So "bus->number =3D=3D hose->bus_offset"
> > judgment is added.
>=20
> Uugh, I'm completely confused.  Does 8548 rev 2.x have some errata =20
> (or 'feature') that 8641 doesn't have?
>=20
> - k
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>=20
