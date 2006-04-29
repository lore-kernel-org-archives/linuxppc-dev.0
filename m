Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id DC98C679EB
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Apr 2006 12:38:36 +1000 (EST)
Date: Sat, 29 Apr 2006 12:38:29 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [RFC , PATCH] support for the ibm,pa_features cpu property
Message-Id: <20060429123829.4d25b125.sfr@canb.auug.org.au>
In-Reply-To: <17490.52602.577587.524391@cargo.ozlabs.ibm.com>
References: <1146249684.27214.18.camel@localhost.localdomain>
	<17490.52602.577587.524391@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Sat__29_Apr_2006_12_38_29_+1000_eK_sGbzpt6aijjoC"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Sat__29_Apr_2006_12_38_29_+1000_eK_sGbzpt6aijjoC
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Paul,

On Sat, 29 Apr 2006 12:20:42 +1000 Paul Mackerras <paulus@samba.org> wrote:
>
> +	/* find descriptor with type =3D=3D 0 */
> +	for (;;) {
> +		if (tablelen < 3 || tablelen < 2 + pa_feature_table[1])
                                                                    ^
Shouldn't that be 0?

> +			goto out;	/* not found */
> +		if (pa_feature_table[0] =3D=3D 0)
                                     ^
And this 1?

> +			break;
> +		tablelen -=3D 2 + pa_feature_table[1];
                                                 ^
0

> +		pa_feature_table +=3D 2 + pa_feature_table[1];
                                                         ^
0

> +	}
> +
> +	/* check if the specifier is long enough */
> +	if (pabyte >=3D pa_feature_table[1])
                                       ^
0

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sat__29_Apr_2006_12_38_29_+1000_eK_sGbzpt6aijjoC
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFEUtGmFdBgD/zoJvwRAm8SAJ0R4fQklSv9kHWBDDhXdgy2KKD6lgCfQGXS
cZSqIzQeOvKpRmUYfWRnsTM=
=q2v1
-----END PGP SIGNATURE-----

--Signature=_Sat__29_Apr_2006_12_38_29_+1000_eK_sGbzpt6aijjoC--
