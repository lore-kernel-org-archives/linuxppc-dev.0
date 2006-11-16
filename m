Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH]: wrap cpu_die() with CONFIG_HOTPLUG_CPU
From: Michael Ellerman <michael@ellerman.id.au>
To: Linas Vepstas <linas@austin.ibm.com>
In-Reply-To: <20061116214114.GE23600@austin.ibm.com>
References: <20061115185743.GH8395@austin.ibm.com>
	<1163635125.8805.6.camel@localhost.localdomain>
	<20061116214114.GE23600@austin.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-xfHbI4QB9yBhOasNPYdT"
Date: Fri, 17 Nov 2006 09:34:57 +1100
Message-Id: <1163716498.16815.3.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Srinivasa Ds <srinivasa@in.ibm.com>,
	Nathan Lynch <ntl@pobox.com>, paulus@samba.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-xfHbI4QB9yBhOasNPYdT
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-11-16 at 15:41 -0600, Linas Vepstas wrote:
> Paul,
>=20
> Please apply; this is an updated patch per Michael Ellerman,
> below.
>=20
> --linas
>=20
> On Thu, Nov 16, 2006 at 10:58:45AM +1100, Michael Ellerman wrote:
> >=20
> > Thanks for writing it up as a patch. Couple of nit-picky comments below=
:
>=20
> Nitpicking's OK.
>=20
> >   +#else
> >    #define pSeries_mach_cpu_die NULL
> > > +#endif
> >=20
> > Not sure if that's a good idea, it would save the #ifdef around the
> > structure assignment below.
>=20
> Hmm. Personally, I find the #ifdef in the structure to be more=20
> readable, in the sense that one is less likely to mis-read what
> the code is actually doing, when on is skimming quickly. But,
> not worth arguing over. The patch below incorporates your=20
> suggestions.

Yeah, it's a trade off, I'm not 100% sure it's a good idea - but we'll
see what others think :)

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-xfHbI4QB9yBhOasNPYdT
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBFXOeQdSjSd0sB4dIRAqr9AJ0TYKfl0Uw4v4ThL6eYKtMrlYqeVwCfRZke
5XJWq9JsodX3X4PT3WnaIHU=
=B4/p
-----END PGP SIGNATURE-----

--=-xfHbI4QB9yBhOasNPYdT--
