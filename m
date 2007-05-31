Return-Path: <tie-fei.zang@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0A02CDDFCB
	for <linuxppc-dev@ozlabs.org>; Thu, 31 May 2007 16:48:41 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l4V6mY0Z026081
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 23:48:35 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l4V6mVV1017470
	for <linuxppc-dev@ozlabs.org>; Thu, 31 May 2007 01:48:32 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 3/3] Modified quirk_mpc8641_transparent() to
	initializebridge resources.
Date: Thu, 31 May 2007 14:48:29 +0800
Message-ID: <7EA18FDD2DC2154AA3BD6D2F22A62A0E7EDA24@zch01exm23.fsl.freescale.net>
In-Reply-To: <F962B8B4-32C0-46A6-B808-C18211353FCC@kernel.crashing.org>
References: <1180463004.13106.65.camel@ld0161-tx32>
	<F962B8B4-32C0-46A6-B808-C18211353FCC@kernel.crashing.org>
From: "Zang Roy-r61911" <tie-fei.zang@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>,
	"Loeliger Jon-LOELIGER" <jdl@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>=20
> On May 29, 2007, at 1:23 PM, Jon Loeliger wrote:
>=20
> > From: Jon Loeliger <jdl@freescale.com>
> >
> > The 8641 RC poses as a transparent bridge, but does not=20
> implement the
> > IO_BASE or IO_LIMIT registers in the config space.  This means that
> > the code which initializes the bridge resources ends up setting the
> > IO resources erroneously.
> >
> > This change initializes the RC bridge resources from the=20
> device tree.
> >
> > Signed-off-by: Andy Fleming <afleming@freescale.com>
> > Signed-off-by: Jon Loeliger <jdl@freescale.com>
>=20
> Can this be merged with Zhang's "Set RC of mpc8641 to transparent =20
> bridge for transfer legacy I/O access." patch since it pretty much =20
> supersedes it.

I should be!=20
But why apply them sperately?=20
They refect differnet content and stage. For end user, they will only
see the unified code :-).
Roy
