Return-Path: <emunson@mgebm.net>
Received: from mail-qy0-f179.google.com (mail-qy0-f179.google.com
	[209.85.216.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1CBC31007D7
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 27 Apr 2011 22:59:39 +1000 (EST)
Received: by qyk7 with SMTP id 7so981491qyk.17
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 27 Apr 2011 05:59:35 -0700 (PDT)
Date: Wed, 27 Apr 2011 08:59:31 -0400
From: Eric B Munson <emunson@mgebm.net>
To: David Laight <David.Laight@ACULAB.COM>
Subject: Re: [PATCH V4] POWER: perf_event: Skip updating kernel counters if
	register value shrinks
Message-ID: <20110427125930.GB2936@mgebm.net>
References: <20110427121902.GA2936@mgebm.net>
	<AE90C24D6B3A694183C094C60CF0A2F6D8AD03@saturn3.aculab.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bCsyhTFzCvuiizWE"
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6D8AD03@saturn3.aculab.com>
Cc: a.p.zijlstra@chello.nl, linux-kernel@vger.kernel.org, paulus@samba.org,
	anton@samba.org, acme@ghostprotocols.net, mingo@elte.hu,
	linuxppc-dev@lists.ozlabs.org, stable@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--bCsyhTFzCvuiizWE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 27 Apr 2011, David Laight wrote:

> > But it isn't, and it doesn't have trouble with 2^32 - 1. =20
>=20
> what about:
> prev =3D 0x00000001
> val  =3D 0xffffffff

Result is 0xfffffffe and we are fine.
>=20
> 	David
>=20
>=20

--bCsyhTFzCvuiizWE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBAgAGBQJNuBMyAAoJEH65iIruGRnNPtwH/3T5/zvmHE2lShhDQxFFqP+R
mLxZZERXWvuFK/ZTK6dAfrtUJTzPcYjtcnHWJV6xaFekMpk7WST3N9aXUu6RMHIC
JnLrieUbi64dWymjVSjLU5wJRvvLUDCqoKIaR6/zu9QBUiucfWOV4RhAbJh+zqKz
mNWYrObmcjWrdwYsql7or1olXsjCWIr28bFO29Ep3xOKS+oXlLUh2Kt4ktsYDtg1
Fppbl1XrpKq0ZkH+LLNU+D6QEzrcyqK2VBrzjSE6UukXc712iW8AQePf5u1TXQE4
NhNrY39WMDmDalXjdLJdbGaTRsVbD0PBOOeqCepmlS1F6bk4goRmaI9zTLOg2yQ=
=cH+J
-----END PGP SIGNATURE-----

--bCsyhTFzCvuiizWE--
