Return-Path: <Yu.Liu@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BB7F7DDFAF
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Mar 2008 19:58:06 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	m258vDru020109
	for <linuxppc-dev@ozlabs.org>; Wed, 5 Mar 2008 01:57:13 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id m258vBvT012647
	for <linuxppc-dev@ozlabs.org>; Wed, 5 Mar 2008 02:57:12 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] math-emu: delete PowerPC old math-emu headers
Date: Wed, 5 Mar 2008 16:57:10 +0800
Message-ID: <6EBEC19BF4A8F843BCD6B9155BBE2515E227C3@zch01exm26.fsl.freescale.net>
In-Reply-To: <12047077481825-git-send-email-Yu.Liu@freescale.com>
References: <12047077481825-git-send-email-Yu.Liu@freescale.com>
From: "Liu Yu" <Yu.Liu@freescale.com>
To: "Liu Yu" <Yu.Liu@freescale.com>, <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Sorry. I forgot to add the serial number.
The three math-emu patches are in the same serial.


> -----Original Message-----
> From: Liu Yu=20
> Sent: Wednesday, March 05, 2008 5:02 PM
> To: linuxppc-dev@ozlabs.org
> Cc: Liu Yu
> Subject: [PATCH] math-emu: delete PowerPC old math-emu headers
>=20
> Use common headers as a replacement.
> The Common headers are located in "include/math-emu/",
> they are used by multiple platforms such as s390, sparc, alpha.
>=20
> As the common headers have more developers,
> they are more popular and more stable.
>=20
> In fact, PowerPC old math-emu headers cannot handle float point
> exceptions exactly while the common headers can.
>=20
