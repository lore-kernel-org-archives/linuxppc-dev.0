Date: Mon, 8 Jan 2001 05:15:34 -0900
From: Ethan Benson <erbenson@alaska.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: status of ppc support in official 2.4.0 or Alan's 2.4.0-ac1
Message-ID: <20010108051534.C29805@plato.local.lan>
References: <200101070559.XAA14527@lists.linuxppc.org> <Pine.SOL.3.95.1010108140927.12092B-100000@juliet>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ne2Pfivg4jz0YhPf"
In-Reply-To: <Pine.SOL.3.95.1010108140927.12092B-100000@juliet>; from supas100@astrophysik.uni-kiel.de on Mon, Jan 08, 2001 at 02:35:23PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--ne2Pfivg4jz0YhPf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 08, 2001 at 02:35:23PM +0100, Derek Homeier wrote:

> I can't get a ppp connection under 2.4.0 either (didn't work with any of
> the -test kernels). The connection itself seems to be established correct=
ly,
> but then pppd or chat have problems with the terminal type:
>=20
> Jan  7 22:26:35 miranda kernel: CSLIP: code copyright 1989 Regents of the=
 University of California
> Jan  7 22:26:35 miranda kernel: PPP generic driver version 2.4.1
> Jan  7 22:26:35 miranda pppd[834]: pppd 2.3.10 started by derek, uid 2300
                                     ^^^^^^^^^^^^

you need version 2.4.0 of the userspace ppp daemon to work with 2.4 kernels.

see linux/Documentation/Changes

--=20
Ethan Benson
http://www.alaska.net/~erbenson/

--ne2Pfivg4jz0YhPf
Content-Type: application/pgp-signature
Content-Disposition: inline


--ne2Pfivg4jz0YhPf--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
