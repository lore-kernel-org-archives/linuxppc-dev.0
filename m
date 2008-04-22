Return-Path: <michael@ellerman.id.au>
Subject: Re: Question on MPC83xx interrupts
From: Michael Ellerman <michael@ellerman.id.au>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20080422172306.GA17992@ld0162-tx32.am.freescale.net>
References: <480E1939.6000701@matrix-vision.de>
	<20080422172306.GA17992@ld0162-tx32.am.freescale.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-9pUXeY62eYJCAzUHmoa/"
Date: Wed, 23 Apr 2008 08:57:11 +1000
Message-Id: <1208905031.6947.0.camel@concordia>
Mime-Version: 1.0
Cc: Andre Schwarz <andre.schwarz@matrix-vision.de>,
	linux-ppc list <linuxppc-dev@ozlabs.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-9pUXeY62eYJCAzUHmoa/
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2008-04-22 at 12:23 -0500, Scott Wood wrote:
> On Tue, Apr 22, 2008 at 06:58:33PM +0200, Andre Schwarz wrote:
> > I wonder if the IRQ number should match the vector of the datasheet ...=
=20
> > giving :
>=20
> No.  The numbers in /proc/interrupts are virtual IRQ numbers, which are a
> purely Linux-internal construct.

You can see the mapping between virq and hwirq numbers by turning on
CONFIG_VIRQ_DEBUG and looking in /sys/kernel/debug/powerpc/virq_mapping
(after mounting debugfs).

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-9pUXeY62eYJCAzUHmoa/
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBIDm1HdSjSd0sB4dIRAnxqAKCB/UUoHloI9kHTZ+Wf1lMUfs1PwwCggEb/
9JMOKZo1ge2ew/Y0D070+nI=
=dPFH
-----END PGP SIGNATURE-----

--=-9pUXeY62eYJCAzUHmoa/--
