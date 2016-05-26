Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rFVtN674KzDqR6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 May 2016 10:50:20 +1000 (AEST)
Date: Thu, 26 May 2016 10:47:35 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Bharata B Rao <bharata@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, nfont@linux.vnet.ibm.com,
 aik@au1.ibm.com, mpe@ellerman.id.au
Subject: Re: [FIX PATCH v2 1/2] powerpc,numa: Fix whitespace in
 hot_add_drconf_memory_max()
Message-ID: <20160526004735.GR17226@voom.fritz.box>
References: <1463060055-24158-1-git-send-email-bharata@linux.vnet.ibm.com>
 <1463060055-24158-2-git-send-email-bharata@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="EguBBKnZWdUQS9Kz"
In-Reply-To: <1463060055-24158-2-git-send-email-bharata@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--EguBBKnZWdUQS9Kz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 12, 2016 at 07:04:14PM +0530, Bharata B Rao wrote:
> Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  arch/powerpc/mm/numa.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>=20
> diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
> index 669a15e..4a87ccb 100644
> --- a/arch/powerpc/mm/numa.c
> +++ b/arch/powerpc/mm/numa.c
> @@ -1163,18 +1163,18 @@ int hot_add_scn_to_nid(unsigned long scn_addr)
> =20
>  static u64 hot_add_drconf_memory_max(void)
>  {
> -        struct device_node *memory =3D NULL;
> -        unsigned int drconf_cell_cnt =3D 0;
> -        u64 lmb_size =3D 0;
> +	struct device_node *memory =3D NULL;
> +	unsigned int drconf_cell_cnt =3D 0;
> +	u64 lmb_size =3D 0;
>  	const __be32 *dm =3D NULL;
> =20
> -        memory =3D of_find_node_by_path("/ibm,dynamic-reconfiguration-me=
mory");
> -        if (memory) {
> -                drconf_cell_cnt =3D of_get_drconf_memory(memory, &dm);
> -                lmb_size =3D of_get_lmb_size(memory);
> -                of_node_put(memory);
> -        }
> -        return lmb_size * drconf_cell_cnt;
> +	memory =3D of_find_node_by_path("/ibm,dynamic-reconfiguration-memory");
> +	if (memory) {
> +		drconf_cell_cnt =3D of_get_drconf_memory(memory, &dm);
> +		lmb_size =3D of_get_lmb_size(memory);
> +		of_node_put(memory);
> +	}
> +	return lmb_size * drconf_cell_cnt;
>  }
> =20
>  /*

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--EguBBKnZWdUQS9Kz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXRkenAAoJEGw4ysog2bOSOC4P/1mopSNUwApP3d9Ey6Sdgn2D
ZnDGcvrRDU2dU9peX/1HcZllp/pwkyi65/05DUNYWCTu46z+aB/6etBKMWH1ogJf
mCCn4Z+O0kaF+JLPjGLJbksJg7JzQkOi2jcnhLYG8jRjKtvLw7GpqoIWim8s46pm
lWWBOOv7GW+QAIESFycBEKSegmBH8ARPoX9wskIKf66iBvtcbZNlKV8uW31q7v+/
KEtVwiS9EzCHhrpqKyD/Jc/AeQkkDyp3a6ODjG1UB+BC6EmzkaCz8bkaxl7Eagaj
jifDjklZzxeDelhqEc6QTT098PXfSj52L3+ytZ9MK9vjhLOMpXgjA+QpHt1xmuac
YU870mDxCEvax+ml/A2/+k26yQdbMWB24k7CRkbRyB0+QPvbvqBfLtM1diBMVbjv
B6nLXgQTM7+CjzCVGeVxebLCM+K9pL1TbhV4TZcfyN9r4VHDAeO0KkinjO9nrAlm
7Id7VeqcN2kzyFBF5qRdhQnYcA5lCPJbhL8rDx0YK/aNFbDxUG5HQa50Cs2Y4eYB
6B4yBc7LMd0NRXaYI5QSVqnxyLOBSw1Hgnjy6axDO3qed2PxGbxJY1lZt4Srn+si
cpOO2q0hS6bPNGiS9vel/DOcjK0f2Xn4J8cp1z1xJF4MReQE2lkPchXj/fV3F4wt
qnl/uD/tLpgMyb4Xppiu
=V+7/
-----END PGP SIGNATURE-----

--EguBBKnZWdUQS9Kz--
