Return-Path: <wsa@the-dreams.de>
Received: from pokefinder.org (sauhun.de [88.99.104.3])
 by lists.ozlabs.org (Postfix) with ESMTP id 3xgxMn4MhTzDq5k
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Aug 2017 02:01:25 +1000 (AEST)
Date: Mon, 28 Aug 2017 18:01:21 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Javier Martinez Canillas <javier@dowhile0.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
 Rob Herring <robh@kernel.org>, Florian Larysch <fl@n621.de>,
 David Lechner <david@lechnology.com>, Rob Herring <robh+dt@kernel.org>,
 Andy Shevchenko <andy.shevchenko@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>,
 Simon Horman <horms@verge.net.au>, Michal Simek <michal.simek@xilinx.com>,
 Dinh Nguyen <dinguyen@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Will Deacon <will.deacon@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Sekhar Nori <nsekhar@ti.com>, Scott Wood <oss@buserror.net>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Joachim Eastwood <manabian@gmail.com>, Mark Rutland <mark.rutland@arm.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Santosh Shilimkar <ssantosh@kernel.org>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>, Magnus Damm <magnus.damm@gmail.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <kernel@pengutronix.de>,
 Linux I2C <linux-i2c@vger.kernel.org>
Subject: Re: [RESEND PATCH v5 00/16] eeprom: at24: Add OF device ID table
Message-ID: <20170828160121.gu4wf7jqu4ditksc@ninjato>
References: <20170615185418.13980-1-javier@dowhile0.org>
 <20170731153009.xkjknygpmckv2pfp@ninjato>
 <CABxcv=mdbE0QGjoi3aLzxRqM3-MbkQ_Ai6fShcGVUGSNNqqrqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="kxl2ldofwcq27yov"
In-Reply-To: <CABxcv=mdbE0QGjoi3aLzxRqM3-MbkQ_Ai6fShcGVUGSNNqqrqw@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--kxl2ldofwcq27yov
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > But there is a dependency, no? If I apply the driver patch,
> > non-converted device trees will not find their eeproms anymore. So, I
>=20
> I don't think that's correct. If you apply this patch before the DTS
> changes, the driver will still match using the I2C device ID table
> like it has been doing it until today.

My tests do not confirm this. If I add a node with a "renesas,24c01"
compatible to my board, it works before your patch, but not after. If I
change it to "atmel,24c01" it works even after your patch. I haven't
looked into it, though, maybe i2c_of_match_device_sysfs() is stepping on
our foots here?

Did you test and did it work for you?


--kxl2ldofwcq27yov
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlmkPlEACgkQFA3kzBSg
KbY9mQ//ZYxuivYI37NBqNzvT6LEyeDnhT5YpI+3SDGk88+Ny3uOysJpehIW1zmQ
/o4MmLhMZq0emuNniTUcq6hs1DmPC1YFAHoNPhdcPEJY9BDB5Z28l187ETQ0wtYD
u8DAc11LnQLCGRgBngM9zAVClRI16o07T68hSGlUntK/oEAuqEqtcw3Nt4wAY1nD
1ALzfhgtBsGJ+BSDLTvW7sZ5cqJ1NhjHnEV2rLDIxTQPTTVBc3guI7Zw7+qXuETX
cJ/mIhwyYPpcdlPM7A9mt3CozKhjFEnWG+TZEl3xiQVs/5Gb6hF7c+q06g1t1BBE
OufNGdCTbg3etFN0y//oj2+K2iUqfw4m/33VmGBltVZuKxcrEFCOHBaONdyAJ2ET
tki7C+Vz/JzD5VDl7nUp7Ci95FbRjFGXDy45e8u0Nyb1eQX02Y+owo/Pk5ZuiRQw
fi6c5lJP34KazsrmGpqm9W/wzggxJSoXW1abAOeDTindLZ4DiSH41od6tx2y/nHs
e2i2OygFb3NNccXZ9QL/xmcRiCzwi9hk9Tt71fawGWQ+hLKxrLs7emt8kfpPU4aU
ZpdA4TbozeaOWWDzbOzwV25d0kOe+LiwKx+PTNgW2Uimz1sQBWOpIm0vZGXxqa8y
wSSRx/WWug0tYILnAP5BQmLV9X5N3m8zaJ6u1neWImCTNpCweFU=
=nrOV
-----END PGP SIGNATURE-----

--kxl2ldofwcq27yov--
