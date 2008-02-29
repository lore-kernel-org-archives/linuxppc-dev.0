Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 0/8] pseries: phyp dump: hypervisor-assisted dump
From: Michael Ellerman <michael@ellerman.id.au>
To: Manish Ahuja <ahuja@austin.ibm.com>
In-Reply-To: <47C74A66.1060105@austin.ibm.com>
References: <47B90F55.2080606@austin.ibm.com>
	<1203641584.15378.2.camel@concordia.ozlabs.ibm.com>
	<47C74A66.1060105@austin.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-BtBPsnOKFl1ntYCYs9Ru"
Date: Fri, 29 Feb 2008 13:20:50 +1100
Message-Id: <1204251650.7729.13.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Linas Vepstas <linasvepstas@gmail.com>,
	paulus <paulus@samba.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-BtBPsnOKFl1ntYCYs9Ru
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2008-02-28 at 17:57 -0600, Manish Ahuja wrote:
> Changes from previous version:
>=20
> The only changes are in patch 2.
> moved early_init_dt_scan_phyp_dump from rtas.c to phyp_dump.c
> Added dummy function in phyp_dump.h

This fixes the build failures I was seeing!
http://kisskb.ellerman.id.au/kisskb/head/664/

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-BtBPsnOKFl1ntYCYs9Ru
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHx2wCdSjSd0sB4dIRArPaAKC3Yfy0rfwvIpTwF6luFPFhl/jzlACeNTjf
kd/wR1hiSXZBoExR0lz8CtI=
=p/p/
-----END PGP SIGNATURE-----

--=-BtBPsnOKFl1ntYCYs9Ru--
