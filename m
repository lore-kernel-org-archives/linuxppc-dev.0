Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id 956E7DE0F2
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Apr 2008 21:56:13 +1000 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: Jochen Friedrich <jochen@scram.de>
Subject: Re: [PATCH] rtc-pcf8563: Add device ids table
Date: Mon, 21 Apr 2008 13:56:09 +0200
References: <200804171708.32847.laurentp@cse-semaphore.com>
	<20080419162358.746b714c@hyperion.delvare>
	<480A2117.7020502@scram.de>
In-Reply-To: <480A2117.7020502@scram.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1693107.9xNIqqW0Io";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200804211356.10192.laurentp@cse-semaphore.com>
Cc: Jean Delvare <khali@linux-fr.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Alessandro Zummo <alessandro.zummo@towertech.it>,
	i2c@lm-sensors.org, rtc-linux@googlegroups.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart1693107.9xNIqqW0Io
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Saturday 19 April 2008 18:43, Jochen Friedrich wrote:
> Jean Delvare wrote:
> > On Sat, 19 Apr 2008 15:09:55 +0200, Jochen Friedrich wrote:
> > > Hi Jean,
> > >
> > > > > > Is the new-style driver conversion patch in 2.6.25-rc8-mm2
> > > > > > scheduled for 2.6.26 ?
> > > > >  hope so! :)
> > > > Note that this patch depends on i2c patches which aren't upstream y=
et.
> > > Is there any chance they will got to 2.6.26?
> >=20
> > I'm not sure. I didn't have the time to look at it myself, but I am
> > under the impression that the powerpc folks are tired of having to wait
> > for me and may push it to Linus through their tree? That would be fine
> > with me, as I don't want to be the one delaying something many
> > developers want (but I also can't sign patches I've not even read.)

The patches are required for long awaited I2C support on various PowerPC=20
boards. As the ppc architecture support is going away in 2.6.27, it would b=
e=20
nice to have them applied in 2.6.26.

> The required patches are:
>=20
> http://patchwork.ozlabs.org/linuxppc/patch?id=3D17833
> http://patchwork.ozlabs.org/linuxppc/patch?id=3D17834
>=20
> which are just the forward ported patches you sent to the poweprc mailing
> list some time ago:=20
>=20
> http://patchwork.ozlabs.org/linuxppc/patch?id=3D16282
> http://patchwork.ozlabs.org/linuxppc/patch?id=3D16283
>=20
> Thanks,
> Jochen

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart1693107.9xNIqqW0Io
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBIDIDa8y9gWxC9vpcRAsmuAKDHl9S60v+HwQXs/KsowljmpGGHdwCgrCTQ
IDZTZLv+cL8zSTGJTwwdhJk=
=wwEJ
-----END PGP SIGNATURE-----

--nextPart1693107.9xNIqqW0Io--
