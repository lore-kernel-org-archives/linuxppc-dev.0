Return-Path: <michael@ellerman.id.au>
Subject: Re: How to add platform specific data to a of_device
From: Michael Ellerman <michael@ellerman.id.au>
To: Robert Schwebel <r.schwebel@pengutronix.de>
In-Reply-To: <20070716065144.GH1678@pengutronix.de>
References: <200707141831.04107.jbe@pengutronix.de>
	<1184446133.6059.284.camel@localhost.localdomain>
	<20070716065144.GH1678@pengutronix.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-8EBB7XAaR9KfAFbmv481"
Date: Mon, 16 Jul 2007 17:40:07 +1000
Message-Id: <1184571607.8391.18.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-8EBB7XAaR9KfAFbmv481
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2007-07-16 at 08:51 +0200, Robert Schwebel wrote:
> On Sun, Jul 15, 2007 at 06:48:53AM +1000, Benjamin Herrenschmidt wrote:
> > Your approach would work I suppose.... though it's a bit ugly.
>=20
> Speaking of uggly, I'm still wondering why this oftree stuff for powerpc
> must be soooo complicated. If you come from the ARM-linux world like we
> do, the whole powerpc BSP stuff looks like a completely overengineered
> piece of code, introducing complexity where it isn't necessary. But it
> may be that it's just me not knowing powerpc kernel requirements deeply
> enough :)

And I don't know anything about ARM, so let's trade uninformed
opinions ... :)

# cd arch/arm
# du -sk kernel/ mach-* | sort -nk 1
16      mach-l7200
16      mach-s3c2400
24      mach-clps7500
24      mach-s3c2442
32      mach-iop33x
32      mach-rpc
32      mach-shark
36      mach-ebsa110
40      mach-aaec2000
48      mach-h720x
48      mach-ks8695
52      mach-iop32x
56      mach-davinci
60      mach-ixp23xx
60      mach-ns9xxx
60      mach-s3c2443
68      mach-clps711x
68      mach-s3c2412
72      mach-netx
72      mach-realview
72      mach-versatile
76      mach-s3c2440
80      mach-ep93xx
80      mach-imx
88      mach-ixp2000
96      mach-iop13xx
96      mach-lh7a40x
108     mach-pnx4008
124     mach-footbridge
124     mach-integrator
140     mach-ixp4xx
140     mach-s3c2410
252     mach-sa1100
272     mach-omap2
296     mach-omap1
296     mach-pxa
332     mach-at91
428     kernel/

# cd arch/powerpc
# du -sk kernel/ sysdev/ platforms/* | sort -nk 1
8       platforms/prep
12      platforms/4xx
24      platforms/44x
40      platforms/82xx
44      platforms/86xx
52      platforms/8xx
52      platforms/embedded6xx
56      platforms/maple
60      platforms/83xx
64      platforms/85xx
64      platforms/chrp
72      platforms/52xx
72      platforms/pasemi
140     platforms/celleb
212     platforms/ps3
280     platforms/iseries
300     platforms/pseries
412     platforms/powermac
412     sysdev/
544     platforms/cell		(spufs shared with ps3 (and celleb?))
1636    kernel/

Not to mention that ~8 of those platforms can be built into a single
vmlinux that will boot on any of the supported machines, including five
different hypervisors.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-8EBB7XAaR9KfAFbmv481
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGmyDXdSjSd0sB4dIRAofwAJsF3RwbwRuXlYIWTdxxrywU+FGghQCgimxi
VX2g8qKDW4Uk7/SND6yyCiU=
=lO0C
-----END PGP SIGNATURE-----

--=-8EBB7XAaR9KfAFbmv481--
