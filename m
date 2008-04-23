Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 1/3 v3] Raise the upper limit of NR_CPUS.
From: Michael Ellerman <michael@ellerman.id.au>
To: Tony Breeds <tony@bakeyournoodle.com>
In-Reply-To: <d54206d25b690c9160401f65a583f586004dcd5d.1208923391.git.tony@bakeyournoodle.com>
References: <d54206d25b690c9160401f65a583f586004dcd5d.1208923391.git.tony@bakeyournoodle.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-gUhVGDmVQ9Auy7tIG5Ob"
Date: Wed, 23 Apr 2008 15:41:39 +1000
Message-Id: <1208929299.9212.4.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-gUhVGDmVQ9Auy7tIG5Ob
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2008-04-23 at 14:06 +1000, Tony Breeds wrote:
> As the pacas are statically initialised increasing NR_CPUS beyond 128,
> means that any additional pacas will be empty  ... which is bad.
>=20
> This patch adds the required functionality to fill in any excess pacas
> at runtime.
>=20
> Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
> ---

You add about 30 lines of code in this patch, which you remove in patch
3, is there a better way to do it?

Is there any harm dynamically initialising the statically initialised
pacas, I think that would allow you to basically skip the
NR_STATIC_PACAS business.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-gUhVGDmVQ9Auy7tIG5Ob
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBIDswTdSjSd0sB4dIRAoccAJ91Oov9z+vKmlXmJq4WrirZhf762gCgwCCw
PPQEeoZgOQrqFJHCpku40k4=
=f2Eq
-----END PGP SIGNATURE-----

--=-gUhVGDmVQ9Auy7tIG5Ob--
