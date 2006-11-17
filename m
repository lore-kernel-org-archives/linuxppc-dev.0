Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 7/16] powerpc: add support for ps3 platform
From: Michael Ellerman <michael@ellerman.id.au>
To: Geoff Levand <geoffrey.levand@am.sony.com>
In-Reply-To: <455D1161.2020605@am.sony.com>
References: <4554DACB.8060809@am.sony.com> <20061115180440.GB18856@lst.de>
	<1163723984.5940.411.camel@localhost.localdomain>
	<455D1161.2020605@am.sony.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-s5jQd7gVTw6jrsC1yBsp"
Date: Fri, 17 Nov 2006 12:42:14 +1100
Message-Id: <1163727734.16815.24.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-s5jQd7gVTw6jrsC1yBsp
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-11-16 at 17:33 -0800, Geoff Levand wrote:
> Benjamin Herrenschmidt wrote:
> >> > +
> >> > +enum page_size {
> >> > +	page_size_4k =3D 12U,
> >> > +	page_size_64k =3D 16U,
> >> > +	page_size_16m =3D 24U,
> >> > +};
> >>=20
> >> Please use ALL_CAPS for such constants.
> >=20
> > And call them PAGE_SHIFT_* while at it :-)
>=20
> The HV docs call this page size, so that is what I used for
> the symbol.  I'll look at the usage again and reconsider.

No need to look at it, it's a shift not a size, the page size is not 12
bytes. Keeping it consistent with the HV docs is a concern, but so is
making it consistent with every other part of the kernel - which calls
this a shift, see page.h f.e.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-s5jQd7gVTw6jrsC1yBsp
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBFXRN2dSjSd0sB4dIRApoGAJsHdXnmpJCcuFCdNFxzIv1r0AH4zACgroTN
Mv7wYvB4bumvZtcVIStz7Wg=
=cS4E
-----END PGP SIGNATURE-----

--=-s5jQd7gVTw6jrsC1yBsp--
