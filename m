Return-Path: <michael@ellerman.id.au>
Subject: Re: [RFC/PATCH 5/7] RTAS MSI implementation
From: Michael Ellerman <michael@ellerman.id.au>
To: Jake Moilanen <moilanen@austin.ibm.com>
In-Reply-To: <1163016960.9913.276.camel@goblue>
References: <20061107072126.2EE7167CC6@ozlabs.org>
	<1163016960.9913.276.camel@goblue>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-C55ShqfDS5KTjK8tk6FH"
Date: Thu, 09 Nov 2006 10:35:49 +1100
Message-Id: <1163028949.7630.18.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Greg Kroah-Hartman <greg@kroah.com>, linuxppc-dev@ozlabs.org,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	linux-pci@atrey.karlin.mff.cuni.cz, "David S. Miller" <davem@davemloft.net>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-C55ShqfDS5KTjK8tk6FH
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-11-08 at 14:16 -0600, Jake Moilanen wrote:
> On Tue, 2006-11-07 at 18:21 +1100, Michael Ellerman wrote:
> > Powerpc MSI support via RTAS. Based on Jake's code.
> >=20
>=20
> Missing the CAS flags to indicate to firmware that we support MSI.
>=20
> Signed-off-by: Jake Moilanen <moilanen@austin.ibm.com>

Thanks, I'll stick that in the series. Unless Paulus wants to merge it
straight away.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-C55ShqfDS5KTjK8tk6FH
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBFUmnVdSjSd0sB4dIRAmFNAJ447yYgT8wxt/e5s5ph1X2b+1K8+QCcDQp8
zVbyIx/oXieNZfSCI3NK4DM=
=4g7r
-----END PGP SIGNATURE-----

--=-C55ShqfDS5KTjK8tk6FH--
