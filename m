Return-Path: <wsa@the-dreams.de>
Received: from pokefinder.org (sauhun.de [89.238.76.85])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s7xl23m4JzDqPn
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 00:39:58 +1000 (AEST)
Date: Tue, 9 Aug 2016 16:39:15 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wolfram Sang <wsa-dev@sang-engineering.com>,
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 adi-buildroot-devel@lists.sourceforge.net,
 linuxppc-dev@lists.ozlabs.org, linux-samsung-soc@vger.kernel.org,
 linux-amlogic@lists.infradead.org, linux-omap@vger.kernel.org,
 linux-rockchip@lists.infradead.org, kernel@stlinux.com,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH] i2c: don't print error when adding adapter fails
Message-ID: <20160809143915.GB1666@katana>
References: <1470742581-12971-1-git-send-email-wsa-dev@sang-engineering.com>
 <1470742581-12971-2-git-send-email-wsa-dev@sang-engineering.com>
 <32d25618-83f6-b876-07b0-adb988516173@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="ftEhullJWpWg/VHq"
In-Reply-To: <32d25618-83f6-b876-07b0-adb988516173@roeck-us.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--ftEhullJWpWg/VHq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> >@@ -550,15 +550,10 @@ static int uniphier_fi2c_probe(struct platform_dev=
ice *pdev)
> > 	}
> >
> > 	ret =3D i2c_add_adapter(&priv->adap);
> >-	if (ret) {
> >-		dev_err(dev, "failed to add I2C adapter\n");
> >-		goto err;
> >-	}
> >-
> >-err:
> > 	if (ret)
> > 		clk_disable_unprepare(priv->clk);
> >
> >+ err:
>=20
> You sure about that one ? It leaves the clock enabled in some of the erro=
r paths.

Uh, ehrm, where is the brown paper bag? Thanks, Guenter!

> Note: I dropped all individuals from Cc:; my mailer refused to accept the=
 reply because there
> were too many.

Yes, the disadvantage of not breaking out.


--ftEhullJWpWg/VHq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXqesTAAoJEBQN5MwUoCm2fdIQAKsMhNBydvOJrt8SvVKc4fd8
39601dtUJkADzbUDKqrQm08buBble9GQe38/YIQXiPO1pRY1RQBmPLbdNTlEWMFW
Rc2RFmg1L469UhoDgrarWvT/VFMPBGOXEVEMe/0HFX+xKXfzWwYtFHvoUBtWVv0a
rmuq47nYitymT9AS2Pul4Jn93hT2iMiIXoqhsEoNC8NiW/JR2okn64C8dUhx+tYv
cjwClAbJwCpd+hBwSYR6CCunZTUUMcpHxjVtgfckNHc6TPBGxwHRVGpye0dd176M
z69gqUsx5ny+iNFeCZzgynfX0U0yzFYjNeyNFm9MuXDGD4cr6qB1PonvkStV4vKu
cxomrG2RjT/36NHlJIbXklT2PSB0QOPjGkS+apvPlQ9eM4u24j+WlXyCtszOr/qP
19wm6SZ+0rvlM56aPgpA935XkdCQJ8KffRTbqHxrXEthtKwhmRR1IFC1zSX7/1a9
dA6AOB2i1fQ+FgZ/0vhmWQr72DvmTnM+T3HLWq/IK9u16j1tHRD2HA8IKDb4yY8W
cVD511wu8qkLta47lkOVbLwxyWDBeLOT0Ekn67y6PvXoPItoFO7ormtLUkvaL7AW
VYPILEWfsj/CAdATGEU2j//OIYakDl66HUp3yM9VxH+39gTboiHV1aFJ8/dfVZuF
OGDTbDBP2wxqJac3m7M3
=0rq4
-----END PGP SIGNATURE-----

--ftEhullJWpWg/VHq--
