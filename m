Return-Path: <ashish.kalra@freescale.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 61BF0B7067
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 11 Sep 2009 23:24:04 +1000 (EST)
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DD8FFDDD04
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Sep 2009 23:24:03 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n8BDNxs1024359
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Sep 2009 06:23:59 -0700 (MST)
Received: from zin33exm20.fsl.freescale.net (zin33exm20.ap.freescale.net
	[10.232.192.5])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n8BDPSr0021778
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Sep 2009 08:25:29 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [RESEND][PATCH] sata_fsl: hard and soft reset split
Date: Fri, 11 Sep 2009 18:51:46 +0530
Message-ID: <16444A0F3094A24C83EAB7836A12C63B37495F@zin33exm20.fsl.freescale.net>
In-Reply-To: <4AA9F038.6030207@garzik.org>
References: <Pine.WNT.4.64.0906291854180.2640@B00888-02.fsl.freescale.net>
	<4AA9F038.6030207@garzik.org>
From: "Kalra Ashish-B00888" <ashish.kalra@freescale.com>
To: "Jeff Garzik" <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Jeff,

I will do the rediff and resubmit the patch.

Thanks,
Ashish=20

-----Original Message-----
From: Jeff Garzik [mailto:jeff@garzik.org]=20
Sent: Friday, September 11, 2009 12:08 PM
To: Kalra Ashish-B00888
Cc: linux-ide@vger.kernel.org; linuxppc-dev@ozlabs.org
Subject: Re: [RESEND][PATCH] sata_fsl: hard and soft reset split

On 06/29/2009 09:26 AM, ashish kalra wrote:
> Split sata_fsl_softreset() into hard and soft resets to make=20
> error-handling more efficient & device and PMP detection more
reliable.
>
> Also includes fix for PMP support, driver tested with Sil3726, Sil4726

> & Exar PMP controllers.
>
> Signed-off-by: Ashish Kalra <Ashish.Kalra@freescale.com>

can you rediff this and 'AN' support against latest upstream?
