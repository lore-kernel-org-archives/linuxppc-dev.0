Return-Path: <wsa@the-dreams.de>
Received: from pokefinder.org (sauhun.de [89.238.76.85])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CBF411A0021
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  9 Aug 2015 02:49:25 +1000 (AEST)
Date: Sat, 8 Aug 2015 18:49:06 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Vladimir Zapolskiy <vz@mleia.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Maxime Ripard <maxime.ripard@free-electrons.com>,
 Jean Delvare <jdelvare@suse.com>, Ian Munsie <imunsie@au1.ibm.com>,
 Michael Neuling <mikey@neuling.org>, Arnd Bergmann <arnd@arndb.de>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] misc: remove boundary checks from bin attr users
Message-ID: <20150808164906.GA1528@katana>
References: <1437945502-27944-1-git-send-email-vz@mleia.com>
 <20150807161055.GD25357@katana> <55C4D9B2.3000708@mleia.com>
 <20150807223456.GA1527@katana> <55C5FB6A.5010300@mleia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
In-Reply-To: <55C5FB6A.5010300@mleia.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 08, 2015 at 03:51:54PM +0300, Vladimir Zapolskiy wrote:
> Hi Wolfram,
>=20
> On 08.08.2015 01:34, Wolfram Sang wrote:
> >=20
> >> if we're talking about this particular series, you should have them in
> >> your mailbox, since you have them applied in wsa/i2c/for-next:
> >=20
> > Those are already in linus tree. I mean all drivers which use struct
> > i2c_driver. Or do you prefer they go via Greg? I am fine with both.
> >=20
>=20
> I think you may find most of the changes applied by Greg into
> misc/char-misc-next branch.

Great, thanks for the heads up!


--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVxjMCAAoJEBQN5MwUoCm2k7oP/iApUSry8gJWINI2FWr1PvEr
k87oay3i4lkL7BZiYp2TJNtjMS7xT6hDsnIfo/nrZlauRP7ayqw4cyypeqEklj2D
BuAXQvSY99MgECR8s/NE3mWamBPPzpGBRP7TvIQhVS5XKspvfapc1eWt+wfD5Dol
X2HOtLCC+5yZV4oywc0rbL8u0VJ/DvG9RNEMenEdDLsfmMQkVMJTjR14mT+CtE8b
1dm9qJtiWZJu3w2KZj61tiQbQ8Yv6qCW55oVt0WKLG5oCm2Yb5oGha6R5i8VZJ/N
79k5iabgwryf1BFk5Fr4IiY5k43Apx1zrba1T5JPX7RaFrq1xJyG5SnELj/RZ7fY
IrRg9W/nrbw0XZNwqyHCIqtgSmw1Ev3Rt2l5lr39sHU4ov1lC+Ok4EbrJbPGVB3j
MKbGysBJ97h3rfQSIMI2CduDAwF2Ccz7pIfWOxE+RU9ioIe8V2RIEFLEOJtv0Ppw
QGXm+I4ONdgFx8KndClZJoe9hR5XHWRC8AeJqIzsxxC4Y+FDOykJTUdJTXuupWNZ
snykg6srf0e+tzhjWx4GQY6iGXpypb33fK0dhw+NkJUtO1i9Wusb/HhihhAQpwVS
hzdjHi1Rkz5DtcuqB+VCK0kKNulACR55tykUmrH//2t4lx8sf8VrmdBWkFsUfpGD
C8qzS/6IDZXx+FhRFpkL
=deHO
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--
