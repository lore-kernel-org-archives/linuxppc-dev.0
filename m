Return-Path: <LeoLi@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 39A72DE16F
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Apr 2008 13:38:38 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	m3H3cVCH027308
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 20:38:32 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id m3H3cTtx027938
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 22:38:30 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1251"
Subject: RE: [PATCH v2][POWERPC] qe_lib and ucc_geth: switch to the cpm_muram
	implementation
Date: Thu, 17 Apr 2008 11:38:19 +0800
Message-ID: <989B956029373F45A0B8AF02970818900200750D@zch01exm26.fsl.freescale.net>
In-Reply-To: <20080416182214.GA20056@polina.dev.rtsoft.ru>
References: <20080320173945.GA8446@localhost.localdomain><20080414181810.GA1038@polina.dev.rtsoft.ru>
	<20080416182214.GA20056@polina.dev.rtsoft.ru>
From: "Li Yang" <LeoLi@freescale.com>
To: <avorontsov@ru.mvista.com>, "Kumar Gala" <galak@kernel.crashing.org>
Cc: Wood Scott <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Jeff Garzik <jgarzik@pobox.com>,
	Tabi Timur <timur@freescale.com>, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: linuxppc-dev-bounces+leoli=3Dfreescale.com@ozlabs.org=20
> [mailto:linuxppc-dev-bounces+leoli=3Dfreescale.com@ozlabs.org]=20
> On Behalf Of Anton Vorontsov
> Sent: Thursday, April 17, 2008 2:22 AM
> To: Kumar Gala
> Cc: Wood Scott; linuxppc-dev@ozlabs.org; Jeff Garzik; Tabi=20
> Timur; netdev@vger.kernel.org
> Subject: [PATCH v2][POWERPC] qe_lib and ucc_geth: switch to=20
> the cpm_muramimplementation
>=20
> This is very trivial patch. We're transitioning to the=20
> cpm_muram_* calls. That's it.

Hi Anoton,

It is a good thing to unify the CPM dpram operation and QE muram =
operation.  But I'm having concerns about the naming as CPM is an =
obsolete block.  Can we change to use the new name QE instead?

- Leo
