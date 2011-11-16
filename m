Return-Path: <Alexandre.Bounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 79B1DB702E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2011 00:39:59 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: [PATCH 1/5, v3] fsl-rio: Split rio driver into two parts,
 RapidIO endpoint and message unit
Date: Wed, 16 Nov 2011 05:36:32 -0800
Message-ID: <0CE8B6BE3C4AD74AB97D9D29BD24E552024917C9@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <1321099352-21462-1-git-send-email-Gang.Liu@freescale.com>
References: <1321099352-21462-1-git-send-email-Gang.Liu@freescale.com>
From: "Bounine, Alexandre" <Alexandre.Bounine@idt.com>
To: Liu Gang <Gang.Liu@freescale.com>, <linuxppc-dev@lists.ozlabs.org>
Cc: r58472@freescale.com, r61911@freescale.com, linux-kernel@vger.kernel.org,
 Lian Minghuan <Minghuan.Lian@freescale.com>, akpm@linux-foundation.org,
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
> Sent: Saturday, November 12, 2011 7:02 AM
> To: linuxppc-dev@lists.ozlabs.org; Bounine, Alexandre
> Cc: akpm@linux-foundation.org; linux-kernel@vger.kernel.org;
> r58472@freescale.com; B11780@freescale.com; r61911@freescale.com; Liu
> Gang; Lian Minghuan; Kumar Gala
> Subject: [PATCH 1/5,v3] fsl-rio: Split rio driver into two parts,
> RapidIO endpoint and message unit
>=20
> The Freescale PowerPC RapidIO controller consists of a RapidIO
endpoint
> and
> a RapidIO message unit(RMU). Or use RapidIO message manager(RMan) to
> replace the RMU in DPAA architecture. Therefore, we should split the
> code
> into two function modules according to the hardware architecture. Add
> new
> struct for RMU module, and new initialization function to set up RMU
> module. This policy is very conducive to adding new module like RMan,
> or
> adding multi-ports or message units support.
>=20
> Signed-off-by: Lian Minghuan <Minghuan.Lian@freescale.com>
> Signed-off-by: Liu Gang <Gang.Liu@freescale.com>
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
>  arch/powerpc/sysdev/Makefile  |    2 +-
>  arch/powerpc/sysdev/fsl_rio.c | 1152
+--------------------------------
> -------
>  arch/powerpc/sysdev/fsl_rio.h |   78 +++
>  arch/powerpc/sysdev/fsl_rmu.c | 1163
> +++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 1267 insertions(+), 1128 deletions(-)
>  create mode 100644 arch/powerpc/sysdev/fsl_rio.h
>  create mode 100644 arch/powerpc/sysdev/fsl_rmu.c
>=20

Acked-by: Alexandre Bounine <alexandre.bounine@idt.com>
