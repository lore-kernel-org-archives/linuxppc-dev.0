Return-Path: <balbi@ti.com>
Date: Fri, 18 Jan 2013 13:48:59 +0200
From: Felipe Balbi <balbi@ti.com>
To: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [RFC PATCH 0/6] USB: Add multiple PHYs of same type
Message-ID: <20130118114859.GC4379@arwen.pp.htv.fi>
References: <1358348462-27693-1-git-send-email-kishon@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="gr/z0/N6AeWAPJVB"
In-Reply-To: <1358348462-27693-1-git-send-email-kishon@ti.com>
Cc: linux-doc@vger.kernel.org, tony@atomide.com, linux@arm.linux.org.uk,
 linux-sh@vger.kernel.org, alexander.shishkin@linux.intel.com,
 stern@rowland.harvard.edu, devicetree-discuss@lists.ozlabs.org,
 linuxppc-dev@lists.ozlabs.org, rob.herring@calxeda.com, horms@verge.net.au,
 haojian.zhuang@gmail.com, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, eric.y.miao@gmail.com, b-cousson@ti.com,
 gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, balbi@ti.com, cbou@mail.ru, rob@landley.net,
 dwmw2@infradead.org
Reply-To: balbi@ti.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--gr/z0/N6AeWAPJVB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 16, 2013 at 08:30:56PM +0530, Kishon Vijay Abraham I wrote:
> New platforms are being added which has multiple PHY's (of same type) and
> which has multiple USB controllers. The binding information has to be
> present in the PHY library (otg.c) in order for it to return the
> appropriate PHY whenever the USB controller request for the PHY. So
> added a new API to pass the binding information. This API should be
> called by platform specific initialization code.
>=20
> So the binding should be done something like
> usb_bind_phy("musb-hdrc.0.auto", 0, "omap-usb2.1.auto"); specifying the U=
SB
> controller device name, index, and the PHY device name.
> I have done this binding for OMAP platforms, but it should be done for
> all the platforms.
>=20
> After this design, the phy can be got by passing the USB controller device
> pointer and the index.
>=20
> Developed this patch series on
> git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git xceiv
> after applying "usb: musb: add driver for control module" patch series.
>=20
> Did basic enumeration testing in omap4 panda, omap4 sdp and omap3 beagle.

please resend without RFC so I can apply.

--=20
balbi

--gr/z0/N6AeWAPJVB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQ+TarAAoJEIaOsuA1yqREwzUQAKHNzbmIGRA5JB0JwaDvCLZS
mDMznav6/TG9h4yxznFxg6o8dxtEnQxCCM3jxgR6GCSn4OiIB3hjkMJb3gwbNZzz
34jJsYKh/zrvsx+ZBbpwe9RpS6nQ3t5bGWQ1asw0BsTsDjHj9ve6HuoPvqmhVROU
Md1+NS9mMwgQZVCwFk6Ex+/0eggopWpveReIsHZYIIAVCHMg6m6qFQm898yTSFJL
xgzPrq9LVt1lcqHkrcc6w5A9DXqtWq1tFmucFcNUaIWCO3Y+vgaL4ypjjI0psxuc
3tT2cYIsCxMiZIhRTNZqUR8TDI6Ps+vz/nqxdaH2dmjdS1YtonzqQbEUVGKP9dpB
hRxCNRHhxTJBdQsHctgvCbhfwzKZJUk0HRldL+35H86Sj5UefXeb+A29kkA4l4kn
g0f7qL8KarZlLHtJ/QwbCNm8POrABUzT0Ps2tay2hgyUPJ8A/2xGg+BEeJijogmD
5X7MH1kz0W55fnKCZ3gn+mK3eqJMNxZ9n4m4tOpAPH50vcYaD3iy7f9EczbztLaG
VG8EYEYczkh0eLrXAXgN4LfZmImgmYIvYJqvngjgTqdoQ5b8S/78TBerHVIwxfqn
yE5h514NdlSus5XrfPhqQpw8jARnnFq2XGc2I4x3gMq8JXioBBYQf1PMp7QXl+l8
okED+iP6snMtIwHr3Gs6
=pVWA
-----END PGP SIGNATURE-----

--gr/z0/N6AeWAPJVB--
