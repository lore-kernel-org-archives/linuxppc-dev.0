Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rPXNw6PzszDq66
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jun 2016 12:26:08 +1000 (AEST)
Date: Wed, 8 Jun 2016 12:19:52 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Anton Blanchard <anton@au1.ibm.com>
Cc: Alexander Graf <agraf@suse.de>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 qemu-devel@nongnu.org, pbonzini@redhat.com
Subject: Re: [PATCH 1/2] Add PowerPC AT_HWCAP2 definitions
Message-ID: <20160608021952.GT9226@voom.fritz.box>
References: <20160404164457.539a55f0@kryten> <57021123.6050506@ozlabs.ru>
 <20160404204346.1cf44df8@kryten> <20160404210928.0d9ae644@kryten>
 <F99A6122-6B6D-45A3-99E2-2F56F143FB50@suse.de>
 <20160430104800.0a7c1d11@kryten> <20160607222842.4a745724@kryten>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="k8r0khnpBuGu0wUi"
In-Reply-To: <20160607222842.4a745724@kryten>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--k8r0khnpBuGu0wUi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 07, 2016 at 10:28:42PM +1000, Anton Blanchard wrote:
> From: Anton Blanchard <anton@samba.org>
>=20
> We need the PPC_FEATURE2_HAS_HTM bit in a subsequent patch, so
> add the PowerPC AT_HWCAP2 definitions.
>=20
> Signed-off-by: Anton Blanchard <anton@samba.org>

Applied to ppc-for-2.7.

Paolo or Peter: since this is a change to PPC specific bits, it seems
reasonable to go through my tree although it's technically a generic
header.  If someone wants to drop an explicit Ack, that wouldn't hurt
of course.

> ---
>=20
> diff --git a/include/elf.h b/include/elf.h
> index 28d448b..8533b2a 100644
> --- a/include/elf.h
> +++ b/include/elf.h
> @@ -477,6 +477,19 @@ typedef struct {
>  #define PPC_FEATURE_TRUE_LE             0x00000002
>  #define PPC_FEATURE_PPC_LE              0x00000001
> =20
> +/* Bits present in AT_HWCAP2 for PowerPC.  */
> +
> +#define PPC_FEATURE2_ARCH_2_07          0x80000000
> +#define PPC_FEATURE2_HAS_HTM            0x40000000
> +#define PPC_FEATURE2_HAS_DSCR           0x20000000
> +#define PPC_FEATURE2_HAS_EBB            0x10000000
> +#define PPC_FEATURE2_HAS_ISEL           0x08000000
> +#define PPC_FEATURE2_HAS_TAR            0x04000000
> +#define PPC_FEATURE2_HAS_VEC_CRYPTO     0x02000000
> +#define PPC_FEATURE2_HTM_NOSC           0x01000000
> +#define PPC_FEATURE2_ARCH_3_00          0x00800000
> +#define PPC_FEATURE2_HAS_IEEE128        0x00400000
> +
>  /* Bits present in AT_HWCAP for Sparc.  */
> =20
>  #define HWCAP_SPARC_FLUSH               0x00000001
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--k8r0khnpBuGu0wUi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXV4DHAAoJEGw4ysog2bOS2SkP/A3zHKtYT2pU3JPkxuVOe2m+
/NY8wjZn3lO5tWof569U3y9TVXEpnEUVrGvyvZUfd6OJ+zn+xQj4ro9CDORhG85e
Za3Rzf6l5/95jVclUFa3P7QZggwjb9gfc5c5ySZ2oNep1l2CBOWahJHsgOQ86cV0
yh2EL/wkH55y/HJOPWmaJ7y5W4lzGy0UOhsZ+0+VtolOrDw0KwSIzKx4RHP2I8em
IO39/xl9c5eiiil2b1ivTULkDJ0chvig8oY90KMHyoH5WqmPbxCYH3RBP6EVbeea
ED3H8kCaLcZCphWXhzptsBIQAsRIRR+r+TR6XrSd40s9uEyv9IcD84lthJ7te4QW
G+c1VnhGYVXabDaK/Q479LKjtUiS9NhgNRbCq9agqzc9YkHFgskkLOD0Z/q4mdk1
3wQRswT/Rg3+3+wyP7AzqWmBqs9XE5zP4DXvqVG3YqHf1vrHNStMQQp7GCJc6jzo
lyQbnW/nK5iuObORmJv0SPamGW9pS28n4TdSJVb16D6CXMgKXhlrp32j61zIE5BD
tgQw077WmsA7e1hurp/k4bi1EJQwZV1tA3MFWfx82yxNCtMtUgj2kJ7XxI6pMXD8
zDxZco9QZWwFx7XLxxxom6lRRbcA7Uz4mBIAQfl4F0h1ZJltxGx+zP9MkGtUPAKs
IqbNJFtEbdeoYnfW67oQ
=MQAK
-----END PGP SIGNATURE-----

--k8r0khnpBuGu0wUi--
