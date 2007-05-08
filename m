Return-Path: <jdl@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8CE7CDDE28
	for <linuxppc-dev@ozlabs.org>; Wed,  9 May 2007 00:29:26 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l48ETLmi009132
	for <linuxppc-dev@ozlabs.org>; Tue, 8 May 2007 07:29:21 -0700 (MST)
Received: from az33exm24.fsl.freescale.net (az33exm24.am.freescale.net
	[10.64.32.14])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l48ETL5N029877
	for <linuxppc-dev@ozlabs.org>; Tue, 8 May 2007 09:29:21 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 3/3] [POWERPC] dts: kill hardcoded phandles
Date: Tue, 8 May 2007 07:29:20 -0700
Message-ID: <AF0367BA48C55940A43CCF08DF35553C012AA472@az33exm24.fsl.freescale.net>
In-Reply-To: <20070508055431.GA21009@localhost.localdomain>
References: <20070508053049.18428.50622.stgit@localhost.localdomain><20070508054855.18428.29080.stgit@localhost.localdomain>
	<20070508055431.GA21009@localhost.localdomain>
From: "Loeliger Jon-LOELIGER" <jdl@freescale.com>
To: "David Gibson" <david@gibson.dropbear.id.au>,
	"Vitaly Bordug" <vitb@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, linux-pcmcia@lists.infradead.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > -       interrupt-controller@f8200000 {
> > -               linux,phandle =3D <f8200000>;
> > +		pci_pic:interrupt-controller@f8200000 {
>=20
> I'd like to establish a convention of putting a space after the : and
> using capitals for labels unless there's a strong reason not to in a
> particular case.  It makes them easier to visually distinguish next to
> the node name.

Colon-space is easy and I'll buy it.
I'm not big on uppercase shouting, though.

Perhaps something more like case or goto labels:?

    pci_pic:
        interrupt-contoller@f8200000 {

if needed?

jdl
