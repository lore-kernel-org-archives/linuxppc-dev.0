Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] of/flattree: use callback to setup initrd from /chosen
From: Michael Ellerman <michael@ellerman.id.au>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <fa686aa41001122243v31e25e9et5db40b4f7ea8a56f@mail.gmail.com>
References: <1261474791.289871.854376051633.1.gpush@pororo>
	<1261478868.10767.2.camel@concordia>
	<200912221854.37572.jeremy.kerr@canonical.com>
	<1261487856.10767.128.camel@concordia>
	<fa686aa41001122243v31e25e9et5db40b4f7ea8a56f@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-G5XRvwZJPwBX0IhRML4f"
Date: Wed, 13 Jan 2010 22:03:42 +1100
Message-ID: <1263380622.3378.6.camel@concordia>
Mime-Version: 1.0
Cc: microblaze-uclinux@itee.uq.edu.au, Jeremy Kerr <jeremy.kerr@canonical.com>,
	linuxppc-dev@lists.ozlabs.org, devicetree-discuss@lists.ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-G5XRvwZJPwBX0IhRML4f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2010-01-12 at 23:43 -0700, Grant Likely wrote:
> On Tue, Dec 22, 2009 at 6:17 AM, Michael Ellerman
> <michael@ellerman.id.au> wrote:
> > On Tue, 2009-12-22 at 18:54 +0800, Jeremy Kerr wrote:
> >> Hi Michael,
> >>
> >> > >  void early_init_dt_setup_initrd_arch(unsigned long start,
> >> > >                                 unsigned long end);
> >> >
> >> > arch_early_init_dt_setup_initrd() makes more sense to me, but ..
> >>
> >> <foo>_arch has been the general convention for arch-specific hooks in
> >> drivers/of/.
> >
> > Yuck, doh, guess I should have read those patches before they went in :=
)
>=20
> It's not necessarily permanent.  My first goal is to get the common
> code merged.  Then I want to look closely at it for patterns and
> refactor how the common code calls out to arch specific hooks (or
> maybe turn it around and have arch code calling out to the common
> bits).

Sure, no biggy. There is lots of precedent for arch hooks to be called
arch_foo() or topic_arch_foo(), but it's not the end of the world.

cheers



--=-G5XRvwZJPwBX0IhRML4f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAktNqIYACgkQdSjSd0sB4dLvZACgzK9+iLOC/pomCcO+Bbmu6IwD
X5QAoLD7Q/a3ukEAmE5eUuTGwcDfcfKr
=Pc6/
-----END PGP SIGNATURE-----

--=-G5XRvwZJPwBX0IhRML4f--
