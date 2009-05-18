Return-Path: <wsa@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id BD72FDE064
	for <linuxppc-dev@ozlabs.org>; Mon, 18 May 2009 21:05:08 +1000 (EST)
Date: Mon, 18 May 2009 13:04:49 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: Esben Haabendal <esbenhaabendal@gmail.com>
Subject: Re: [PATCH] i2c-mpc: generate START condition after STOP caused by
	read i2c_msg
Message-ID: <20090518110449.GB812@pengutronix.de>
References: <4A0BD1DB.4090305@doredevelopment.dk>
	<20090514083453.GB3043@pengutronix.de>
	<4A0BDAD6.5020005@doredevelopment.dk>
	<OF9EE5E055.DDB954D2-ONC12575B6.003636EC-C12575B6.0036CB06@transmode.se>
	<d2b9ea600905140317u7a4b9a70s574568d79a1ce7cc@mail.gmail.com>
	<OF3CD158BA.04CCFBB5-ONC12575B6.005911D5-C12575B6.005CAFC2@transmode.se>
	<d2b9ea600905150318s69b86b5ct3816b274bf343a79@mail.gmail.com>
	<OFCADC684E.A2599121-ONC12575B7.003B8AB5-C12575B7.003CF795@transmode.se>
	<d2b9ea600905150552u6951a92es5dd119dcc37e641d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KFztAG8eRSV9hGtP"
In-Reply-To: <d2b9ea600905150552u6951a92es5dd119dcc37e641d@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, linux-i2c@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--KFztAG8eRSV9hGtP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Could we go forward with my initial patch, and then continue the work
> on this repeated START approach for future releases?

Then could you please send another version of your patch with the CodingSty=
le
issue removed and an updated description what this patch fixes and what sti=
ll
needs to be resolved?

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--KFztAG8eRSV9hGtP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkoRQNEACgkQD27XaX1/VRs2mwCfb+jtW2eqxoukpI/2Ic9PiaSy
r5MAniPKpdOqvYfoZ+inYXbUvI68QtGl
=PdJ5
-----END PGP SIGNATURE-----

--KFztAG8eRSV9hGtP--
