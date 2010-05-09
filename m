Return-Path: <michael@ellerman.id.au>
Subject: Re: [Bug #15589] 2.6.34-rc1: Badness at fs/proc/generic.c:316
From: Michael Ellerman <michael@ellerman.id.au>
To: Christian Kujau <lists@nerdbynature.de>
In-Reply-To: <alpine.DEB.2.01.1005091519130.3067@bogon.housecafe.de>
References: <10aqDnTJcLO.A.mLE.48y5LB@chimera>
	<HqroMXsT-CJ.A.DnG.m_y5LB@chimera>
	<alpine.DEB.2.01.1005091519130.3067@bogon.housecafe.de>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-Cx+W6AuJMtKF04V8Q+IB"
Date: Mon, 10 May 2010 09:34:42 +1000
Message-ID: <1273448082.1431.1.camel@concordia>
Mime-Version: 1.0
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, linuxppc-dev@ozlabs.org,
	schwab@linux-m68k.org,
	Kernel Testers List <kernel-testers@vger.kernel.org>,
	adobriyan@gmail.com, Maciej Rutecki <maciej.rutecki@gmail.com>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-Cx+W6AuJMtKF04V8Q+IB
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2010-05-09 at 15:27 -0700, Christian Kujau wrote:
> On Sun, 9 May 2010 at 23:17, Rafael J. Wysocki wrote:
> > Bug-Entry	: http://bugzilla.kernel.org/show_bug.cgi?id=3D15589
> > Subject		: 2.6.34-rc1: Badness at fs/proc/generic.c:316
> > Submitter	: Christian Kujau <lists@nerdbynature.de>
> > Date		: 2010-03-13 23:53 (58 days old)
> > Message-ID	: <<alpine.DEB.2.01.1003131544340.5493@bogon.housecafe.de>>
> > References	: http://marc.info/?l=3Dlinux-kernel&m=3D126852442903680&w=
=3D2
>=20
> The bug is still present in -rc6, but Michael Ellerman has a patch[0]=20
> which made the warning go away.
>=20
> @Michael: will you post your patch with a Sign-Off, so that it can be=20
>           pushed into mainline?

No, Benh and I decided it's better to just drop those properties all
together. But it's too late in this cycle for a patch like that just to
fix a warning - so we'll do that patch for 35.

cheers

--=-Cx+W6AuJMtKF04V8Q+IB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkvnRo8ACgkQdSjSd0sB4dJLUACcDOW1oY8pgDWviiKGYNWTrwBe
SbEAn0P0EwEVSV6wG6nfN044aNwlDxI6
=npWM
-----END PGP SIGNATURE-----

--=-Cx+W6AuJMtKF04V8Q+IB--
