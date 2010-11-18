Return-Path: <michael@ellerman.id.au>
Subject: Re: [git pull] Please pull powerpc.git merge branch
From: Michael Ellerman <michael@ellerman.id.au>
To: Michael Neuling <mikey@neuling.org>
In-Reply-To: <30983.1290116555@neuling.org>
References: <1290059208.32570.3.camel@pasglop> <30983.1290116555@neuling.org>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-f43X5d/ABd7tQ3FJF7iW"
Date: Fri, 19 Nov 2010 09:08:02 +1100
Message-ID: <1290118082.29105.11.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-f43X5d/ABd7tQ3FJF7iW
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2010-11-19 at 08:42 +1100, Michael Neuling wrote:
> > Michael Neuling (1):
> >       powerpc: Fix call to subpage_protection()
>=20
> Well that's annoying...=20
>=20
> Looks like the bottom of my commit got chopped as the oops message has a
> "---" in it.  We lost the cc: stable@kernel.org :-(
>=20
> Comparing the original post to the final commit:
>   http://lists.ozlabs.org/pipermail/linuxppc-dev/2010-November/087141.htm=
l
> To the final:
>   http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3D=
commitdiff;h=3D1c2c25c78740b2796c7c06640784cb6732fa4907

LOL.

> It'd be nice if we had something like this in:

> powerpc: fix debug prints to avoid ---
>=20
> Many commit tools assume anything below a line starting with --- is a
> comment. Since the following two prints are often used as debug
> outputs and hence in checkin comments avoid using --- in these
>=20
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> ---
> Let the bike shedding begin!

I vote for:

 -> Exception: 401 (Instruction Access) at 00000000f7937794

Because exceptions are like an arrow!


--=-f43X5d/ABd7tQ3FJF7iW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkzlo8IACgkQdSjSd0sB4dJztgCdG9QjOKIZOJVA/sNA+QzD3iaJ
KVcAoMYmf+/Ah9AQVcjA58qR7ehET9ZO
=RSsv
-----END PGP SIGNATURE-----

--=-f43X5d/ABd7tQ3FJF7iW--
