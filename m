Return-Path: <SRS0=wHv8=RQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD1BC43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 04:37:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 463AF2177E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 04:37:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="pwrunOu1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 463AF2177E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44JzbB2BjVzDq5h
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 15:37:26 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44JzNm2J0pzDqBX
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Mar 2019 15:28:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="pwrunOu1"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 44JzNl5nPpz9sDB; Wed, 13 Mar 2019 15:28:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1552451303;
 bh=YwQ5f+H3Ru8vCsfwi5Jh+JuQ9ZKtgXRwSwkRtI2CsaQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=pwrunOu1PWfR6fRj9TQpUxRRlZMt3BsM1hkutfBn91MxkbFMfuBUjKxfIeqNzZEUL
 xhjJxQ02+SUGIvbH4Af9Bivy+mqBFDeGoxWVVPZc+Ibn2uUUkLEy5BHnx3y0JIiJw6
 m6I0cn+/SPL/FpY6XC6IqqjyGQuRGRClqYBRStpA=
Date: Wed, 13 Mar 2019 15:27:37 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH v2] powerpc/mm: move warning from resize_hpt_for_hotplug()
Message-ID: <20190313042737.GR9881@umbus.fritz.box>
References: <20190308105413.4302-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="jcwRHPSxFqmwpRFb"
Content-Disposition: inline
In-Reply-To: <20190308105413.4302-1-lvivier@redhat.com>
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


--jcwRHPSxFqmwpRFb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 08, 2019 at 11:54:13AM +0100, Laurent Vivier wrote:
> resize_hpt_for_hotplug() reports a warning when it cannot
> resize the hash page table ("Unable to resize hash page
> table to target order") but in some cases it's not a problem
> and can make user thinks something has not worked properly.
>=20
> This patch moves the warning to arch_remove_memory() to
> only report the problem when it is needed.
>=20
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  arch/powerpc/include/asm/sparsemem.h  |  4 ++--
>  arch/powerpc/mm/hash_utils_64.c       | 17 ++++++-----------
>  arch/powerpc/mm/mem.c                 |  3 ++-
>  arch/powerpc/platforms/pseries/lpar.c |  3 ++-
>  4 files changed, 12 insertions(+), 15 deletions(-)
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
> index f2a9f0adc2d3..1034ef1fe2b4 100644
> --- a/arch/powerpc/platforms/pseries/lpar.c
> +++ b/arch/powerpc/platforms/pseries/lpar.c
> @@ -901,8 +901,10 @@ static int pseries_lpar_resize_hpt(unsigned long shi=
ft)
>  		break;
> =20
>  	case H_PARAMETER:
> +		pr_warn("Invalid argument from H_RESIZE_HPT_PREPARE\n");
>  		return -EINVAL;
>  	case H_RESOURCE:
> +		pr_warn("Operation not permitted from H_RESIZE_HPT_PREPARE\n");
>  		return -EPERM;
>  	default:
>  		pr_warn("Unexpected error %d from H_RESIZE_HPT_PREPARE\n", rc);
> @@ -918,7 +920,6 @@ static int pseries_lpar_resize_hpt(unsigned long shif=
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

--jcwRHPSxFqmwpRFb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlyIhrgACgkQbDjKyiDZ
s5L0exAAymSOpxCfriMb6Npbikc1b9QnS8txmrdxAbX6Jiq0wt3FLblYSVY6RGau
/jacSHypqEXMspnISemTjIImA+BPtDgCBIeuiVuF0eGCZ71I9Vlq4mhnc2lOmP7d
HIrvJ7IlWiqJ50WIlnGER4iypjCW3Mg+I+Z+XyILw+7x03O6GFV6wppit82E9Io3
jZKtXgnEjM/JIMZi1FhPTbM/E42T9D7XdNkwGX1VHzxyMBnKoP+KRSDkRheU1HKv
GlZLCGmeHTvYn3RAOFyIobXPuBKIIZNuOh/jbZ3j9kKbngwElSJ+CaTsqzOWTppf
qdVeOp80P6oehC/PdyjI1Jy3madGIDK/VRzDv9kurK0RVJyltuN+s+PU7V1+o5b9
JE1xGq9mSNFcAewYDEl2UiXAaJVvQ1Jb9b1xIGzTGu9dUl8DtDUfkAE3KeIFWBtA
/UjrjKHGLZIm6YQHeBtCjnEBpF6SJDPYORF5O9JL0p+tNwUIL2cm4RvjyM+Rv5As
DvbIEUryQ0x/Jph1MeNWIpyEDYCINwVh17mKGxSLQlUWg0RcjBDMQEIUe32Mar/V
BLz+iK/D3zmS4Bi7mMR1Cw9+JMbtg63WIx3VGv9NvxJA5Ht4fK/3qJyLrZPgobwi
R0XDc0QKMBZnvVq0xJVUivFOLRWus4vKHmCICLw0aEUGF0apNw0=
=wCLS
-----END PGP SIGNATURE-----

--jcwRHPSxFqmwpRFb--
