Return-Path: <Wei.Zhang@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 91EC1DDF8F
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 12:25:36 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l4U2PUlZ007395
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 19:25:31 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l4U2PTCl016339
	for <linuxppc-dev@ozlabs.org>; Tue, 29 May 2007 21:25:30 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 5/5] Set IDE in ULI1575 to not native mode.
Date: Wed, 30 May 2007 10:25:25 +0800
Message-ID: <46B96294322F7D458F9648B60E15112C307514@zch01exm26.fsl.freescale.net>
In-Reply-To: <A5691757-8218-489B-B809-DE44F81EA5C8@kernel.crashing.org>
References: <11798051102658-git-send-email-wei.zhang@freescale.com>
	<11798051101543-git-send-email-wei.zhang@freescale.com>
	<1179805110272-git-send-email-wei.zhang@freescale.com>
	<1179805110278-git-send-email-wei.zhang@freescale.com>
	<11798051102051-git-send-email-wei.zhang@freescale.com>
	<1179805110284-git-send-email-wei.zhang@freescale.com>
	<A5691757-8218-489B-B809-DE44F81EA5C8@kernel.crashing.org>
From: "Zhang Wei-r63237" <Wei.Zhang@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

> > Set IDE in ULI1575 to not 100% native mode, which forces
> > the IDE driver to probe the irq itself.
> >
> > Signed-off-by: Zhang Wei <wei.zhang@freescale.com>
>=20
> What causes this to be needed?
>=20

If the driver does not probe the irq itself, the driver will get wrong
irq for lagecy IDE device.

Thanks!
Wei.
