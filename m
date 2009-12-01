Return-Path: <michael@ellerman.id.au>
Subject: Re: [RFC PATCH v3 3/3] powerpc: gamecube/wii: early debugging
	using usbgecko
From: Michael Ellerman <michael@ellerman.id.au>
To: Albert Herranz <albert_herranz@yahoo.es>
In-Reply-To: <4B14A834.4070907@yahoo.es>
References: <cover.1259609263.git.albert_herranz@yahoo.es>
	<86935119c483c2d6e4c810c0afd079e049443b18.1259609263.git.albert_herranz@yahoo.es>
	<4B147086.6070602@gmail.com>  <4B14A834.4070907@yahoo.es>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-AT6NzDIIzQK/smN8UQ1X"
Date: Tue, 01 Dec 2009 16:40:11 +1100
Message-ID: <1259646011.4502.4.camel@concordia>
Mime-Version: 1.0
Cc: Richard Holden <aciddeath@gmail.com>, linuxppc-dev@lists.ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-AT6NzDIIzQK/smN8UQ1X
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2009-12-01 at 06:23 +0100, Albert Herranz wrote:
> Richard Holden wrote:
> >> diff --git a/arch/powerpc/platforms/embedded6xx/usbgecko_udbg.c b/arch=
/powerpc/platforms/embedded6xx/usbgecko_udbg.c
> >> index ba4c7cc..3f125b6 100644
> >> --- a/arch/powerpc/platforms/embedded6xx/usbgecko_udbg.c
> >> +++ b/arch/powerpc/platforms/embedded6xx/usbgecko_udbg.c
> >> @@ -17,6 +17,7 @@
> >>  #include <asm/io.h>
> >>  #include <asm/prom.h>
> >>  #include <asm/udbg.h>
> >> +#include <asm/fixmap.h>
> >> =20
> >>  #include "usbgecko_udbg.h"
> >> =20
> >> @@ -270,3 +271,61 @@ done:
> >>  		of_node_put(np);
> >>  	return;
> >>  }
> >> +
> >> +#ifdef CONFIG_PPC_EARLY_DEBUG_USBGECKO
> >> +
> >> +static void __init ug_early_remap(void)
> >=20
> > you may want to rename the ug_ prefix, it took me a while looking back
> > and forth through the patch to convince myself it wasn't a typo.
> >=20
>=20
> What's wrong with ug_ ? (ug =3D (u)sb(g)ecko)

What's wrong with usb_gecko_early_remap() :)

cheers


--=-AT6NzDIIzQK/smN8UQ1X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAksUrDoACgkQdSjSd0sB4dLa8gCfeEUxgcIc4En2fdpzw4+Z6KDk
HRYAoKfRXP8oRSUWGz7HIoKR6jipm0bd
=IlFJ
-----END PGP SIGNATURE-----

--=-AT6NzDIIzQK/smN8UQ1X--
