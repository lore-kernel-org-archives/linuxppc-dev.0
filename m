Return-Path: <nico-linux-ppc@schottelius.org>
Received: from scice.schottelius.org (ns.schottelius.org [213.146.113.242])
	by ozlabs.org (Postfix) with SMTP id A0FCC67A7A
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Feb 2005 18:55:18 +1100 (EST)
Date: Tue, 8 Feb 2005 08:54:21 +0100
From: Nico Schottelius <nico-linux-ppc@schottelius.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Joerg Dorchain <joerg@dorchain.net>
Message-ID: <20050208075421.GB21154@schottelius.org>
References: <20050118094216.GB25470@Redstar.dorchain.net>
	<20050126113554.GD19633@schottelius.org>
	<20050127163606.GN14866@Redstar.dorchain.net>
	<20050118094216.GB25470@Redstar.dorchain.net>
	<20050126113554.GD19633@schottelius.org>
	<1106746946.6250.56.camel@gaston>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wq9mPyueHGvFACwf"
In-Reply-To: <20050127163606.GN14866@Redstar.dorchain.net>
	<1106746946.6250.56.camel@gaston>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH] Heartbeat LED for iBook
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--wq9mPyueHGvFACwf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Good morning!

Benjamin Herrenschmidt [Thu, Jan 27, 2005 at 12:42:26AM +1100]:
> One can always control the led by sending PMU command directly
> via /dev/adb :) Ok, that sort-of sucks, especially since the command is
> only supported by some versions of the PMU. On the other hand, I dislike
> cluttering /dev ... maybe I can find some better mecanism via sysfs...

Well, if /dev would fit best, imho, as it represents a device.
And I don't think 'not having enough major/minor numbers' is an argument
not to implement something. We have udev (and before devfs), which=20
should clear the old problem.

Btw, howto control it via /dev/adb? Can you point me to a document
which explains that?

Joerg Dorchain [Thu, Jan 27, 2005 at 05:36:06PM +0100]:
> On Wed, Jan 26, 2005 at 12:35:54PM +0100, Nico Schottelius wrote:
> > Joerg Dorchain [Tue, Jan 18, 2005 at 10:42:16AM +0100]:
> > > [heartbeat blink patch]
> >=20
> > Well, wouldn't it make much more sense to write a
> > /dev/frontled to access it via userspace?=20
>=20
> Well, only some hardware supports something that can be used as a HB
> LED, so IMHO yet another (misc-) device node is not completely
> justified.

Imho it would be a nice feature, for testing and for fun.

If someone gives me some pointers on howto do that, I would try to
write a driver/interface to it.

Nico

--=20
Keep it simple & stupid, use what's available.
Please use pgp encryption: 8D0E 27A4 is my id.
http://nico.schotteli.us | http://linux.schottelius.org

--wq9mPyueHGvFACwf
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iQIVAwUBQghwK7OTBMvCUbrlAQL55RAAnmBhXDUowx0YFlo11GLqBGFiu/qyG7of
9yTSbXqtFTF+adp/6bRmwl7VCHr/RgsSyAh6ESzxZq3aMBMUqRy8U59zR1I2mrb8
H5CbpuZVw6zwXHnYHvDN2PKpMwnp4ICqFDuDKKpLGzyHA8fkXqcQ9TmZpLjXmnDw
NlHmz3veb7Fk6AnhX+L1E66fnLXRrvTASk7pgAPchcnhhVZjFEs6KxaqbD78/8KU
kJoPo1wQg00iDLVu3vyIKdBqCIZmFQiOjn35SWm4TnIgzr0mkCYT/ECidWU2hzvX
WuslAv1US8YU/xo+qA2ZS+RGbiCxoiUez3JAKEMZyuyqs7+ukn2srF+nlUaj3FQv
TyQQe6pCss5z7exKq8t6bMY03vSRPUzuWcjAYf8JD/0WAd4nrXujIYYiwZ2sZlZ6
MvLr/hXJEw3epsqcqg6FpXLLhyv/0wyebu7I+jDJnM4C+XYNbRTJKmIZEj41aSev
WPl/DMeFNrqCTsOCunaUiL63Xf02LFw1APLn4unu2OzEmBMxp/bwhqvm8p5QvziE
1OX6FehgNaK6MKBl9R8hyvMiwWZSgL02majKTEwqSSyCnbRU92aI6MZhHBm68LWh
uHOLlEhS/juFpdTXOHDyeBMPUrR1koFLWnQpX49H/8GYvNrH6mNrTc+y+AEFvZEI
C8aeCnF8i88=
=jS33
-----END PGP SIGNATURE-----

--wq9mPyueHGvFACwf--
