Return-Path: <DaveLiu@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id E7E5BB6EDF
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  7 Aug 2009 18:06:18 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n7785vjf017915 for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 7 Aug 2009 01:06:08 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n7786OhJ013319
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 7 Aug 2009 03:06:25 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: MPC8313 performance evaluation
Date: Fri, 7 Aug 2009 16:05:56 +0800
Message-ID: <D7CCA83BB0796C49BC0BB53B6AB1208956D03B@zch01exm21.fsl.freescale.net>
In-Reply-To: <20090807074801.GA19763@lutz.bln.innominate.local>
References: <20090806180035.GA19088@lutz.bln.innominate.local><8731B515-14B1-4580-A196-75E57543C3F9@kernel.crashing.org>
	<20090807074801.GA19763@lutz.bln.innominate.local>
From: "Liu Dave-R63238" <DaveLiu@freescale.com>
To: "Lutz Jaenicke" <ljaenicke@innominate.com>, <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> > On Aug 6, 2009, at 1:00 PM, Lutz Jaenicke wrote:
> >> With the MPC8343@400MHz I get a throughput of approx.=20
> 24500 frames/s
> >> using the predefined firewall rules.
>=20
> >> With the MPC8313 I get a significantly lower value:
> >> MPC8313@250MHz          12500fps
> >> MPC8313@333MHz          14500fps
> >> MPC8313@416MHz          15500fps      (333MHz type, overclocked)
>=20
> > What DDR frequencies (and width) are you running the 8343=20
> vs 8313 at.  =20
> > This can have a significant impact on performance.
>=20
> The 8343 is running DDR2 32bit at 266MHz (CSB 266MHz)
> The 8313 is running DDR2 32bit at 333MHz (CSB 166MHz)
>=20
> The test were performed with 128byte frames so that the overall
> bandwidth needed is far below even 100Mbit/s.

The CSB bus freq is key for the throught.
CSB freq of 8313 is lower than 8343, it will cause the performance
degrade.
