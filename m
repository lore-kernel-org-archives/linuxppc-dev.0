Return-Path: <DaveLiu@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 55682DDF7E
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jan 2009 10:37:20 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n0ENb3No002764
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jan 2009 16:37:15 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n0ENb26H013626
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jan 2009 17:37:03 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH] mmc: Add driver for Freescale eSDHC controllers
Date: Thu, 15 Jan 2009 07:37:00 +0800
Message-ID: <D7CCA83BB0796C49BC0BB53B6AB1208907ABDB@zch01exm21.fsl.freescale.net>
In-Reply-To: <20090114194631.GA25978@oksana.dev.rtsoft.ru>
References: <20090114194631.GA25978@oksana.dev.rtsoft.ru>
From: "Liu Dave" <DaveLiu@freescale.com>
To: "Anton Vorontsov" <avorontsov@ru.mvista.com>,
	"Pierre Ossman" <drzeus-mmc@drzeus.cx>
Cc: linuxppc-dev@ozlabs.org,
	D'Abbraccio Joe-LJD015 <Joe.D'abbraccio@freescale.com>,
	linux-kernel@vger.kernel.org, Lai Kon-LKL001 <Konjin.Lai@freescale.com>,
	Xie Xiaobo-R63061 <X.Xie@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> This patch adds support for the Freescale Enhanced Secure Digital
> Host Controller Interface as found in some Freescale PowerPC
> microprocessors (e.g. MPC837x SOCs).

The Freescale ESDHC controller is basically compatible with the
standard SDHC controller. but the eshdc expand some bits.

The esdhc.c is much like the orignal sdhci.c.
it is possible to merge them.

Thanks, Dave
