Return-Path: <Wei.Zhang@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CE97EDDE43
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Sep 2007 20:11:04 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l8BAAwN4017929
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Sep 2007 03:10:58 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l8BAAsTb023030
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Sep 2007 05:10:55 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH 5/5] Add DMA engine driver for Freescale MPC85xx
	processors.
Date: Tue, 11 Sep 2007 18:10:53 +0800
Message-ID: <46B96294322F7D458F9648B60E15112C85D61E@zch01exm26.fsl.freescale.net>
In-Reply-To: <BAE9DCEF64577A439B3A37F36F9B691C02FF08A1@orsmsx418.amr.corp.intel.com>
References: <11891624582950-git-send-email-wei.zhang@freescale.com>
	<BAE9DCEF64577A439B3A37F36F9B691C02FF08A1@orsmsx418.amr.corp.intel.com>
From: "Zhang Wei-r63237" <Wei.Zhang@freescale.com>
To: "Nelson, Shannon" <shannon.nelson@intel.com>, <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org, dan.j.williams@intel.com,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>=20
> If this is experimental, perhaps you should mark the depends line as
> such
> 	depends on on DMA_ENGINE && PPC && EXPERIMENTAL

I'll add EXPERIMENTAL for MPC83xx only.

>=20
> [...]
>=20
> >+
> >+	fsl_dma_memcpy_issue_pending(chan);
> >+	while (fsl_dma_is_complete(chan, cookie, NULL, NULL)
> >+			!=3D DMA_SUCCESS);
>=20
> Again, is it possible to hang your thread here?
>=20
> [...]

I'll add msleep here.

Thanks!

- zw
