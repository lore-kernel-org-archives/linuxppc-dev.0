Return-Path: <Wei.Zhang@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D54FBDDECD
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Aug 2007 13:31:40 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l773VYrP008156
	for <linuxppc-dev@ozlabs.org>; Mon, 6 Aug 2007 20:31:34 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l773VW1A012266
	for <linuxppc-dev@ozlabs.org>; Mon, 6 Aug 2007 22:31:33 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Subject: RE: Please pull powerpc.git merge branch
Date: Tue, 7 Aug 2007 11:31:35 +0800
Message-ID: <46B96294322F7D458F9648B60E15112C7A9A11@zch01exm26.fsl.freescale.net>
In-Reply-To: <1186456715.19257.16.camel@concordia.ozlabs.ibm.com>
References: <18099.1109.83340.915328@cargo.ozlabs.ibm.com>
	<46B96294322F7D458F9648B60E15112C7A98ED@zch01exm26.fsl.freescale.net>
	<FCAE5E05-7F25-436F-963B-B757765D343A@kernel.crashing.org>
	<1186448777.19257.0.camel@concordia.ozlabs.ibm.com>
	<1186455451.2163.3.camel@localhost.localdomain>
	<1186456715.19257.16.camel@concordia.ozlabs.ibm.com>
From: "Zhang Wei-r63237" <Wei.Zhang@freescale.com>
To: <michael@ellerman.id.au>, "Zang Roy-r61911" <tie-fei.zang@freescale.com>
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

Hi, Michael,

I get them. Thanks for your work! :)

Best Regards,
Zhang Wei

> -----Original Message-----
> From: Michael Ellerman [mailto:michael@ellerman.id.au]=20
> Sent: Tuesday, August 07, 2007 11:19 AM
> To: Zang Roy-r61911
> Cc: Kumar Gala; linuxppc-dev list; Paul Mackerras; Zhang Wei-r63237
> Subject: Re: Please pull powerpc.git merge branch
>=20
> On Tue, 2007-08-07 at 10:57 +0800, Zang Roy-r61911 wrote:
> > On Tue, 2007-08-07 at 09:06, Michael Ellerman wrote:
> > > On Mon, 2007-08-06 at 08:57 -0500, Kumar Gala wrote:
> > > > On Aug 6, 2007, at 12:57 AM, Zhang Wei-r63237 wrote:
> > > >=20
> > > > > Hi, Paul,
> > > > >
> > > > > How about following patches?
> > > > >
> > > > > [PATCH 1/2] Add sysdev/pci_quirks.c file into PowerPC
> > > architecture =20
> > > > > with
> > > > > ULI chip quirk functions.
> > > > > URL:
> > > http://ozlabs.org/pipermail/linuxppc-dev/2007-August/040363.html
> > > > > [PATCH 2/2] Remove ULI chip quirks functions from=20
> MPC8641HPCN and
> > > > > MPC8544DS boards.
> > > > > URL:
> > > http://ozlabs.org/pipermail/linuxppc-dev/2007-August/040364.html
> > > > >
> > > > > [PATCH 1/3] Add a new member name to structure irq_host
> > > > > URL:
> > > http://ozlabs.org/pipermail/linuxppc-dev/2007-July/039896.html
> > > > > [PATCH 2/3] Add irq host name for all powerpc interrupt
> > > controllors.
> > > > > URL:
> > > http://ozlabs.org/pipermail/linuxppc-dev/2007-July/039897.html
> > > > > [PATCH 3/3] Add irq debugfs and virq_mapping for=20
> getting the virq
> > > > > URL:
> > > http://ozlabs.org/pipermail/linuxppc-dev/2007-July/039895.html
> > > >=20
> > > > These patches aren't fixing any bugs and would be for 2.6.24 at
> > > this =20
> > > > point.
> > >=20
> > > And I reworked them and posted new versions.
> > Where are the new versions?
> > I missed them?
>=20
> On the list, I though I cc'ed you but I guess I forgot :)
>=20
> http://patchwork.ozlabs.org/linuxppc/patch?q=3Dellerman&id=3D12612
> http://patchwork.ozlabs.org/linuxppc/patch?q=3Dellerman&id=3D12613
> http://patchwork.ozlabs.org/linuxppc/patch?q=3Dellerman&id=3D12614
> http://patchwork.ozlabs.org/linuxppc/patch?q=3Dellerman&id=3D12615
> http://patchwork.ozlabs.org/linuxppc/patch?q=3Dellerman&id=3D12616
>=20
> cheers
>=20
> --=20
> Michael Ellerman
> OzLabs, IBM Australia Development Lab
>=20
> wwweb: http://michael.ellerman.id.au
> phone: +61 2 6212 1183 (tie line 70 21183)
>=20
> We do not inherit the earth from our ancestors,
> we borrow it from our children. - S.M.A.R.T Person
>=20
