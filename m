Return-Path: <Wei.Zhang@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9094ADDD04
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jan 2008 14:36:30 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	m0V3aOvt018313
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jan 2008 20:36:24 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id m0V3aKWx010484
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jan 2008 21:36:21 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 3/6] Move include/asm-ppc/rio.h to
	include/asm-powerpc/rio.h
Date: Thu, 31 Jan 2008 11:36:19 +0800
Message-ID: <ABF87B0B6A38C0458E319AC973ED68AEBD0612@zch01exm26.fsl.freescale.net>
In-Reply-To: <AF5092BE-3384-44F8-A104-560DD4331726@kernel.crashing.org>
References: <1201689053956-git-send-email-wei.zhang@freescale.com>
	<12016890621727-git-send-email-wei.zhang@freescale.com>
	<120168907160-git-send-email-wei.zhang@freescale.com>
	<AF5092BE-3384-44F8-A104-560DD4331726@kernel.crashing.org>
From: "Zhang Wei" <Wei.Zhang@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=20

> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]=20
> On Jan 30, 2008, at 4:30 AM, Zhang Wei wrote:
>=20
> > Signed-off-by: Zhang Wei <wei.zhang@freescale.com>
> > ---
> > include/asm-powerpc/rio.h |   18 ++++++++++++++++++
> > include/asm-ppc/rio.h     |   18 ------------------
> > 2 files changed, 18 insertions(+), 18 deletions(-)
> > create mode 100644 include/asm-powerpc/rio.h
> > delete mode 100644 include/asm-ppc/rio.h
>=20
> it seems with OF we can just git rid of this?
>=20

Aha, yep :), The change just make the RIO driver in arch/powerpc can be
compiled with RapidIO OF patch.

If we have OF patch, you can drop this patch.

Thanks!
Wei.
