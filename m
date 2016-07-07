Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rlPxR2fQtzDqnG
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jul 2016 14:37:47 +1000 (AEST)
Date: Thu, 7 Jul 2016 14:38:33 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Sam Bobroff <sam.bobroff@au1.ibm.com>
Cc: anton@au1.ibm.com, mikey@neuling.org, aik@ozlabs.ru, mpe@ellerman.id.au,
 agraf@suse.de, qemu-devel@nongnu.org, paulus@samba.org,
 qemu-ppc@nongnu.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 2/3] Add KVM_CAP_PPC_HTM to linux/kvm.h
Message-ID: <20160707043833.GQ14675@voom.fritz.box>
References: <cover.1467783317.git.sam.bobroff@au1.ibm.com>
 <a27fd68b3b5bc20afcebe7c066c472f7239cc488.1467783317.git.sam.bobroff@au1.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="dUqh8vgUBVXHzm9w"
In-Reply-To: <a27fd68b3b5bc20afcebe7c066c472f7239cc488.1467783317.git.sam.bobroff@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--dUqh8vgUBVXHzm9w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 06, 2016 at 03:35:22PM +1000, Sam Bobroff wrote:
> Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>

We need to wait for this to be merged on the kernel side.

> ---
>  linux-headers/linux/kvm.h | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
> index e60e21b..37cb3e8 100644
> --- a/linux-headers/linux/kvm.h
> +++ b/linux-headers/linux/kvm.h
> @@ -866,6 +866,7 @@ struct kvm_ppc_smmu_info {
>  #define KVM_CAP_ARM_PMU_V3 126
>  #define KVM_CAP_VCPU_ATTRIBUTES 127
>  #define KVM_CAP_MAX_VCPU_ID 128
> +#define KVM_CAP_PPC_HTM 129
> =20
>  #ifdef KVM_CAP_IRQ_ROUTING
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--dUqh8vgUBVXHzm9w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXfdzJAAoJEGw4ysog2bOSxZgQAK6wsKzwc6RuYap68mDKP+qP
gKRLWVUjcsvDMz21exiCdGA8NzEHcDbyIu4oJKezT1u06OscHOXe82pCkrhLRdrD
DV7lAgCcXgMNS3gFHxk4J/9tkH0igujkvS1L45Gx/JL8G9f4YuRo3L4wEnZnV4kF
PmaVHLTKXOH11i5ZjwIc6hIsUwlOIqXEf2utJS3axF6umSWFtvOSU/DI0YZMV1Fg
Kzn5BtK2jBmbNab7htxBzIwIAIglvhxxSWFxF0/cxUz2esKw9V6B5wgNqxZfUXc2
xHBIglC9QLBUnE7Zn3PxBSOhiT2+k1hZih8PokysydOPNj3fP3LEqqQuZ5wWbT68
zrlgxnhA+njKeXbmQcxkjySPZ8IyaTpKmlUV0LO5TcE8hzEgO3mJX0YlL/QsUyTV
fLhcqfJA+LsWWqkkO4U9qsWcX9Ub3zereOqgaAWQSkJzMoJI4TmUnZLMBGPJfexE
Wg9mibhEOIdrvBTB/upVy4vxm5+npQEh5zsJQccidyp/puFRUr0Oo9OUfHUi/s2S
E4jb07Nlk8STwVCVKZkQixjyejGGHcrrrvpiADUMdpMaoFtiODx2OgA08Eoh79rN
IpfBZvmHDB4qEEdvVFx61Fwa9YNZp42nlZfMlAK9ir3Eq5q0001H4nFeuoS3B2Lh
6ZjfKREockDdyS7SwJWw
=tFE+
-----END PGP SIGNATURE-----

--dUqh8vgUBVXHzm9w--
