Return-Path: <B11780@freescale.com>
Received: from VA3EHSOBE005.bigfish.com (va3ehsobe005.messaging.microsoft.com
 [216.32.180.31]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id BF722B6F85
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Nov 2011 02:50:01 +1100 (EST)
Received: from mail122-va3 (localhost [127.0.0.1])	by
 mail122-va3-R.bigfish.com (Postfix) with ESMTP id 7D63A3C03C5	for
 <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Nov 2011 15:50:21 +0000 (UTC)
Received: from VA3EHSMHS033.bigfish.com (unknown [10.7.14.252])	by
 mail122-va3.bigfish.com (Postfix) with ESMTP id 45BCB4004A	for
 <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Nov 2011 15:50:21 +0000 (UTC)
Subject: Re: [PATCH] powerpc/p1023: set IRQ[4:6,
 11] to high level sensitive for PCIe
MIME-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset="us-ascii"
From: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <1320654778-3294-1-git-send-email-tie-fei.zang@freescale.com>
Date: Wed, 9 Nov 2011 09:49:53 -0600
Message-ID: <87660ED6-04F8-446E-A3A8-A62414CE2476@freescale.com>
References: <1320654778-3294-1-git-send-email-tie-fei.zang@freescale.com>
To: Roy Zang <tie-fei.zang@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

How did you come by this information?

- k

On Nov 7, 2011, at 2:32 AM, Roy Zang wrote:

> P1023 external IRQ[4:6, 11] do not pin out, but the interrupts are
> shared with PCIe controller.
> The silicon internally ties the interrupts to L, so change the
> IRQ[4:6,11] to high level sensitive for PCIe.
>=20
> Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
> ---
> arch/powerpc/boot/dts/p1023rds.dts |    8 ++++----
> 1 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/powerpc/boot/dts/p1023rds.dts =
b/arch/powerpc/boot/dts/p1023rds.dts
> index d9b7767..66bf804 100644
> --- a/arch/powerpc/boot/dts/p1023rds.dts
> +++ b/arch/powerpc/boot/dts/p1023rds.dts
> @@ -490,9 +490,9 @@
> 			interrupt-map-mask =3D <0xf800 0 0 7>;
> 			interrupt-map =3D <
> 				/* IDSEL 0x0 */
> -				0000 0 0 1 &mpic 4 1
> -				0000 0 0 2 &mpic 5 1
> -				0000 0 0 3 &mpic 6 1
> +				0000 0 0 1 &mpic 4 2
> +				0000 0 0 2 &mpic 5 2
> +				0000 0 0 3 &mpic 6 2
> 				0000 0 0 4 &mpic 7 1
> 				>;
> 			ranges =3D <0x2000000 0x0 0xa0000000
> @@ -532,7 +532,7 @@
> 				0000 0 0 1 &mpic 8 1
> 				0000 0 0 2 &mpic 9 1
> 				0000 0 0 3 &mpic 10 1
> -				0000 0 0 4 &mpic 11 1
> +				0000 0 0 4 &mpic 11 2
> 				>;
> 			ranges =3D <0x2000000 0x0 0x80000000
> 				  0x2000000 0x0 0x80000000
> --=20
> 1.6.0.6
>=20
