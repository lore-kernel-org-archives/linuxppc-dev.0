Return-Path: <Alexandre.Bounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 370B5B72B6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2011 00:41:23 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: [PATCH 3/5,v3] powerpc/85xx: Update SRIO device tree nodes
Date: Wed, 16 Nov 2011 05:40:15 -0800
Message-ID: <0CE8B6BE3C4AD74AB97D9D29BD24E552024917CD@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <1321099352-21462-3-git-send-email-Gang.Liu@freescale.com>
References: <1321099352-21462-1-git-send-email-Gang.Liu@freescale.com>
 <1321099352-21462-3-git-send-email-Gang.Liu@freescale.com>
From: "Bounine, Alexandre" <Alexandre.Bounine@idt.com>
To: Liu Gang <Gang.Liu@freescale.com>, <linuxppc-dev@lists.ozlabs.org>
Cc: r58472@freescale.com, r61911@freescale.com, linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org, B11780@freescale.com
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
> r58472@freescale.com; B11780@freescale.com; r61911@freescale.com;
Kumar
> Gala
> Subject: [PATCH 3/5,v3] powerpc/85xx: Update SRIO device tree nodes
>=20
> From: Kumar Gala <galak@kernel.crashing.org>
>=20
> Update all dts files that support SRIO controllers to match the new
> fsl,srio device tree binding.
>=20
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
>  arch/powerpc/boot/dts/mpc8568mds.dts   |   66
++++++++++++++++++++++--
> -----
>  arch/powerpc/boot/dts/mpc8569mds.dts   |   72
> +++++++++++++++++++++++++------
>  arch/powerpc/boot/dts/mpc8641_hpcn.dts |   69
> ++++++++++++++++++++++++-------
>  arch/powerpc/boot/dts/p2041rdb.dts     |   11 +++++
>  arch/powerpc/boot/dts/p2041si.dtsi     |   20 +++++++++
>  arch/powerpc/boot/dts/p3041ds.dts      |   11 +++++
>  arch/powerpc/boot/dts/p3041si.dtsi     |   26 ++++++++---
>  arch/powerpc/boot/dts/p4080ds.dts      |   12 ++++-
>  arch/powerpc/boot/dts/p4080si.dtsi     |   64
+++++++++++++++++++++++-
> ----
>  arch/powerpc/boot/dts/p5020ds.dts      |   11 +++++
>  arch/powerpc/boot/dts/p5020si.dtsi     |   26 ++++++++---
>  11 files changed, 314 insertions(+), 74 deletions(-)
>=20

Acked-by: Alexandre Bounine <alexandre.bounine@idt.com>
