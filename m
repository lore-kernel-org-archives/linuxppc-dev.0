Return-Path: <Yu.Liu@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0B12EDE0A2
	for <linuxppc-dev@ozlabs.org>; Sun,  4 Jan 2009 17:57:38 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n046vY3X006062
	for <linuxppc-dev@ozlabs.org>; Sat, 3 Jan 2009 23:57:34 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n046vWQt004285
	for <linuxppc-dev@ozlabs.org>; Sun, 4 Jan 2009 00:57:33 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH v2] powerpc/fsl-booke: declare tlbcam_index for use in c
	file
Date: Sun, 4 Jan 2009 14:57:31 +0800
Message-ID: <0A1FE637C2C7E148B9573BB60CC630E5041F58@zch01exm26.fsl.freescale.net>
In-Reply-To: <1229654093-11398-1-git-send-email-yu.liu@freescale.com>
References: <1229654093-11398-1-git-send-email-yu.liu@freescale.com>
From: "Liu Yu" <Yu.Liu@freescale.com>
To: "Liu Yu-B13201" <Yu.Liu@freescale.com>, <kvm-ppc@vger.kernel.org>,
	<linuxppc-dev@ozlabs.org>
Cc: Wood Scott-B07421 <scottwood@freescale.com>,
	Gala Kumar-B11780 <kumar.gala@freescale.com>,
	Piepho Trent-B16872 <tpiepho@freescale.com>, hollisb@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Kumar,

Can I get your ack?
So that I can submit this patch through KVM tree.


> -----Original Message-----
> From: Liu Yu-B13201=20
> Sent: Friday, December 19, 2008 10:35 AM
> To: kvm-ppc@vger.kernel.org; linuxppc-dev@ozlabs.org
> Cc: hollisb@us.ibm.com; Gala Kumar-B11780; Piepho=20
> Trent-B16872; Wood Scott-B07421; Liu Yu-B13201
> Subject: [PATCH v2] powerpc/fsl-booke: declare tlbcam_index=20
> for use in c file
>=20
> KVM on E500 platform currently utilize TLB1 entries without=20
> bothering host,
> that is using unused TLB1 entries.
>=20
> So, KVM needs to read tlbcam_index to know exactly
> which TLB1 entry is unused by host.
>=20
> Signed-off-by: Liu Yu <yu.liu@freescale.com>
> ---
> [v2]
> Remove num_tlbcam_entries declare and read from SPRN_TLB1CFG=20
> in KVM instead.
>=20
>  arch/powerpc/include/asm/mmu-fsl-booke.h |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/mmu-fsl-booke.h=20
> b/arch/powerpc/include/asm/mmu-fsl-booke.h
> index 925d93c..c86af6c 100644
> --- a/arch/powerpc/include/asm/mmu-fsl-booke.h
> +++ b/arch/powerpc/include/asm/mmu-fsl-booke.h
> @@ -73,6 +73,8 @@
> =20
>  #ifndef __ASSEMBLY__
> =20
> +extern unsigned int tlbcam_index;
> +
>  typedef struct {
>  	unsigned long id;
>  	unsigned long vdso_base;
> --=20
> 1.5.4
>=20
>=20
