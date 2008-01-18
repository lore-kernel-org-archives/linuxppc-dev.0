Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] Fake NUMA emulation for PowerPC (Take 2)
From: Michael Ellerman <michael@ellerman.id.au>
To: Balbir Singh <balbir@linux.vnet.ibm.com>
In-Reply-To: <20071207223714.11448.91386.sendpatchset@balbir-laptop>
References: <20071207223714.11448.91386.sendpatchset@balbir-laptop>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-LVrVCwTpS2JId/FH7JDu"
Date: Fri, 18 Jan 2008 16:34:53 +1100
Message-Id: <1200634493.7806.0.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-LVrVCwTpS2JId/FH7JDu
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2007-12-08 at 04:07 +0530, Balbir Singh wrote:
> Changelog
>=20
> 1. Get rid of the constant 5 (based on comments from
>                                 Geert.Uytterhoeven@sonycom.com)
> 2. Implement suggestions from Olof Johannson
> 3. Check if cmdline is NULL in fake_numa_create_new_node()
>=20
> Tested with additional parameters from Olof
>=20
> numa=3Ddebug,fake=3D
> numa=3Dfoo,fake=3Dbar


I'm not sure why yet, but git bisect tells me it's this patch that's
causing the for-2.6.25 tree to explode on boot on cell machines.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-LVrVCwTpS2JId/FH7JDu
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHkDp9dSjSd0sB4dIRAiIXAKCksXvtF/APrTZ51axudD4PRcXpegCePxck
AnX8rh+NGgHGeVhx5PjicnA=
=SHkM
-----END PGP SIGNATURE-----

--=-LVrVCwTpS2JId/FH7JDu--
