Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 3/4] powerpc: Reduce differences between pseries and
	ppc64 defconfigs
From: Michael Ellerman <michael@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1260235944.10809.23.camel@pasglop>
References: <20091207034509.GA3421@kryten> <20091207034555.GB3421@kryten>
	<20091207034714.GC3421@kryten>  <1260235641.4668.1.camel@concordia>
	<1260235944.10809.23.camel@pasglop>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-IFKqgXvQoKCTmXBSzNlM"
Date: Tue, 08 Dec 2009 12:34:56 +1100
Message-ID: <1260236096.4668.8.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@samba.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-IFKqgXvQoKCTmXBSzNlM
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2009-12-08 at 12:32 +1100, Benjamin Herrenschmidt wrote:
> On Tue, 2009-12-08 at 12:27 +1100, Michael Ellerman wrote:
> > > The pseries and ppc64 defconfigs have drifted apart over the years.
> > Reduce
> > > some of the differences while still keeping the idea that the ppc64
> > defconfig
> > > is cross platform but enables fewer features than pseries, eg:
> > >=20
> > > - NR_CPUS is lower
> > > - No NUMA support
> >=20
> > Hmm, most of the modern 64 bit platforms are NUMA aren't they? Just a
> > thought.=20
>=20
> Also no NUMA is going to hurt Cell too. I think we should leave that in.

It wasn't in, but maybe we should put it in.

cheers

--=-IFKqgXvQoKCTmXBSzNlM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAksdrT8ACgkQdSjSd0sB4dICQACgkJOzUL/lGxdxdTJ0UtjyWmoP
/I8AoJh02hFVm7E/t6VHiZNt5y9CoBRy
=0bXL
-----END PGP SIGNATURE-----

--=-IFKqgXvQoKCTmXBSzNlM--
