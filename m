Return-Path: <michael@ellerman.id.au>
Subject: Re: [HACK] add sandpoint + flattened dt support to arch/powerpc/boot
From: Michael Ellerman <michael@ellerman.id.au>
To: "Mark A. Greer" <mgreer@mvista.com>
In-Reply-To: <20060519003730.GA7338@mag.az.mvista.com>
References: <20060518002142.GA23182@mag.az.mvista.com>
	<1147960021.7607.5.camel@localhost.localdomain>
	<20060519003730.GA7338@mag.az.mvista.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-qIdlaBzV8WsbRDMSnwSV"
Date: Fri, 19 May 2006 10:49:25 +1000
Message-Id: <1147999765.8515.6.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-qIdlaBzV8WsbRDMSnwSV
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-05-18 at 17:37 -0700, Mark A. Greer wrote:
> On Thu, May 18, 2006 at 08:47:01AM -0500, Matthew McClintock wrote:
> > On Wed, 2006-05-17 at 17:21 -0700, Mark A. Greer wrote:
> > > +void *
> > > +dt_find_prop_by_name(void *dt_blob, char *full_name, u32 *val_sizep)=
=20
> >=20
> > Is there a reason you are not using of_get_flat_dt_prop() instead of
> > implementing your own version?
>=20
> Yes.  One is in the kernel, one isn't.  Or, are you asking why I didn't
> just copy the kernel code?  If so, I probably should have.
>=20
> Hrm, we almost need a library of code shared between the kernel &
> the bootwrapper.  Sort of illegal but it would save duplicating code
> like the flat dt code.
>=20
> Comments?

Yeah we do. And it's not illegal IMHO as two of our boot wrappers
(prom_init and the iSeries one) are linked with the kernel anyway.

I think you should write it ;)

cheers

--=20
Michael Ellerman
IBM OzLabs

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-qIdlaBzV8WsbRDMSnwSV
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEbRYVdSjSd0sB4dIRAiTHAKCducvXsFHjsyGzUyiAlx2SKoG2OgCdEnCH
LH/OFCiO2gNipl0st2Zn/nM=
=MVCR
-----END PGP SIGNATURE-----

--=-qIdlaBzV8WsbRDMSnwSV--
