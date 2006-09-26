Return-Path: <LeoLi@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 34AED67B76
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Sep 2006 16:23:10 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	k8Q6N9LJ016676
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Sep 2006 23:23:09 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k8Q6N3ug011985
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Sep 2006 01:23:06 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [RFC][PATCH] QE device tree node definition
Date: Tue, 26 Sep 2006 14:23:41 +0800
Message-ID: <4879B0C6C249214CBE7AB04453F84E4D19D680@zch01exm20.fsl.freescale.net>
In-Reply-To: <995B09A8299C2C44B59866F6391D263516C375@zch01exm21.fsl.freescale.net>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: "Li Tony-r64360" <Tony.Li@freescale.com>, <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: linuxppc-dev-bounces+leoli=3Dfreescale.com@ozlabs.org
> [mailto:linuxppc-dev-bounces+leoli=3Dfreescale.com@ozlabs.org] On =
Behalf
Of Li
> Tony-r64360
> Sent: Tuesday, September 26, 2006 10:40 AM
> To: linuxppc-dev@ozlabs.org
> Subject: RE: [RFC][PATCH] QE device tree node definition
>=20
>=20
> 1) Where is the QE embedded interrupt controller ?
> I think the interrupt-parent of the QE function should point to it.

QEIC is not necessarily to be defined specifically rather than using
generic interrupt controller spec.
>=20
> 2) For the UCC, It is better to make rx-clock and tx-clock as required
> properties.
>  Almost all functions need this properties

Almost is NOT enough to make them required properties for all UCC
functions.  There are some devices uses TSA as clock source.

- Leo
