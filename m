Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] pseries: asm/pci-bridge.h CONFIG_ minor cleanup
From: Michael Ellerman <michael@ellerman.id.au>
To: Linas Vepstas <linas@austin.ibm.com>
In-Reply-To: <20070522170058.GJ5921@austin.ibm.com>
References: <20070521231816.GH5921@austin.ibm.com>
	<1179794459.7189.2.camel@concordia.ozlabs.ibm.com>
	<20070522170058.GJ5921@austin.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-N/nSVSFEEgsFfdDaq0UG"
Date: Wed, 23 May 2007 11:11:32 +1000
Message-Id: <1179882692.6145.8.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-N/nSVSFEEgsFfdDaq0UG
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2007-05-22 at 12:00 -0500, Linas Vepstas wrote:
> On Tue, May 22, 2007 at 10:40:59AM +1000, Michael Ellerman wrote:
> > On Mon, 2007-05-21 at 18:18 -0500, Linas Vepstas wrote:
> > > Use the correct CONFIG_ option to mark off the EEH bits.
> >=20
> > You're making the struct 4 bytes larger by creating a hole here :(
>=20
> Hmm. Perhaps I could shuffle one of the ints down ... =20
>=20
> I figured there might be some vague cache-line benefits to
> getting the eeh stuff out of the way.=20

Yeah who knows. The hole doesn't really matter unless the struct gets
bigger, having the EEH stuff at the bottom makes it read better which is
probably more important.


> > >  	u32	config_space[16];	/* saved PCI config space */
> > > +#endif
> >=20
> > It looks correct, but I think it's worth mentioning in the changelog
> > that config_space was previously unconditionally defined, but is now
> > within CONFIG_EEH.
>=20
> I could just tell that someone would remark on this; why I didn't
> mention it, I don't know.

Me neither :)

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-N/nSVSFEEgsFfdDaq0UG
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGU5TEdSjSd0sB4dIRAiNuAJ95tv0ndrhznZ7BTyuVu6uzzVinKgCeI/Mt
l/Ykel/jQSPjUs65QBYaz8A=
=4loX
-----END PGP SIGNATURE-----

--=-N/nSVSFEEgsFfdDaq0UG--
