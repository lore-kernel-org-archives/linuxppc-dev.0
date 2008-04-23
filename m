Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id 4A361DE128
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Apr 2008 22:12:43 +1000 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] rtc-pcf8563: Add device ids table
Date: Wed, 23 Apr 2008 14:12:37 +0200
References: <200804171708.32847.laurentp@cse-semaphore.com>
	<200804221612.06745.laurentp@cse-semaphore.com>
	<20080423131657.71d6312f@hyperion.delvare>
In-Reply-To: <20080423131657.71d6312f@hyperion.delvare>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2593632.KDYGHpOAHl";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200804231412.40038.laurentp@cse-semaphore.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Alessandro Zummo <alessandro.zummo@towertech.it>,
	rtc-linux@googlegroups.com, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart2593632.KDYGHpOAHl
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Jean,

On Wednesday 23 April 2008 13:16, Jean Delvare wrote:
> Hi Laurent,
>=20
> On Tue, 22 Apr 2008 16:11:56 +0200, Laurent Pinchart wrote:
> > Hi Jean,
> >=20
> > On Saturday 19 April 2008 18:43, Jochen Friedrich wrote:
> > > Jean Delvare wrote:
> > > > I'm not sure. I didn't have the time to look at it myself, but I am
> > > > under the impression that the powerpc folks are tired of having to
> > > > wait for me and may push it to Linus through their tree? That would=
 be
> > > > fine with me, as I don't want to be the one delaying something many
> > > > developers want (but I also can't sign patches I've not even read.)
>=20
> I still don't know exactly what happened there... I think I saw some
> "OpenFirmware i2c" patches go upstream yesterday? But not the ones
> listed below, which I thought they depended upon.

The code that went upstream introduces helper functions to create i2c devic=
es=20
from information supplied by the OF device tree. It doesn't strictly depend=
=20
on the below patches, but the new devices won't be properly bound to a driv=
er=20
without them.

> > > The required patches are:
> > >=20
> > > http://patchwork.ozlabs.org/linuxppc/patch?id=3D17833
> > > http://patchwork.ozlabs.org/linuxppc/patch?id=3D17834
> > >=20
> > > which are just the forward ported patches you sent to the poweprc
> > > mailing list some time ago:=20
> > >=20
> > > http://patchwork.ozlabs.org/linuxppc/patch?id=3D16282
> > > http://patchwork.ozlabs.org/linuxppc/patch?id=3D16283
> >=20
> > Given that the required patches are just forward-ported versions of
> > patches you sent (and thus probably reviewed as well :-)), what's the b=
est
> > way to get them in 2.6.26 (if at all possible) ?
>=20
> It's not that easy. A lot of new new-style i2c drivers have shown up in
> the kernel since I wrote my patches (themselves derived heavily from
> Jon Smirl's). Even if Jochen's patches are based on mine, we still need
> to take a careful look on how each driver is modified, I remember for
> example that some v4l drivers were using the original new-style driver
> binding in a way I did not expect. So I can't just sign these patches
> and hope they didn't break anything. It needs care, and this requires
> time.

I won't ask to merge the patches for 2.6.26-rc1 and fix introduced breakage=
s=20
afterwards, I know how you would react to that :-)

> I will do my best to get this done before the 2.6.26 merge window
> closes, but I can't promise anything.

Nobody will get angry if you can't merge them in time for 2.6.26. But many=
=20
people will be happy if you can :-)

Cheers,

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart2593632.KDYGHpOAHl
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBIDye38y9gWxC9vpcRAlIPAJ9pXKWfBM9nF4YR6zKsRA1t4Fj+jgCeIwAk
aiuDqQ8QL4qRvWodWQNZnbU=
=cxKb
-----END PGP SIGNATURE-----

--nextPart2593632.KDYGHpOAHl--
