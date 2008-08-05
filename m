Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id A4A7DDDE18
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Aug 2008 17:28:09 +1000 (EST)
Date: Tue, 5 Aug 2008 17:28:03 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/mm: Fix attribute confusion with
	htab_bolt_mapping()
Message-Id: <20080805172803.1c556b37.sfr@canb.auug.org.au>
In-Reply-To: <20080805062012.2A161DDE1A@ozlabs.org>
References: <20080805062012.2A161DDE1A@ozlabs.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__5_Aug_2008_17_28_03_+1000_m4Kqo/87w=zEAazZ"
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__5_Aug_2008_17_28_03_+1000_m4Kqo/87w=zEAazZ
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ben,

Just a trivial note ..

On Tue, 05 Aug 2008 16:19:56 +1000 Benjamin Herrenschmidt <benh@kernel.cras=
hing.org> wrote:
>
> +++ linux-work/arch/powerpc/mm/hash_utils_64.c	2008-08-05 16:09:47.000000=
000 +1000
> @@ -18,7 +18,7 @@
>   * 2 of the License, or (at your option) any later version.
>   */
> =20
> -#undef DEBUG
> +#define DEBUG

You will turn this off again before it goes into Paulus' tree, right? :-)

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__5_Aug_2008_17_28_03_+1000_m4Kqo/87w=zEAazZ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkiYAQMACgkQjjKRsyhoI8xePQCgsUpSd6ulF6wg7tcfJvKw5SbB
BgwAnRbC+sxG2rad9Ue3d9q9vsCU1dcY
=HQoi
-----END PGP SIGNATURE-----

--Signature=_Tue__5_Aug_2008_17_28_03_+1000_m4Kqo/87w=zEAazZ--
