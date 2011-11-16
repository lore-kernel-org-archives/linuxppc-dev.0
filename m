Return-Path: <Alexandre.Bounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6FA99B70C9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2011 00:48:21 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: [PATCH 4/5,
 v3] powerpc/8xxx: Update device tree bus probe for new RapidIO node
 binding
Date: Wed, 16 Nov 2011 05:48:09 -0800
Message-ID: <0CE8B6BE3C4AD74AB97D9D29BD24E552024917D5@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <1321099352-21462-4-git-send-email-Gang.Liu@freescale.com>
References: <1321099352-21462-1-git-send-email-Gang.Liu@freescale.com>
 <1321099352-21462-4-git-send-email-Gang.Liu@freescale.com>
From: "Bounine, Alexandre" <Alexandre.Bounine@idt.com>
To: Liu Gang <Gang.Liu@freescale.com>, <linuxppc-dev@lists.ozlabs.org>
Cc: r58472@freescale.com, Kai Jiang <Kai.Jiang@freescale.com>,
 r61911@freescale.com, linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 B11780@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Liu Gang [mailto:Gang.Liu@freescale.com]
> Sent: Saturday, November 12, 2011 7:03 AM
> To: linuxppc-dev@lists.ozlabs.org; Bounine, Alexandre
> Cc: akpm@linux-foundation.org; linux-kernel@vger.kernel.org;
> r58472@freescale.com; B11780@freescale.com; r61911@freescale.com; Kai
> Jiang; Kumar Gala
> Subject: [PATCH 4/5,v3] powerpc/8xxx: Update device tree bus probe for
> new RapidIO node binding
>=20
> From: Kai Jiang <Kai.Jiang@freescale.com>
>=20
> Update of_platform_bus_probe() RapidIO node to be compitable with
> new RapidIO dts compatible property.
>=20
> Signed-off-by: Kai Jiang <Kai.Jiang@freescale.com>
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
>  arch/powerpc/platforms/85xx/corenet_ds.c   |    2 +-
>  arch/powerpc/platforms/85xx/mpc85xx_mds.c  |    2 +-
>  arch/powerpc/platforms/86xx/mpc86xx_hpcn.c |    2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>=20

Acked-by: Alexandre Bounine <alexandre.bounine@idt.com>
