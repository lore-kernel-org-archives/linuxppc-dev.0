Return-Path: <joerg@dorchain.net>
Received: from Redstar.dorchain.net (153-133-088-212.ip-addr.teresto.net
	[212.88.133.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B8D8E67A86
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Mar 2005 18:23:49 +1100 (EST)
Date: Wed, 16 Mar 2005 08:20:16 +0100
From: Joerg Dorchain <joerg@dorchain.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <20050316072016.GJ24841@Redstar.dorchain.net>
References: <1110767622.5787.215.camel@gaston>
	<20050315140329.GA15214@Redstar.dorchain.net>
	<1110929735.24296.38.camel@gaston>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yhze8HlyfmXt1APY"
In-Reply-To: <1110929735.24296.38.camel@gaston>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
Subject: Re: Newer laptops & CPU speed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--yhze8HlyfmXt1APY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 16, 2005 at 10:35:35AM +1100, Benjamin Herrenschmidt wrote:
> > My ibook G4 boots at low speed. /proc/cpuinfo shows 666MHz and a smiliar
> > bogomips value. Nevertheless, the cpu frequency scaler works, i.e. set
> > it to performance to be at high speed after boot up, or, as I currently
> > do, use the userspace governor and powernowd. All this is without your
> > patch (Did not try it yet, my ibook lacks internet) on linus' 2.6.11.
>=20
> Sure, I already had support for some models :) The patch extends it to
> all present and future models that are MacRISC3 and have a 7447A CPU.

When I remember my usbstick tonight, I'll give it a try.


Bye,

Joerg

--yhze8HlyfmXt1APY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCN94wjY4+4PdzvOARAuovAJ91Eqj3mKfETvfjNKE6aIRKceH4cgCfedYK
GSzyyinOhuc63hcvvYbAmQ0=
=hp2J
-----END PGP SIGNATURE-----

--yhze8HlyfmXt1APY--
