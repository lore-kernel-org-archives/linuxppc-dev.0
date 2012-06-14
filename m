Return-Path: <wsa@pengutronix.de>
Received: from metis.ext.pengutronix.de (unknown
 [IPv6:2001:6f8:1178:4:290:27ff:fe1d:cc33])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E82141007D1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jun 2012 19:16:02 +1000 (EST)
Date: Thu, 14 Jun 2012 11:14:34 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] i2c: let the core register devices from devicetree
Message-ID: <20120614091434.GB14419@pengutronix.de>
References: <1339622215-4733-1-git-send-email-w.sang@pengutronix.de>
 <1339623217.9220.119.camel@pasglop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="qcHopEYAB45HaUaB"
In-Reply-To: <1339623217.9220.119.camel@pasglop>
Cc: Viresh Kumar <viresh.kumar@st.com>,
 Mauro Carvalho Chehab <mchehab@redhat.com>, Tony Lindgren <tony@atomide.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Laxman Dewangan <ldewangan@nvidia.com>, linux-i2c@vger.kernel.org,
 Kukjin Kim <kgene.kim@samsung.com>, Stephen Warren <swarren@nvidia.com>,
 Barry Song <21cnbao@gmail.com>, Haojian Zhuang <haojian.zhuang@marvell.com>,
 Deepak Sikri <deepak.sikri@st.com>, Haavard Skinnemoen <hskinnemoen@gmail.com>,
 Dirk Brandewie <dirk.brandewie@gmail.com>, Pawel Moll <pawel.moll@arm.com>,
 Wolfram Sang <wolfram@the-dreams.de>, Sascha Hauer <s.hauer@pengutronix.de>,
 Rusty Russell <rusty@rustcorp.com.au>, Tang Yuantian <B29983@freescale.com>,
 "Jean Delvare \(PC drivers, core\)" <khali@linux-fr.org>,
 Magnus Damm <damm@opensource.se>, Lars-Peter Clausen <lars@metafoo.de>,
 "Ben Dooks \(embedded platforms\)" <ben-linux@fluff.org>,
 linux-arm-kernel@lists.infradead.org, Jiri Kosina <jkosina@suse.cz>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Karol Lewandowski <k.lewandowsk@samsung.com>, Olof Johansson <olof@lixom.net>,
 Shawn Guo <shawn.guo@linaro.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--qcHopEYAB45HaUaB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 14, 2012 at 07:33:37AM +1000, Benjamin Herrenschmidt wrote:
> On Wed, 2012-06-13 at 23:12 +0200, Wolfram Sang wrote:
> > Currently, every driver has to do it on its own, but it should be done
> > in the core, like we already do with board_info structs.
> >=20
> > Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> > ---
> >=20
> > Based on v3.5-rc2. Only build tested, I don't have a OF based device
> > around at the moment.
>=20
> Won't that conflict with i2c-powermac doing it its own way ?

Yup :(

I assume there is no chance that the powermac devicetree can be
pre-processed to be compatible with of_i2c_register_devices?

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--qcHopEYAB45HaUaB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk/Zq3oACgkQD27XaX1/VRv+1QCfeFPejEo4HNanYfhXKfVjPDAs
rnoAnRvrHlrKO9ewLnvUbB2adb+qwIQJ
=rBSj
-----END PGP SIGNATURE-----

--qcHopEYAB45HaUaB--
