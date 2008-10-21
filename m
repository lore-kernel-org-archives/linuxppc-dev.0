Return-Path: <michael@ellerman.id.au>
Subject: Re: powerpc: delete prom_strtoul and prom_memparse
From: Michael Ellerman <michael@ellerman.id.au>
To: Milton Miller <miltonm@bga.com>
In-Reply-To: <200810210403.m9L43I6t054774@sullivan.realtime.net>
References: <200810210403.m9L43I6t054774@sullivan.realtime.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-TNnxmhMl/o/yxyEtBeN+"
Date: Tue, 21 Oct 2008 17:17:55 +1100
Message-Id: <1224569875.8228.34.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-TNnxmhMl/o/yxyEtBeN+
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2008-10-20 at 23:03 -0500, Milton Miller wrote:
> These functions should have been static, and inspection shows they
> are no longer used.   (We used to parse mem=3D but we now defer that
> to early_param).

Actually the last user was the crashkernel=3D handling, but that was
removed a while ago too, my bad.

Acked-by: Michael Ellerman <michael@ellerman.id.au>

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-TNnxmhMl/o/yxyEtBeN+
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBI/XQTdSjSd0sB4dIRAh5PAKCTSQeLi8zuspWpZCG/ouFFkncbiQCfSC1b
cspw5HdUobPV45plVwf5Xrc=
=ftfG
-----END PGP SIGNATURE-----

--=-TNnxmhMl/o/yxyEtBeN+--
