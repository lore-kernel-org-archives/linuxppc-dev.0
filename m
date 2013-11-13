Return-Path: <Jason.Jin@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0251.outbound.messaging.microsoft.com [213.199.154.251])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3155F2C007C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Nov 2013 17:28:22 +1100 (EST)
From: Zhengxiong Jin <Jason.Jin@freescale.com>
To: Scott Wood <scottwood@freescale.com>, "galak@kernel.crashing.org"
 <galak@kernel.crashing.org>
Subject: RE: [PATCH] Add a vga alias node for P1022
Date: Wed, 13 Nov 2013 06:28:08 +0000
Message-ID: <13F8657A829DAB49A2A937FD6FC10F790B5CF17A@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1378459957-26334-1-git-send-email-Jason.Jin@freescale.com>
In-Reply-To: <1378459957-26334-1-git-send-email-Jason.Jin@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Jin Zhengxiong-R64188
> Sent: Friday, September 06, 2013 5:33 PM
> To: Wood Scott-B07421
> Cc: linuxppc-dev@lists.ozlabs.org; galak@kernel.crashing.org; Jin
> Zhengxiong-R64188
> Subject: [PATCH] Add a vga alias node for P1022
>=20
> From: Jason Jin <Jason.jin@freescale.com>
>=20
> When the vga was set as the stdout and stderr in u-boot, the stdout fixup
> code in u-boot need to find out the vga alias node in dtb.
>=20
> Signed-off-by: Jason Jin <Jason.jin@freescale.com>
> ---
>  arch/powerpc/boot/dts/fsl/p1022si-post.dtsi | 2 +-
> arch/powerpc/boot/dts/fsl/p1022si-pre.dtsi  | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)

[Jason Jin-R64188] Any comments about this patch? Thanks.
