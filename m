Return-Path: <joerg@dorchain.net>
Received: from Redstar.dorchain.net (153-133-088-212.ip-addr.teresto.net
	[212.88.133.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A054367A46
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Jan 2005 03:42:34 +1100 (EST)
Date: Thu, 27 Jan 2005 17:36:06 +0100
From: Joerg Dorchain <joerg@dorchain.net>
To: Nico Schottelius <nico-linux-ppc@schottelius.org>
Message-ID: <20050127163606.GN14866@Redstar.dorchain.net>
References: <20050118094216.GB25470@Redstar.dorchain.net>
	<20050126113554.GD19633@schottelius.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DXTueXWT3Da08pik"
In-Reply-To: <20050126113554.GD19633@schottelius.org>
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


--DXTueXWT3Da08pik
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 26, 2005 at 12:35:54PM +0100, Nico Schottelius wrote:
> Joerg Dorchain [Tue, Jan 18, 2005 at 10:42:16AM +0100]:
> > [heartbeat blink patch]
>=20
> Well, wouldn't it make much more sense to write a
> /dev/frontled to access it via userspace?=20

Well, only some hardware supports something that can be used as a HB
LED, so IMHO yet another (misc-) device node is not completely
justified.

Then again, the current implemenation was more or less directly copied
=66rom arch/m68k and the pmac IDE driver, my only "own" contribution was
taking the different HZ value into account, and this only in the
simplest possible way.

The original idea behing the m68k HB was to see wether the machine has
crashed so far that even interrupts weren't working any more, which is
sometime very hard to distiguish from very high load (>20). Obiously,
this is best done in kernel space. The load-dependeant blinking
frequency just made it perfect for its original purpose ;-)

I still consider it more a development aid than a real user feature.

Bye,

Joerg

--DXTueXWT3Da08pik
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFB+Rh2jY4+4PdzvOARAijfAKCI0pRqCTyFvvFAlsWHzk4r4rX55gCff3M0
hbdMGPr8AFsCx0VQ2BEo5cs=
=JGjQ
-----END PGP SIGNATURE-----

--DXTueXWT3Da08pik--
