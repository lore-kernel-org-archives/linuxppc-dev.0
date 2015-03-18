Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F1D4A1A0013
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Mar 2015 16:48:13 +1100 (AEDT)
Date: Wed, 18 Mar 2015 16:48:08 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCHv4] powerpc: comvert relocs_check to a shell script using
 grep
Message-ID: <20150318164808.3e5d2430@canb.auug.org.au>
In-Reply-To: <20150318164616.42a1cc93@canb.auug.org.au>
References: <20150318164616.42a1cc93@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Uejqr.+YJkxU+Bp8iF3fohu"; protocol="application/pgp-signature"
Cc: linuxppc-dev@lists.ozlabs.org, David Laight <David.Laight@ACULAB.COM>,
 Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Sig_/Uejqr.+YJkxU+Bp8iF3fohu
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 18 Mar 2015 16:46:16 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> This runs a bit faster and removes another use of perl from
> the kernel build.
>=20
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

I forgot to add in the

Acked-By: Tony Breeds <tony@bakeyournoodle.com>

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Sig_/Uejqr.+YJkxU+Bp8iF3fohu
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVCRGdAAoJEMDTa8Ir7ZwVbwoP/3hnh8+Nzs8b3hbGq5Nl4Xew
7QHcDVF/5rreOALrxHdIuP07Sp2HBjXDj3XBZWiIrn5RXo1FM/mLYaEX7+QH1kGV
9ukc4xng27pN3sZC2cEx/ENKxTRDsgwbRFsQkQi8Un0BMbdiokSgkJUNP6v6shLz
xycHmfwgIwX4TelvqHxLEtAePNfwglS9GnZlPhb2lkExnN97e7B8Qx7sGZGrHS3v
tlSBTWA1LPqJyoI1ormrm2oeNZ23aO45YMnhZwrLuUPk1Td8EGJyiPcWsiXydhhh
ScvY93UVL7Zjw9lErFCZBtssJ/0CFr05kjkI9PLvfTc4IxEUReDRs0eSUQZjvKXi
bSb/EEP3CLxkS7z/BYKMLdlurokxJmtpbAgFaw0uc1nyfWNJQaQ0uI0IxzZ0VwY5
q1caJ62NErFxEOzF3lYm7Y1FT/JfXsAPnVlwyxISqNdVR0hHW1w4YqDODiUmNhie
Xz73+idbrDm7JzkFI4n+KyNzJfwKDIYIdiGM1Q8rcce9XX4JtPLKFgpwDlbNEhmI
oDq25aZHYpb6Tqy+BQyE+0CFnJxHOTtNkWEeEd9LGs/42JkijszNX7yPFwbzwTHb
EfMucPQeL3DuWVCdrzo9VeUjIBcSuLGZV27TkETNdDr0pSwfONjNmcDYYFYv6LN7
BCK/s8UxIs7VHRV2fWjy
=PpEt
-----END PGP SIGNATURE-----

--Sig_/Uejqr.+YJkxU+Bp8iF3fohu--
