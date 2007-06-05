Return-Path: <tie-fei.zang@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 82FCBDDE4A
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Jun 2007 13:14:43 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l553EbJR007348
	for <linuxppc-dev@ozlabs.org>; Mon, 4 Jun 2007 20:14:38 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l553EaME008368
	for <linuxppc-dev@ozlabs.org>; Mon, 4 Jun 2007 22:14:37 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH v2 5/9] Set IDE in ULI1575 to not native mode.
Date: Tue, 5 Jun 2007 11:14:35 +0800
Message-ID: <7EA18FDD2DC2154AA3BD6D2F22A62A0E82CBCA@zch01exm23.fsl.freescale.net>
In-Reply-To: <1180996210.9632.73.camel@ld0161-tx32>
References: <1180996210.9632.73.camel@ld0161-tx32>
From: "Zang Roy-r61911" <tie-fei.zang@freescale.com>
To: "Loeliger Jon-LOELIGER" <jdl@freescale.com>, <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> From: Zhang Wei <wei.zhang@freescale.com>
>=20
> Set IDE in ULI1575 to not 100% native mode, which forces
> the IDE driver to probe the irq itself.
>=20
> Signed-off-by: Zhang Wei <wei.zhang@freescale.com>
> Signed-off-by: Jon Loeliger <jdl@freescale.com>

Acked-by: Roy Zang <tie-fei.zang@freescale.com>
