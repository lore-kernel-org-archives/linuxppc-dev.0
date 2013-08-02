Return-Path: <ben@decadent.org.uk>
Received: from shadbolt.e.decadent.org.uk (shadbolt.e.decadent.org.uk
 [88.96.1.126])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id F35552C0082
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Aug 2013 07:21:20 +1000 (EST)
Message-ID: <1375477013.32254.22.camel@deadeye.wl.decadent.org.uk>
Subject: Re: therm_pm72 units, interface
From: Ben Hutchings <ben@decadent.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 02 Aug 2013 22:56:53 +0200
In-Reply-To: <1375476455.15999.13.camel@pasglop>
References: <alpine.LNX.2.01.1208151941010.22695@frira.zrqbmnf.qr>
 <1345066616.11751.2.camel@pasglop>
 <alpine.LNX.2.01.1301142240140.30171@nerf07.vanv.qr>
 <1358465885.2782.24.camel@pasglop>
 <20130719174300.GL14385@blackmetal.musicnaut.iki.fi>
 <1374275809.19894.562.camel@pasglop>
 <20130720203346.GM14385@blackmetal.musicnaut.iki.fi>
 <1375437816.3852.12.camel@thor.local> <1375447861.15999.1.camel@pasglop>
 <1375454871.3852.27.camel@thor.local> <1375476455.15999.13.camel@pasglop>
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-tD2ODdJPOvHhPrbeYxqt"
Mime-Version: 1.0
Cc: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Jan Engelhardt <jengelh@inai.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-tD2ODdJPOvHhPrbeYxqt
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2013-08-03 at 06:47 +1000, Benjamin Herrenschmidt wrote:
> On Fri, 2013-08-02 at 16:47 +0200, Michel D=C3=A4nzer wrote:
> > On Fre, 2013-08-02 at 22:51 +1000, Benjamin Herrenschmidt wrote:
> > > On Fri, 2013-08-02 at 12:03 +0200, Michel D=C3=A4nzer wrote:
> > > > Could a similar change fix the same problem on desktop G5s? The sam=
e
> > > > values for slots_param in windfarm_pm112.c don't help, unfortunatel=
y.
> > >=20
> > > You have a 11,2 and a noisy fan ? Odd, mine(s) don't.... I can dbl ch=
eck
> > > the values vs. what Darwin uses tomorrow...
> >=20
> > Yes, see /proc/cpuinfo below.
> >=20
> > With older kernels (currently still using Debian's 3.2.0-4-powerpc64
> > because of this problem), the fans go basically silent as soon as the
> > windfarm modules are loaded. With current kernels, the fans stay at the
> > level OF sets them to, until after a while they go into 'airplane mode'=
.
> >=20
> > One thing I notice now is that the lines like
> >=20
> > [    9.539173] windfarm: CPUs control loops started.
> > [   16.209962] windfarm: Backside control loop started.
> > [   16.262274] windfarm: Slots control loop started.
> > [   16.371642] windfarm: Drive bay control loop started.
> >=20
> > no longer appear in dmesg with current kernels. Should they?
>=20
> Yes. Do you have all the windfarm modules loaded ? What about
> i2c-powermac ? (It's typical that the latter is missed, I think it
> doesn't auto-load, which we never fixed, we used to request distros to
> just built it in)

We built it as a module in 3.2 and we still do.  The regression
apparently occurred between 3.8 and 3.9.

Ben.

--=20
Ben Hutchings
This sentence contradicts itself - no actually it doesn't.

--=-tD2ODdJPOvHhPrbeYxqt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIVAwUAUfwdFee/yOyVhhEJAQoRBA/+KwNwuweb3tvhrR8Dc+pJ451QgKe9PFgw
qfYH+mO+ZPbaU4xR7LrhW0UE9zNfyvOn6aBRlMul4I8USDng2mFSZOGF+D9+ascS
j8IkIA6uLE+MMoh547ZDbP7A28WZjRsf4Kx+u2BqtFx3c5YqrWZ+i/lGcurCKivU
RJ9Y2lbdOF+PazVhscdI3Df95SV1v53d5JQ+DrvcvpshzhkzHkCC7UjOH08TEDjS
PPhF0tBA6j7Q9c8HsB9QENqY5tSgiHSoCAtWHdiIHfP/R3uvzPpoDVlI8qVlxJfV
qB2jtGc4fJfW6GA4nTIbYxZ06sLmKn3aX/qeaeE1hcI5cRdEJ/KN2+aWPOZG6qpc
B1PenvFRgEdf3CSDNuZUbfqRlv1gUSr6qLZIdj0T7IOKHeCQRkSwhZaMKO4yTxLw
buuWWHjLs5cYEPG25HGCv03uzQjxbTM998nBFULsZLpZEi/dL6dO9/YWU3DBXqgI
umIWmoXxleQT2ZaLxhP0Z+iwb/YnHRUUr+pcSi7C5jRPqSuoaXfdEBL7yfnLMJfd
npPgLwzT1z5T0a4ApSckPZvuuX8+0aB6QBdUb7GdchhMb0ddcjUGxLZfUdQus96z
lWHFDnYPa2EUahZpNDg6lAOYZSnXAgd0Q6wkzY2/rijcxRdnlQwFwfd9CA/BBDkF
BExNQqQupX4=
=ldtm
-----END PGP SIGNATURE-----

--=-tD2ODdJPOvHhPrbeYxqt--
