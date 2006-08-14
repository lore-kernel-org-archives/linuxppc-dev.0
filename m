Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 4/6] ehea: header files
From: Michael Ellerman <michael@ellerman.id.au>
To: Anton Blanchard <anton@samba.org>
In-Reply-To: <20060811214020.GG479@krispykreme>
References: <44D99F56.7010201@de.ibm.com> <20060811214020.GG479@krispykreme>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-3A6egLWVpu6081XYtX6J"
Date: Mon, 14 Aug 2006 13:20:11 +1000
Message-Id: <1155525611.7807.4.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Thomas Klein <tklein@de.ibm.com>, netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Christoph Raisch <raisch@de.ibm.com>, linux-ppc <linuxppc-dev@ozlabs.org>,
	Marcus Eder <meder@de.ibm.com>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-3A6egLWVpu6081XYtX6J
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2006-08-12 at 07:40 +1000, Anton Blanchard wrote:
> Hi,
>=20
> >  drivers/net/ehea/ehea.h    |  452=20
>=20
> > +#define EHEA_DRIVER_NAME	"IBM eHEA"
>=20
> You are using this for ethtool get_drvinfo. Im not sure if it should
> match the module name, and I worry about having a space in the name. Any
> ideas on what we should be doing here?

I believe it must match the module name. It also might be nice to call
it "DRV_NAME" like most other network drivers do.

cheers

--=20
Michael Ellerman
IBM OzLabs

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-3A6egLWVpu6081XYtX6J
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBE3+vrdSjSd0sB4dIRAleSAJ4pjJgmkcdfTSPqSNorBim1Yt/jOgCeJRI+
ScHIOnwZsiu2/nB/yqIRH28=
=osyf
-----END PGP SIGNATURE-----

--=-3A6egLWVpu6081XYtX6J--
