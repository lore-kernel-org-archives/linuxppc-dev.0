Return-Path: <SRS0=I4jZ=RL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63CB9C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Mar 2019 00:11:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8E122054F
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Mar 2019 00:11:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="BmlGvwto"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8E122054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44FnwW1kVQzDqJ3
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Mar 2019 11:11:23 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44FntL3XM7zDqFm
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Mar 2019 11:09:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="BmlGvwto"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 44FntL19tvz9sLt; Fri,  8 Mar 2019 11:09:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1552003770;
 bh=Z1G6wQERSi9C6DfRJOO9SLvi2pEvQsZOuhE6FVvTaEg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BmlGvwto52RxtrYBvul7xyS2k0vwTM/W7/kejrPMN3DzcYsT6oCW/czu1ZB9JtQEb
 ABDo4jGG1KnIrPcQg7fuq+HR2fweKL2aVZGwPOMTn9hPpulw53+rcdzoz6iBnrVLbK
 +M9MdiVSk827qq1mgKffbSSK5PUrYTh4dFYZhs4k=
Date: Fri, 8 Mar 2019 11:09:23 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH] powerpc/mm: move warning from resize_hpt_for_hotplug()
Message-ID: <20190308000923.GE7722@umbus.fritz.box>
References: <20190307145050.17886-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="4imyEzq1NYdDURgI"
Content-Disposition: inline
In-Reply-To: <20190307145050.17886-1-lvivier@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--4imyEzq1NYdDURgI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 07, 2019 at 03:50:50PM +0100, Laurent Vivier wrote:
> resize_hpt_for_hotplug() reports a warning when it cannot
> resize the hash page table ("Unable to resize hash page
> table to target order") but in some cases it's not a problem
> and can make user thinks something has not worked properly.
>=20
> This patch moves the warning to arch_remove_memory() to
> only report the problem when it is needed.
>=20
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>

Looks ok, but apart from the H_PTEG_FULL case this does allow for some
error paths that previously warned to pass without error, which I
don't think is wise.

Specifically that will happen the prepare hcall returns H_PARAMETER or
H_RESOURCE.  Thse will result in -EINVAL or -EPERM from
pseries_lpar_resize_hpt() which previously would have tripped the
warning in resize_hpt_for_hotplug() but now will be silently ignored.

> ---
>  arch/powerpc/include/asm/sparsemem.h  |  4 ++--
>  arch/powerpc/mm/hash_utils_64.c       | 17 ++++++-----------
>  arch/powerpc/mm/mem.c                 |  3 ++-
>  arch/powerpc/platforms/pseries/lpar.c |  1 -
>  4 files changed, 10 insertions(+), 15 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/sparsemem.h b/arch/powerpc/include/=
asm/sparsemem.h
> index 68da49320592..3192d454a733 100644
> --- a/arch/powerpc/include/asm/sparsemem.h
> +++ b/arch/powerpc/include/asm/sparsemem.h
> @@ -17,9 +17,9 @@ extern int create_section_mapping(unsigned long start, =
unsigned long end, int ni
>  extern int remove_section_mapping(unsigned long start, unsigned long end=
);
> =20
>  #ifdef CONFIG_PPC_BOOK3S_64
> -extern void resize_hpt_for_hotplug(unsigned long new_mem_size);
> +extern int resize_hpt_for_hotplug(unsigned long new_mem_size);
>  #else
> -static inline void resize_hpt_for_hotplug(unsigned long new_mem_size) { }
> +static inline int resize_hpt_for_hotplug(unsigned long new_mem_size) { r=
eturn 0; }
>  #endif
> =20
>  #ifdef CONFIG_NUMA
> diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils=
_64.c
> index 0cc7fbc3bd1c..40bb2a8326bb 100644
> --- a/arch/powerpc/mm/hash_utils_64.c
> +++ b/arch/powerpc/mm/hash_utils_64.c
> @@ -755,12 +755,12 @@ static unsigned long __init htab_get_table_size(voi=
d)
>  }
> =20
>  #ifdef CONFIG_MEMORY_HOTPLUG
> -void resize_hpt_for_hotplug(unsigned long new_mem_size)
> +int resize_hpt_for_hotplug(unsigned long new_mem_size)
>  {
>  	unsigned target_hpt_shift;
> =20
>  	if (!mmu_hash_ops.resize_hpt)
> -		return;
> +		return 0;
> =20
>  	target_hpt_shift =3D htab_shift_for_mem_size(new_mem_size);
> =20
> @@ -773,15 +773,10 @@ void resize_hpt_for_hotplug(unsigned long new_mem_s=
ize)
>  	 * current shift
>  	 */
>  	if ((target_hpt_shift > ppc64_pft_size)
> -	    || (target_hpt_shift < (ppc64_pft_size - 1))) {
> -		int rc;
> -
> -		rc =3D mmu_hash_ops.resize_hpt(target_hpt_shift);
> -		if (rc && (rc !=3D -ENODEV))
> -			printk(KERN_WARNING
> -			       "Unable to resize hash page table to target order %d: %d\n",
> -			       target_hpt_shift, rc);
> -	}
> +	    || (target_hpt_shift < (ppc64_pft_size - 1)))
> +		return mmu_hash_ops.resize_hpt(target_hpt_shift);
> +
> +	return 0;
>  }
> =20
>  int hash__create_section_mapping(unsigned long start, unsigned long end,=
 int nid)
> diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
> index 33cc6f676fa6..0d40d970cf4a 100644
> --- a/arch/powerpc/mm/mem.c
> +++ b/arch/powerpc/mm/mem.c
> @@ -169,7 +169,8 @@ int __meminit arch_remove_memory(int nid, u64 start, =
u64 size,
>  	 */
>  	vm_unmap_aliases();
> =20
> -	resize_hpt_for_hotplug(memblock_phys_mem_size());
> +	if (resize_hpt_for_hotplug(memblock_phys_mem_size()) =3D=3D -ENOSPC)
> +		pr_warn("Hash collision while resizing HPT\n");
> =20
>  	return ret;
>  }
> diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platfor=
ms/pseries/lpar.c
> index f2a9f0adc2d3..b407034a80ba 100644
> --- a/arch/powerpc/platforms/pseries/lpar.c
> +++ b/arch/powerpc/platforms/pseries/lpar.c
> @@ -918,7 +918,6 @@ static int pseries_lpar_resize_hpt(unsigned long shif=
t)
>  	if (rc !=3D 0) {
>  		switch (state.commit_rc) {
>  		case H_PTEG_FULL:
> -			pr_warn("Hash collision while resizing HPT\n");
>  			return -ENOSPC;
> =20
>  		default:

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--4imyEzq1NYdDURgI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlyBsrMACgkQbDjKyiDZ
s5IDbw//ZcZrhFhurgIC/WgRZvDtOB6Th/FrzIzwTS9qcveE14Zqu/aQGci6g7jY
b6wAzTtPU7kK3hDs6yuFmwsLfqVjwbsai1p1LB6XyaUR81U2C+LySBJJ4cdNofVP
ux6PjriUbK8/7QI8qo5uSdxgnwYLk3+iDutcDEHeVExwR6LIRVuVTbHLREE0LlFt
o7JxDFcFKSDxxoop0Jnkh4t2q3CI7Y1RPEH5JejvJ1dJ+hgaBe0zaFTyF6vhnK0Q
Id5fazTPONYQvtG6yo6hnlVdUoSualsjF6HW9GPQoSk2Dm5da4RnmAQDQ6RWI4ct
8/k0L1UrkmC2o3bRQzwcZqnyMoSWOAVNIotxsTd4uuVTd6+MiYc0dSAruwZWi4gD
t3LASKFwu204ov3AulnXZWulWs3NfN2F0Fp8rqsHXYTRcJfV2QL4Cvi94ZdZ/uHr
VbZir3uVbcEmKrh7EUbnOKQecdS4YvDAs/hnlxTEQmTz4bd+EO8pOnaeZxGwg8hc
79clDfONS3N0e+UaWGdDkf7fA6W9UQTaJ8A9Hjb1SX1QOikxCat0VLOKaAKa39VM
VQHQETHRMhCVXo35XRRROLAt2oE8xRv1F+fhjrZzZGHNJaODjc/0L3Tf/9WFPJLb
ZegRfCPhOLvFMHKpSrGNflgGlzOXkXkvTxmXoe+mBPU7BZfytEA=
=lw9t
-----END PGP SIGNATURE-----

--4imyEzq1NYdDURgI--
