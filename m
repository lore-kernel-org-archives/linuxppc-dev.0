Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id AA7C5B7D78
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 11 May 2010 22:38:31 +1000 (EST)
Subject: Re: [PATCH] 85xx: Fix PCI-E interrupt mapping for slot 0 of P2020DS
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1273518917-10229-1-git-send-email-felix@embedded-sol.com>
Date: Tue, 11 May 2010 07:36:29 -0500
Message-Id: <1CA6B1BA-FBD1-4ECF-87DC-D3E50835E781@kernel.crashing.org>
References: <> <1273518917-10229-1-git-send-email-felix@embedded-sol.com>
To: Felix Radensky <felix@embedded-sol.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On May 10, 2010, at 2:15 PM, Felix Radensky wrote:

> Fix legacy PCI-E interrupt mapping for PCI-E slot 0 of
> P2020DS evaluation board. The patch is based on P2020DS
> device tree from Freescale BSP for this board.
>=20
> Signed-off-by: Felix Radensky <felix@embedded-sol.com>
> ---
> arch/powerpc/boot/dts/p2020ds.dts |    8 ++++----
> 1 files changed, 4 insertions(+), 4 deletions(-)

I don't understand why this is needed?

-k

>=20
> diff --git a/arch/powerpc/boot/dts/p2020ds.dts =
b/arch/powerpc/boot/dts/p2020ds.dts
> index 1101914..7c5fc07 100644
> --- a/arch/powerpc/boot/dts/p2020ds.dts
> +++ b/arch/powerpc/boot/dts/p2020ds.dts
> @@ -507,10 +507,10 @@
> 		interrupt-map-mask =3D <0xf800 0x0 0x0 0x7>;
> 		interrupt-map =3D <
> 			/* IDSEL 0x0 */
> -			0000 0x0 0x0 0x1 &mpic 0x8 0x1
> -			0000 0x0 0x0 0x2 &mpic 0x9 0x1
> -			0000 0x0 0x0 0x3 &mpic 0xa 0x1
> -			0000 0x0 0x0 0x4 &mpic 0xb 0x1
> +			0000 0x0 0x0 0x1 &mpic 0x8 0x2
> +			0000 0x0 0x0 0x2 &mpic 0x9 0x2
> +			0000 0x0 0x0 0x3 &mpic 0xa 0x2
> +			0000 0x0 0x0 0x4 &mpic 0xb 0x2
> 			>;
> 		pcie@0 {
> 			reg =3D <0x0 0x0 0x0 0x0 0x0>;
> --=20
> 1.5.4.3
