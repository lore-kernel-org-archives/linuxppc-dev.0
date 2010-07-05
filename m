Return-Path: <R61911@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D4137B6EDF
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  5 Jul 2010 17:51:01 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o657owqx026810 for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 5 Jul 2010 00:50:58 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id o6582hWR023109
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 5 Jul 2010 03:02:43 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] rtc: add support for DS3232 RTC
Date: Mon, 5 Jul 2010 15:50:55 +0800
Message-ID: <46EA46969DA12B47932A34F1DA67A147041870@zch01exm23.fsl.freescale.net>
In-Reply-To: <20100705092231.2780a1b8@hyperion.delvare>
References: <1278312326-19022-1-git-send-email-tie-fei.zang@freescale.com>
	<20100705092231.2780a1b8@hyperion.delvare>
From: "Zang Roy-R61911" <r61911@freescale.com>
To: "Jean Delvare" <khali@linux-fr.org>
Cc: Hu Mingkai-B21284 <B21284@freescale.com>, linuxppc-dev@lists.ozlabs.org,
	linux-i2c@vger.kernel.org,
	Srinivasan Srikanth-R9AABP <R9AABP@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=20

> -----Original Message-----
> From: Jean Delvare [mailto:khali@linux-fr.org]=20
> Sent: Monday, July 05, 2010 15:23 PM
> To: Zang Roy-R61911
> Cc: linux-i2c@vger.kernel.org; linuxppc-dev@lists.ozlabs.org;=20
> Hu Mingkai-B21284; Srinivasan Srikanth-R9AABP
> Subject: Re: [PATCH] rtc: add support for DS3232 RTC
>=20
> Hi Roy,
>=20
> On Mon,  5 Jul 2010 14:45:26 +0800, Roy Zang wrote:
> > This patch adds the driver for RTC chip DS3232 via I2C bus
> >=20
> > Signed-off-by: Mingkai Hu <Mingkai.hu@freescale.com>
> > Signed-off-by: Jingchang Lu <b22599@freescale.com>
> > Signed-off-by: Srikanth Srinivasan=20
> <srikanth.srinivasan@freescale.com>
> > Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
> > ---
> > Tested on MPC8536DS and P4080DS board
> >=20
> >  drivers/rtc/Kconfig      |   11 +
> >  drivers/rtc/Makefile     |    1 +
> >  drivers/rtc/rtc-ds3232.c |  466=20
> ++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 478 insertions(+), 0 deletions(-)
> >  create mode 100644 drivers/rtc/rtc-ds3232.c
>=20
> You're sending this patch to the wrong list. Please read MAINTAINERS
> again.
Does linux-i2c@vger.kernel.org is the correct mail list?
The rtc device is on the i2c bus.
Roy
