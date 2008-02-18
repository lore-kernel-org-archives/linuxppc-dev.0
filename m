Return-Path: <Wei.Zhang@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A32A6DDECC
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Feb 2008 18:33:41 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	m1I7XZHq012011
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Feb 2008 00:33:35 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m1I7XXkm002019
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Feb 2008 01:33:34 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 4/6] Add multi mport support.
Date: Mon, 18 Feb 2008 15:33:31 +0800
Message-ID: <ABF87B0B6A38C0458E319AC973ED68AEC3DEFF@zch01exm26.fsl.freescale.net>
In-Reply-To: <20080205162942.GB20177@gate.crashing.org>
References: <1201689053956-git-send-email-wei.zhang@freescale.com>
	<12016890621727-git-send-email-wei.zhang@freescale.com>
	<120168907160-git-send-email-wei.zhang@freescale.com>
	<12016890773706-git-send-email-wei.zhang@freescale.com>
	<AF4B8466-C1CE-4FFB-8341-4BFC1CB76116@kernel.crashing.org>
	<ABF87B0B6A38C0458E319AC973ED68AEBD0677@zch01exm26.fsl.freescale.net>
	<EC566605-6890-4983-8700-3B15C9EFC1C5@kernel.crashing.org>
	<F2D2FCC7-D1ED-4DC6-BE7A-EE2755CCE125@kernel.crashing.org>
	<ABF87B0B6A38C0458E319AC973ED68AEBD0697@zch01exm26.fsl.freescale.net>
	<20080205162942.GB20177@gate.crashing.org>
From: "Zhang Wei" <Wei.Zhang@freescale.com>
To: "Matt Porter" <mporter@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi, Matt,

So glad to see you again!

> -----Original Message-----
> From: Matt Porter [mailto:mporter@kernel.crashing.org]=20
> On Thu, Jan 31, 2008 at 02:30:13PM +0800, Zhang Wei wrote:
> > > -----Original Message-----
> > > From: Kumar Gala [mailto:galak@kernel.crashing.org]=20
> > > when we have multiple ports are the device IDs on the=20
> ports intended =20
> > > to be unique only to a port or unique across all ports?
> > >=20
> > I consider each RIO controller will has its own network,=20
> the device IDs
> > should be
> > unique only in its port network.
>=20
> This is a bad assumption IMHO. It pushes policy on to the system
> designer of a RapidIO network.

I know it is a real bad assumption. However, the RIO initial ID is only
transported to
 driver by kernel parameter "riohdid", which can not distinguish the
multi
 rio controllers. It may be more better add a "rio-id" property in RIO
dts node, but
 the u-boot need some changes to support the rio-id assignment.

Cheers!
Wei.
