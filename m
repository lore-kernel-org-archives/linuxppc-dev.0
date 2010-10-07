Return-Path: <kumar.gala@freescale.com>
Received: from AM1EHSOBE006.bigfish.com (am1ehsobe006.messaging.microsoft.com
	[213.199.154.209])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 065BCB70AB
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Oct 2010 17:32:10 +1100 (EST)
Received: from mail68-am1 (localhost.localdomain [127.0.0.1])	by
	mail68-am1-R.bigfish.com (Postfix) with ESMTP id 33F991578342	for
	<linuxppc-dev@ozlabs.org>; Thu,  7 Oct 2010 06:32:07 +0000 (UTC)
Received: from am1ehsmhs010.bigfish.com (unknown [10.3.201.243])	by
	mail68-am1.bigfish.com (Postfix) with ESMTP id 563B29B0054	for
	<linuxppc-dev@ozlabs.org>; Thu,  7 Oct 2010 06:31:31 +0000 (UTC)
Received: from az33smr02.freescale.net (az33smr02.freescale.net
	[10.64.34.200])	by az33egw01.freescale.net (8.14.3/8.14.3) with ESMTP
	id o976VRVX010663	for <linuxppc-dev@ozlabs.org>;
	Wed, 6 Oct 2010 23:31:27 -0700 (MST)
Subject: Re: [PATCH] powerpc/p1022: add probing for individual DMA channels,
	not just DMA controllers
MIME-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset="us-ascii"
From: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <1282253292-19420-1-git-send-email-timur@freescale.com>
Date: Thu, 7 Oct 2010 01:27:41 -0500
Message-ID: <AFFE119F-7C3E-4FBB-BC53-74C3359154E3@freescale.com>
References: <1282253292-19420-1-git-send-email-timur@freescale.com>
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


On Aug 19, 2010, at 4:28 PM, Timur Tabi wrote:

> Like the MPC8610 HPCD, the P1022DS ASoC DMA driver probes on =
individual DMA
> channel nodes, so the DMA controller nodes' compatible string must be =
listed in
> p1022_ds_ids[] to work.
>=20
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
>=20
> This is for -next.
>=20
> I don't know why I forgot to include this change in the original =
P1022DS patch.
>=20
> arch/powerpc/platforms/85xx/p1022_ds.c |    2 ++
> 1 files changed, 2 insertions(+), 0 deletions(-)

applied to next

- k=
