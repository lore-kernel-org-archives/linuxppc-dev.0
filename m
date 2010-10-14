Return-Path: <kumar.gala@freescale.com>
Received: from DB3EHSOBE006.bigfish.com (db3ehsobe006.messaging.microsoft.com
	[213.199.154.144])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E438C1007D4
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Oct 2010 04:53:05 +1100 (EST)
Received: from mail40-db3 (localhost.localdomain [127.0.0.1])	by
	mail40-db3-R.bigfish.com (Postfix) with ESMTP id E01956D0702	for
	<linuxppc-dev@ozlabs.org>; Thu, 14 Oct 2010 17:53:00 +0000 (UTC)
Received: from DB3EHSMHS010.bigfish.com (unknown [10.3.81.240])	by
	mail40-db3.bigfish.com (Postfix) with ESMTP id DB560CC8051	for
	<linuxppc-dev@ozlabs.org>; Thu, 14 Oct 2010 17:52:32 +0000 (UTC)
Received: from az33smr02.freescale.net (az33smr02.freescale.net
	[10.64.34.200])	by de01egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id o9EHqTQf028573	for <linuxppc-dev@ozlabs.org>;
	Thu, 14 Oct 2010 10:52:29 -0700 (MST)
Subject: Re: [PATCH 2/2] [v2] powerpc/85xx: add DIU support to the Freecale
	P1022DS reference board
MIME-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset="us-ascii"
From: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <5610599F537DD74A8D1F5CC946A75073034793B7@az33exm25.fsl.freescale.net>
Date: Thu, 14 Oct 2010 12:52:27 -0500
Message-ID: <2C1DF8B2-847A-45EF-91EE-C2D418ACA88B@freescale.com>
References: <1286480203-28227-1-git-send-email-timur@freescale.com>
	<1286480203-28227-2-git-send-email-timur@freescale.com>
	<C692EF20-D7BD-4381-93F8-D1AA58BA89C4@freescale.com>
	<5610599F537DD74A8D1F5CC946A75073034793B7@az33exm25.fsl.freescale.net>
To: Tabi Timur-B04825 <B04825@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Gala Kumar-B11780 <B11780@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Oct 13, 2010, at 8:39 PM, Tabi Timur-B04825 wrote:

> Kumar Gala wrote:
>>>> arch/powerpc/configs/mpc85xx_defconfig     |    3 +
>>>> arch/powerpc/configs/mpc85xx_smp_defconfig |    3 +
>>>> arch/powerpc/platforms/85xx/p1022_ds.c     |  213 =
+++++++++++++++++++++++++++-
>>>> 3 files changed, 217 insertions(+), 2 deletions(-)
>> I dropped this because of chicken/egg issue with guts.h
>=20
> If you pull from alsa-next, it should resolve that.
>=20
> Either that, or ask the alsa guys to apply this patch instead.

Can you ask the alsa guys to pick it up.  I'm happy to ack.

- k=
