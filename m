Return-Path: <LeoLi@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 69F40DDF6A
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Nov 2007 22:09:04 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	lAKB8tbD019701
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Nov 2007 04:08:55 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id lAKB8rWi018862
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Nov 2007 05:08:54 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 0/5] fixups for mpc8360 rev. 2.1 erratum #2 (RGMII Timing)
Date: Tue, 20 Nov 2007 19:08:51 +0800
Message-ID: <989B956029373F45A0B8AF029708189001A1C75B@zch01exm26.fsl.freescale.net>
In-Reply-To: <20071105121530.5c38fbb7.kim.phillips@freescale.com>
References: <20071105121530.5c38fbb7.kim.phillips@freescale.com>
From: "Li Yang" <LeoLi@freescale.com>
To: <jgarzik@pobox.com>, "Phillips Kim" <Kim.Phillips@freescale.com>,
	"Kumar Gala" <galak@kernel.crashing.org>, <netdev@vger.kernel.org>,
	<linuxppc-dev@ozlabs.org>
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Phillips Kim=20
> Sent: Tuesday, November 06, 2007 2:16 AM
> To: Li Yang-r58472; Kumar Gala; netdev@vger.kernel.org;=20
> linuxppc-dev@ozlabs.org
> Cc: jgarzik@pobox.com; paulus@samba.org
> Subject: [PATCH 0/5] fixups for mpc8360 rev. 2.1 erratum #2=20
> (RGMII Timing)
>=20
> Hello all,
>=20
> the following patches fix RGMII timing for rev. 2.1 of the=20
> mpc8360, according to erratum #2 (erratum text included=20
> below).  Basically the most intrusive part is the addition of=20
> two new RGMII Internal Delay modes; one for TX delay only,=20
> and the other for RX delay only (i.e, not both at the same time).
>=20
> Please review, and since this affects both netdev and powerpc=20
> trees, one maintainer should ack them for the other to push=20
> upstream (i.e, Kumar acks them, and Leo picks them up to go=20
> through netdev or the other way around; either way is fine=20
> with me).  I'm hoping they're trivial enough to go in 2.6.24.
>=20
> Depending on how the review goes, a follow-on patch to u-boot=20
> will be sent out that fixes up the phy-connection-type in the=20
> device tree (from "rgmii-id" to "rgmii-rxid" iff on mpc8360rev2.1).
>=20

2-4
Acked-by: Li Yang <leoli@freescale.com>
