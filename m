Return-Path: <sfr@canb.auug.org.au>
Date: Tue, 27 Sep 2005 15:38:40 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kumar Gala <kumar.gala@freescale.com>
Message-Id: <20050927153840.575d00e1.sfr@canb.auug.org.au>
In-Reply-To: <660EDD16-DB29-4168-8399-A0F4FA407CF5@freescale.com>
References: <17208.37250.577664.621993@cargo.ozlabs.ibm.com>
	<660EDD16-DB29-4168-8399-A0F4FA407CF5@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__27_Sep_2005_15_38_40_+1000_CDQ9/y=9yROi2b9Z"
Cc: linuxppc-dev@ozlabs.org, linuxppc64-dev@ozlabs.org
Subject: Re: Starting the arch/powerpc merge
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__27_Sep_2005_15_38_40_+1000_CDQ9/y=9yROi2b9Z
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 26 Sep 2005 22:39:56 -0500 Kumar Gala <kumar.gala@freescale.com> wr=
ote:
>
> You have duplicated files between arch/ppc/ and arch/powerpc.  Do you =20
> plan on cleaning this up are should we make sure we "fix" both?

I have done a patch that fixed most of those (but not all).  It will be in =
the
merge tree when Paulus next pushes it out.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__27_Sep_2005_15_38_40_+1000_CDQ9/y=9yROi2b9Z
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDONrgFdBgD/zoJvwRAjBLAJkBD7HNtplB02ab3QQTLe+ke660lgCeIeiC
CLy9/bn2Hz5AwGu7D8pmIow=
=rmql
-----END PGP SIGNATURE-----

--Signature=_Tue__27_Sep_2005_15_38_40_+1000_CDQ9/y=9yROi2b9Z--
