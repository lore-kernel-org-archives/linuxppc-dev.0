Return-Path: <kumar.gala@freescale.com>
Received: from TX2EHSOBE005.bigfish.com (tx2ehsobe003.messaging.microsoft.com
	[65.55.88.13]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3C57B1007D3
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Oct 2010 09:07:33 +1100 (EST)
Received: from mail187-tx2 (localhost.localdomain [127.0.0.1])	by
	mail187-tx2-R.bigfish.com (Postfix) with ESMTP id A95D99883CA	for
	<linuxppc-dev@ozlabs.org>; Wed, 13 Oct 2010 22:07:29 +0000 (UTC)
Received: from TX2EHSMHS018.bigfish.com (unknown [10.9.14.241])	by
	mail187-tx2.bigfish.com (Postfix) with ESMTP id 69F4C220053	for
	<linuxppc-dev@ozlabs.org>; Wed, 13 Oct 2010 22:07:10 +0000 (UTC)
Received: from az33smr02.freescale.net (az33smr02.freescale.net
	[10.64.34.200])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id o9DM77Pw012181	for <linuxppc-dev@ozlabs.org>;
	Wed, 13 Oct 2010 15:07:07 -0700 (MST)
Subject: Re: [PATCH 2/2] [v2] powerpc/85xx: add DIU support to the Freecale
	P1022DS reference board
MIME-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset="us-ascii"
From: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <1286480203-28227-2-git-send-email-timur@freescale.com>
Date: Wed, 13 Oct 2010 17:07:06 -0500
Message-ID: <C692EF20-D7BD-4381-93F8-D1AA58BA89C4@freescale.com>
References: <1286480203-28227-1-git-send-email-timur@freescale.com>
	<1286480203-28227-2-git-send-email-timur@freescale.com>
To: Timur Tabi <timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Oct 7, 2010, at 2:36 PM, Timur Tabi wrote:

> The Freescale P1022DS has an on-chip video controller called the DIU, =
and a
> driver for this device already exists.  Update the platform file for =
the
> P1022DS reference board to enable the driver, and update the defconfig =
for
> Freescale MPC85xx boards to add the driver.
>=20
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
> arch/powerpc/configs/mpc85xx_defconfig     |    3 +
> arch/powerpc/configs/mpc85xx_smp_defconfig |    3 +
> arch/powerpc/platforms/85xx/p1022_ds.c     |  213 =
+++++++++++++++++++++++++++-
> 3 files changed, 217 insertions(+), 2 deletions(-)

I dropped this because of chicken/egg issue with guts.h

- k=
