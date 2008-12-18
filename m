Return-Path: <michael@ellerman.id.au>
Subject: Re: Long boot delay on 460EX with 2.6.28-rc8
From: Michael Ellerman <michael@ellerman.id.au>
To: avorontsov@ru.mvista.com
In-Reply-To: <20081218190136.GA7752@oksana.dev.rtsoft.ru>
References: <21070179.post@talk.nabble.com>
	<20081218160256.GA14419@oksana.dev.rtsoft.ru>
	<A53D4E40-E15F-433B-A9DE-9359533C17F8@kernel.crashing.org>
	<20081218190136.GA7752@oksana.dev.rtsoft.ru>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-WSNn9sNrbBRldZuQXk7D"
Date: Fri, 19 Dec 2008 09:57:43 +1100
Message-Id: <1229641063.8584.1.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Felix Radensky <felix@embedded-sol.com>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-WSNn9sNrbBRldZuQXk7D
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2008-12-18 at 22:01 +0300, Anton Vorontsov wrote:
> On Thu, Dec 18, 2008 at 12:51:29PM -0600, Kumar Gala wrote:

> >> I saw somewhat similar behaviour on 83xx target, the cause was
> >> that my .config file contained bogus UDBG_RTAS_CONSOLE=3Dy symbol
> >> (or was it PPC_EARLY_DEBUG_RTAS_PANEL=3Dy? Or HVC_UDBG=3Dy? I don't
> >> quite remember).
> >>
> >> Obviously, on 83xx we don't have RTAS or HVC stuff, but kernel
> >> didn't oops or hang completely, it was busy with executing various
> >> delays in those drivers and then just continued to load.
> >
> > Why are these drivers even doing anything on 83xx?  Seems like they nee=
d=20
> > something to bind against or some detection of "HW".
>=20
> Early console/UDBG is known to cause problems if enabled on
> inappropriate hardware. They start working very early, so it's hard
> for them to do the hw detection (no device tree yet, I presume).

Yes that's the whole point, it's _EARLY_ debug, there's even a big fat
warning in the Kconfig.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-WSNn9sNrbBRldZuQXk7D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAklK1WcACgkQdSjSd0sB4dIkCwCbBI4oqqHc1Q8aPIMPKOZSFEpl
1xoAoIjUv4BkmVkUgKQeXqpEnRYE/idX
=gkWk
-----END PGP SIGNATURE-----

--=-WSNn9sNrbBRldZuQXk7D--
