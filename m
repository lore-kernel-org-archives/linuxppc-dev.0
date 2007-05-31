Return-Path: <Wei.Zhang@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 74A3CDDFC1
	for <linuxppc-dev@ozlabs.org>; Thu, 31 May 2007 12:00:48 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l4V20gNl003878
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 19:00:43 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l4V20fhw016523
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 21:00:41 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 5/5] Set IDE in ULI1575 to not native mode.
Date: Thu, 31 May 2007 10:00:38 +0800
Message-ID: <46B96294322F7D458F9648B60E15112C30762F@zch01exm26.fsl.freescale.net>
In-Reply-To: <1180525258.19517.261.camel@localhost.localdomain>
References: <11798051102658-git-send-email-wei.zhang@freescale.com>
	<11798051101543-git-send-email-wei.zhang@freescale.com>
	<1179805110272-git-send-email-wei.zhang@freescale.com>
	<1179805110278-git-send-email-wei.zhang@freescale.com>
	<11798051102051-git-send-email-wei.zhang@freescale.com>
	<1179805110284-git-send-email-wei.zhang@freescale.com>
	<A5691757-8218-489B-B809-DE44F81EA5C8@kernel.crashing.org>
	<46B96294322F7D458F9648B60E15112C307514@zch01exm26.fsl.freescale.net>
	<1180525258.19517.261.camel@localhost.localdomain>
From: "Zhang Wei-r63237" <Wei.Zhang@freescale.com>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi, Ben,

I agree with your comments -- 'Native mode should generally work
better'.
In 100% native mode, the driver will get irq itself. So we need this
patch.

Thanks!
Wei.

>=20
> Sorry, I didn't understand... care to explain in more details ?
>=20
> Ben.
>=20
>=20
>=20
