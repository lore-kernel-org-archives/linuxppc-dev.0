Return-Path: <Alexandre.Bounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E5C20B6FA1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2011 00:41:20 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: [PATCH 2/5,
 v3] fsl-rio: Add two ports and rapidio message units support
Date: Wed, 16 Nov 2011 05:39:11 -0800
Message-ID: <0CE8B6BE3C4AD74AB97D9D29BD24E552024917CC@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <1321099352-21462-2-git-send-email-Gang.Liu@freescale.com>
References: <1321099352-21462-1-git-send-email-Gang.Liu@freescale.com>
 <1321099352-21462-2-git-send-email-Gang.Liu@freescale.com>
From: "Bounine, Alexandre" <Alexandre.Bounine@idt.com>
To: Liu Gang <Gang.Liu@freescale.com>, <linuxppc-dev@lists.ozlabs.org>
Cc: Jin Qing <b24347@freescale.com>, r58472@freescale.com,
 linux-kernel@vger.kernel.org, r61911@freescale.com, akpm@linux-foundation.org,
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
> From: =
linuxppc-dev-bounces+alexandre.bounine=3Didt.com@lists.ozlabs.org
> [mailto:linuxppc-dev-
> bounces+alexandre.bounine=3Didt.com@lists.ozlabs.org] On Behalf Of Liu
> Gang
> Sent: Saturday, November 12, 2011 7:02 AM
> To: linuxppc-dev@lists.ozlabs.org; Bounine, Alexandre
> Cc: Jin Qing; r58472@freescale.com; r61911@freescale.com; linux-
> kernel@vger.kernel.org; Liu Gang; akpm@linux-foundation.org;
> B11780@freescale.com
> Subject: [PATCH 2/5, v3] fsl-rio: Add two ports and rapidio message
> units support
>=20
> Usually, freescale rapidio endpoint can support one or two 1x or 4X
> LP-Serial link interfaces, and rapidio message transactions can be
> implemented by two message units. This adds the support of two
> rapidio ports and initializes message unit 0 and message unit 1. And
> these ports and message units can work simultaneously.
>=20
> Signed-off-by: Li Yang <leoli@freescale.com>
> Signed-off-by: Jin Qing <b24347@freescale.com>
> Signed-off-by: Liu Gang <Gang.Liu@freescale.com>
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
>  arch/powerpc/sysdev/fsl_rio.c |  391 +++++++++++++++++++++-----------
>  arch/powerpc/sysdev/fsl_rio.h |   75 ++++++-
>  arch/powerpc/sysdev/fsl_rmu.c |  502
++++++++++++++++++---------------
> --------
>  3 files changed, 545 insertions(+), 423 deletions(-)
>=20

Acked-by: Alexandre Bounine <alexandre.bounine@idt.com>
