Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id D59D6B70F3
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Sep 2010 15:09:43 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: MPC8641D PEX: programming OWBAR in Endpoint mode?
Date: Fri, 24 Sep 2010 07:09:34 +0200
Message-ID: <52CF90264091A14888078A031D780F4306C8C176@ism-mail03.corp.ad.wrs.com>
In-Reply-To: <409c3f6d508ece73c18f6ce750513b22.squirrel@localhost>
References: <08f8439b89ad5771221aaba1cee86fc4.squirrel@localhost>
	<52CF90264091A14888078A031D780F4306C8C0FF@ism-mail03.corp.ad.wrs.com>
	<1285240268.2454.8.camel@chumley>
	<52CF90264091A14888078A031D780F4306C8C14B@ism-mail03.corp.ad.wrs.com>
	<409c3f6d508ece73c18f6ce750513b22.squirrel@localhost>
From: "Chen, Tiejun" <Tiejun.Chen@windriver.com>
To: <david.hagood@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: david.hagood@gmail.com [mailto:david.hagood@gmail.com]=20
> Sent: Thursday, September 23, 2010 10:44 PM
> To: Chen, Tiejun
> Cc: David Hagood; linuxppc-dev@ozlabs.org
> Subject: RE: MPC8641D PEX: programming OWBAR in Endpoint mode?
>=20
> >> -----Original Message-----
>  via the BARs.
> >
> > I read your email again and something hint me. I notice you clarify=20
> > you already condigure InBound successfully.
>=20
> I am programming BOTH the inbound ATMUs to make PPC memory=20
> available to the root complex, AND programming outbound ATMUs=20
> to enable the PPC to bus master to the root complex's memory=20
> space on PCIe.
>=20

Right but this should be done for RC mode, not for EP mode we're
discussing.

Tiejun

> I am NOT attempting to program the IWBARs - as you noted,=20
> they get programmed by the root complex via PCI config operations.
>=20
> >
> >  And as my above comment I'm afraid you mix up InBound and=20
> OutBound on=20
> > EP mode?
>=20
> No, I am NOT confusing the two - that is why I am being VERY=20
> EXPLICIT about accessing the OUTBOUND ATMUs.
>=20
> The only reason I mention the inbound ATMUs is to demonstrate=20
> that the physical layer is working.
>=20
>=20
>=20
