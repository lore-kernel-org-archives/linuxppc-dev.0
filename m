Return-Path: <R61911@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E84F9B6F0C
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  5 Jul 2010 17:17:26 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o657HNxQ012538 for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 5 Jul 2010 00:17:23 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id o657HSQY018513
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 5 Jul 2010 02:17:29 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [linuxppc-release] [PATCH] rtc: add support for DS3232 RTC
Date: Mon, 5 Jul 2010 15:17:21 +0800
Message-ID: <46EA46969DA12B47932A34F1DA67A147041859@zch01exm23.fsl.freescale.net>
In-Reply-To: <1278312330-19042-1-git-send-email-tie-fei.zang@freescale.com>
References: <1278312330-19042-1-git-send-email-tie-fei.zang@freescale.com>
From: "Zang Roy-R61911" <r61911@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Cc: Hu Mingkai-B21284 <B21284@freescale.com>,
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
> From: linuxppc-release-bounces@linux.freescale.net=20
> [mailto:linuxppc-release-bounces@linux.freescale.net] On=20
> Behalf Of Zang Roy-R61911
> Sent: Monday, July 05, 2010 14:46 PM
> To: linuxppc-release@linux.freescale.net
> Cc: Hu Mingkai-B21284; linuxppc-dev@lists.ozlabs.org;=20
> Srinivasan Srikanth-R9AABP
> Subject: [linuxppc-release] [PATCH] rtc: add support for DS3232 RTC
>=20
> This patch adds the driver for RTC chip DS3232 via I2C bus
>=20
> Signed-off-by: Mingkai Hu <Mingkai.hu@freescale.com>
> Signed-off-by: Jingchang Lu <b22599@freescale.com>
> Signed-off-by: Srikanth Srinivasan <srikanth.srinivasan@freescale.com>
> Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
> ---
> Tested on MPC8536DS and P4080DS board
Sorry for the duplicated patch. It is due to a mail script bug.
Please only comment  to the patch directly send to
linux-i2c@vger.kernel.org
Thanks.
Roy
