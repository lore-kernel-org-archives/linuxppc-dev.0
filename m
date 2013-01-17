Return-Path: <balbi@ti.com>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mailhost.ti.com",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3DD102C0084
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jan 2013 20:32:21 +1100 (EST)
Date: Thu, 17 Jan 2013 11:32:07 +0200
From: Felipe Balbi <balbi@ti.com>
To: Peter Chen <peter.chen@freescale.com>
Subject: Re: [PATCH v5 1/3] usb: fsl-mxc-udc: replace cpu_is_xxx() with
 platform_device_id
Message-ID: <20130117093207.GG10814@arwen.pp.htv.fi>
References: <1358216975-1404-1-git-send-email-peter.chen@freescale.com>
 <1358216975-1404-2-git-send-email-peter.chen@freescale.com>
 <20130115140344.GB6574@S2101-09.ap.freescale.net>
 <20130116014824.GD16514@nchen-desktop>
 <20130117091422.GF10814@arwen.pp.htv.fi>
 <20130117092829.GA8251@nchen-desktop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="jRdC2OsRnuV8iIl8"
In-Reply-To: <20130117092829.GA8251@nchen-desktop>
Cc: r58472@freescale.com, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 Felipe Balbi <balbi@ti.com>, kernel@pengutronix.de,
 Shawn Guo <shawn.guo@linaro.org>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Reply-To: balbi@ti.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--jRdC2OsRnuV8iIl8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jan 17, 2013 at 05:28:30PM +0800, Peter Chen wrote:

<trimming>

> > > > From what I understand balbi's comment, he dislikes this full list =
of
> > > > device id.  Instead, he prefers to something like below.
> > > >=20
> > > > static const struct platform_device_id fsl_udc_devtype[] =3D {
> > > > 	{
> > > > 		.name =3D "imx-udc-mx27",
> > > > 	}, {
> > > > 		.name =3D "imx-udc-mx51",
> > > > 	}
> > > > };
> > > >=20
> > > > It basically tells that we are handling two type of devices here, o=
ne
> > > > is imx-udc-mx27 type and the other is imx-udc-mx51 type, with mx25/=
31/35
> > > > completely compatible with mx27 type.  We choose mx27 instead of mx=
25
> > > > to define the type because mx27 Si came out earlier than mx25.  That
> > > > said, we generally choose the earlies SoC name to define a particul=
ar
> > > > version of IP block, since hardware version is mostly unavailable or
> > > > unreliable.
> > > >=20
> > > > But that also means in platform code which create the platform_devi=
ce,
> > > > you will need to use name "imx-udc-mx27" for even mx25/31/35.
> > > >=20
> > > > 	imx_fsl_usb2_udc_data_entry_single(MX25, "imx-udc-mx27");
> > > > 	imx_fsl_usb2_udc_data_entry_single(MX31, "imx-udc-mx27");
> > > > 	imx_fsl_usb2_udc_data_entry_single(MX35, "imx-udc-mx27");
> > > >=20
> > > > Considering this is a piece of code we will not use for any new
> > > > hardware, I'm fine with either way.
> > > >=20
> > > > So, balbi, it's all your call to accept the series as it is or ask =
for
> > > > another iteration.
> >=20
> > right :-)
> >=20
> > > Thanks Shawn. Let's see Felipe's comment, nevertheless, I will send v=
6 patch
> > > due to a compile error at mx25
> >=20
> > Shawn is right.
>=20
> In fact, this driver is just the temp solution, we will use chipidea
> in future, so just take all i.mx usb as two kinds of ip are ok.
>=20
> Do you want me to change like Shawn said, or current version is ok?

yes, please resend with changes.

--=20
balbi

--jRdC2OsRnuV8iIl8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQ98UXAAoJEIaOsuA1yqRE/uoQAKa5pyVlYhZ2MCLApNHwbUE9
rgdfxjwHVuXgpSAYEVoIuasF9ss7Payop89c09ZDk/smL+nlNhpeHeB57jyi0wtZ
dACHLwvfC0CJykjcPihR7Jyl40IrWxvtFyORbDdTq+WxtmysRAUWUhuN8s9+6+gT
6On4J+aUBl88ZywpBn4vwXjdzYjw33mcfK2t5iWmfYqonoIPMwwvHNiyJwAbEjV0
0zyBT57oMysvfQsT2X64QQFbYgNb11juNNSMnZdCO1swmokXVu8o3qcjgmDy0PTy
BXLwdCmJuOU3odCIjapJF9BOBEcpPYdgugT8AqpIaUaWl6XhwUGAcfajDVTALsdh
3ujdaelnwX0vBGS5yNlyopG80lDMUi/yaMLOCkkCN3kkx2HYTR+Apz8oOaZCj+9h
yEL4sllJg2EmDKmuyy3wA4e9YRXoK92i3U5jFsTXUp0TrQDp0oWpn/FW0aUn93VL
eIsH0ITkxOrH/5AzynL3fTiKCTohA9kHEqUoiZ59RpvrsTjbA23NWuU4DqRb2nFh
iVhiUNY9amqMe3gmq0RprdWyHvmNEUn0ff0Eno4ciw8zHhD+Z6gA0E3YKLA3mQeU
TsRAogXFifrtYIRnywbgM2bS+5nIA2pxjoq0WJcwDGpgdu4j5KtDjqVFHYt9uZBr
//lCKaqhZc8O/6i3YnAZ
=5MG+
-----END PGP SIGNATURE-----

--jRdC2OsRnuV8iIl8--
