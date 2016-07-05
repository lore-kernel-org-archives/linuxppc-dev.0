Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rkDxp4CvQzDqrX
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jul 2016 16:49:02 +1000 (AEST)
Date: Tue, 5 Jul 2016 16:05:58 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Sam Bobroff <sam.bobroff@au1.ibm.com>
Cc: anton@au1.ibm.com, mikey@neuling.org, aik@ozlabs.ru, mpe@ellerman.id.au,
 agraf@suse.de, qemu-devel@nongnu.org, paulus@samba.org,
 qemu-ppc@nongnu.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/3] Add KVM_CAP_PPC_HTM to linux/kvm.h
Message-ID: <20160705060558.GL2251@voom.fritz.box>
References: <cover.1467695915.git.sam.bobroff@au1.ibm.com>
 <d2e391d1e0e381276ee2bff8e59d872c4b3bd2b5.1467695915.git.sam.bobroff@au1.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="z9sQuz+HmDh2hVO4"
In-Reply-To: <d2e391d1e0e381276ee2bff8e59d872c4b3bd2b5.1467695915.git.sam.bobroff@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--z9sQuz+HmDh2hVO4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 05, 2016 at 03:19:23PM +1000, Sam Bobroff wrote:
> Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>

Ok, so the usual procedure for updates to linux-headers is this:
   1. Get the change merged on the kernel side

   2. Use scripts/update-linux-headers.sh to update the whole
      linux-headers subtree to the new kernel version

   3. Submit the patch - make sure to include the commit id of the
      kernel you updated to in the qemu commit message

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

--z9sQuz+HmDh2hVO4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXe05GAAoJEGw4ysog2bOS2vYQAN2JhOZCWiiKkgrxQfgOTaKI
oBcAUARgTgmwOJuB1JLF3HjqN0qHFXEmY0PfuMahedV8aHokIIec91nSyX9mR0Ot
EIjXOxPL1+K7/MERNXiMAuqNpQ0Qdqlbe8e76nC6Ff9CeUlPIWnNa+d3jqEZjPDE
bgM8ZqVyYBkP0h+jMvnQrY9cn27e46sxcV1Tx4MBFaQBqSagp7+bzq2PnhAFkKZG
+L97qmbwQdFVdGw53YtaiRxVAba83Tuck0uFNCVgAVzKRDslu0hHH10P2pfvfEFj
vm9+vhIml9TsXX2059VEnLyjEwSIIC0liheJgJTnLny2dVeDCgx5U4iN5lZfrhGD
tqRvfR++zfQ0pIJuagXhsrmoZVP5g2YR1G/p34lzAu4jOGfETN94ktWrJ6nblomR
Wu1OZLNqDSHbvKSJMZnjEtRGMIDRDQrm/K5iWYCyJDneD3khofsODpLmmrp6UeBI
ePw5BH8enhsiP9YSHM6HA4w4P+ttWAHoURulzUE95pk46YCc51PFcblIi/PJvwYG
/Cl8fky6fPAkKcR/p/3TypjddZdJSyzah/Jt44jrn51isooYrrzFTz8REwK8XGBc
WnXiC1evjat/7AzHQnfoESaS4bj63VdjwqXlAeGgE0zr9rpM5/j+YYrl576xYjaP
Ubr+GZbnUonJ5uX9guzp
=/itu
-----END PGP SIGNATURE-----

--z9sQuz+HmDh2hVO4--
