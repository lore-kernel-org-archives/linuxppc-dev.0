Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 2/2] powerpc: Add IPIC MSI support
From: Michael Ellerman <michael@ellerman.id.au>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <90B908AC-E879-4046-AAFC-FE79EB78A932@kernel.crashing.org>
References: <1196764760.2573.10.camel@Guyver>
	<97EB3576-6952-4F36-A243-4EBF981A117F@kernel.crashing.org>
	<995B09A8299C2C44B59866F6391D2635DB0633@zch01exm21.fsl.freescale.net>
	<90B908AC-E879-4046-AAFC-FE79EB78A932@kernel.crashing.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-HWlVrhEg2nHE6cCxGmMT"
Date: Fri, 14 Dec 2007 20:40:23 +1100
Message-Id: <1197625223.18300.1.camel@concordia>
Mime-Version: 1.0
Cc: Olof Johansson <olof@lixom.net>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Phillips Kim <Kim.Phillips@freescale.com>,
	Jin Zhengxiong <Jason.Jin@freescale.com>, Li Tony <Tony.Li@freescale.com>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-HWlVrhEg2nHE6cCxGmMT
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2007-12-14 at 02:52 -0600, Kumar Gala wrote:
> On Dec 14, 2007, at 2:47 AM, Li Tony wrote:
>=20
> >
> > Hi,
> >
> > I think it is possible to make common code to support both IPIC and =20
> > MPIC.
> > Currently, the MPIC has already implemented MSI which is different =20
> > from IPIC and embedded into the mpic code body.
> > If want to unifiy MSI code, we need to remove the current MPIC MSI =20
> > implementation.
>=20
> The MPIC is going to have to support several MSI styles (IBM/U3, =20
> PaSemi, and FSL) since we all seem to handle it differently.

I haven't really looked at the similarities or differences, but I think
Kumar is right, MPIC is going to have to (and already does) support
different styles.

If there's some commonality that can be shared I'm all ears, patches
welcome ;)

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-HWlVrhEg2nHE6cCxGmMT
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHYk+HdSjSd0sB4dIRAiwQAKDOG6RFV7r7bNc5VEhdPued7PqBzACguV0p
+okDPsHt9ndWVsvabWK4qF0=
=yp5U
-----END PGP SIGNATURE-----

--=-HWlVrhEg2nHE6cCxGmMT--
