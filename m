Return-Path: <Wei.Zhang@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id F313FDDE3D
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 17:17:10 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l6B7H4r6011503
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 00:17:05 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l6B7H3S3003262
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 02:17:04 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH 2/4] Add dma sector to mpc8641hpcn board dts
Date: Wed, 11 Jul 2007 15:17:01 +0800
Message-ID: <46B96294322F7D458F9648B60E15112C6F3CE2@zch01exm26.fsl.freescale.net>
In-Reply-To: <263378AA-3951-47E3-BA81-CB655E4019F1@kernel.crashing.org>
References: <1184060662530-git-send-email-wei.zhang@freescale.com>
	<11840606624025-git-send-email-wei.zhang@freescale.com>
	<11840606621515-git-send-email-wei.zhang@freescale.com>
	<263378AA-3951-47E3-BA81-CB655E4019F1@kernel.crashing.org>
From: "Zhang Wei-r63237" <Wei.Zhang@freescale.com>
To: "Segher Boessenkool" <segher@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> > +		dma@21000{
>=20
> "dma-controller" btw.  And a space before the "{" (here and
> elsewhere) :-)

All right! :-)

Wei.
