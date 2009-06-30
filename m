Return-Path: <michael@ellerman.id.au>
Subject: Re: Can't boot 2.6.30 powerpc kernel under qemu.
From: Michael Ellerman <michael@ellerman.id.au>
To: Rob Landley <rob@landley.net>
In-Reply-To: <200906291834.07902.rob@landley.net>
References: <200906281033.09842.jk@ozlabs.org>
	<200906291834.07902.rob@landley.net>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-09JIW95yaypzlhlHwAmq"
Date: Tue, 30 Jun 2009 10:24:38 +1000
Message-Id: <1246321478.4621.11.camel@concordia>
Mime-Version: 1.0
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc-dev@lists.ozlabs.org,
	Jeremy Kerr <jk@ozlabs.org>, linux-kernel@vger.kernel.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-09JIW95yaypzlhlHwAmq
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2009-06-29 at 18:34 -0500, Rob Landley wrote:
> Which suggested that the problem was the new CONFIG_PPC_OF_BOOT_TRAMPOLIN=
E=20
> symbol wasn't set, and once I switched that on it started working again.

What defconfig are you using? It sounds like maybe something should be
'select'ing OF_BOOT_TRAMPOLINE.


> > linuxppc-dev@lists.ozlabs.org is the one you want for this:
> >
> >  https://lists.ozlabs.org/listinfo/linuxppc-dev
>=20
> Cool!  Is there a reason it's hidden?  (Or at least not listed in either=20
> vger.kernel.org's list info page or in the "Maling lists" page linked fro=
m=20
> ozlabs.org's top level web page.)  Just curious, I couldn't find it when =
I=20
> looked in the obvious (to me) places.

It's not hidden, it's just in the process of moving from ozlabs.org to
lists.ozlabs.org - and it's a bit hard to find in the process. I've
updated the ozlabs.org page to point to it in the meantime.

It's also in maintainers :D

LINUX FOR POWERPC (32-BIT AND 64-BIT)                                      =
                                   =20
P:      Benjamin Herrenschmidt
M:      benh@kernel.crashing.org
P:      Paul Mackerras
M:      paulus@samba.org
W:      http://www.penguinppc.org/
L:      linuxppc-dev@ozlabs.org
T:      git git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git
S:      Supported


cheers

--=-09JIW95yaypzlhlHwAmq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkpJWzwACgkQdSjSd0sB4dIS5ACgt9cW2NcDis8oj/3Jr3JdhLy1
hV4An02xbRKHME4V/dOd2kIc9gY4zWhz
=n1Sd
-----END PGP SIGNATURE-----

--=-09JIW95yaypzlhlHwAmq--
