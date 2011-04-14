Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 2/2] powerpc: Add an ePAPR compliant boot wrapper
From: Michael Ellerman <michael@ellerman.id.au>
To: David Gibson <dwg@au1.ibm.com>
In-Reply-To: <20110414004303.GZ3151@yookeroo>
References: <34e3e03a96888bc8c20013aa65712123ccf94649.1302676893.git.michael@ellerman.id.au>
	<732a8ac3a24023f021908d03bd84b76638f381f1.1302676893.git.michael@ellerman.id.au>
	<20110413130512.GD26874@zod.rchland.ibm.com>
	<20110414004303.GZ3151@yookeroo>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-gGo60PZPPTk9PvfA2qcO"
Date: Thu, 14 Apr 2011 14:25:32 +1000
Message-ID: <1302755132.12513.92.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-gGo60PZPPTk9PvfA2qcO
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2011-04-14 at 10:43 +1000, David Gibson wrote:
> On Wed, Apr 13, 2011 at 09:05:12AM -0400, Josh Boyer wrote:
> > On Wed, Apr 13, 2011 at 04:38:56PM +1000, Michael Ellerman wrote:
> > >+++ b/arch/powerpc/boot/epapr.c
> > >@@ -0,0 +1,69 @@
> > >+/*
> > >+ * Bootwrapper for ePAPR compliant firmwares
> >=20
> > Out of curiosity, do we have a list of the ePAPR compliant firmwares (i=
f
> > any)?
>=20
> The one this has been tested with is a revised (internal, so far)
> version of SLOF.  For the platform that I believe Michael is in the
> middle of upstreaming support for.

Yep.

> > >+#include "ops.h"
> > >+#include "stdio.h"
> > >+#include "planetcore.h"
> > >+#include "dcr.h"
> > >+#include "4xx.h"
> > >+#include "io.h"
> >=20
> > Do you need planetcore, dcr, and 4xx.h included here?  I don't see
> > anything used that would require them.
>=20
> Ah, no.  Leftovers from the files I based this on, I think.

I'll send a new version.

cheers

--=-gGo60PZPPTk9PvfA2qcO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAk2mdzwACgkQdSjSd0sB4dKyYgCfT2w5TWJJ+K1wf4UOP8XNAve2
0TIAnRoAA9I0ZVqfx3g/Eu0lZIqqY1CP
=3Tz1
-----END PGP SIGNATURE-----

--=-gGo60PZPPTk9PvfA2qcO--
