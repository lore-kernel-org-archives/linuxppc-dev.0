Return-Path: <wsa@the-dreams.de>
Received: from pokefinder.org (sauhun.de [88.99.104.3])
 by lists.ozlabs.org (Postfix) with ESMTP id 40wMkn3M1jzDr43
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 May 2018 04:31:45 +1000 (AEST)
Date: Tue, 29 May 2018 20:31:43 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, Brendan Higgins <brendanhiggins@google.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
 Guenter Roeck <linux@roeck-us.net>,
 Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Peter Korsgaard <jacmet@sunsite.dk>, Andy Gross <andy.gross@linaro.org>,
 David Brown <david.brown@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>, linux-i2c@vger.kernel.org,
 openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Subject: Re: [PATCH v2 2/2] i2c: busses: make use of i2c_8bit_addr_from_msg
Message-ID: <20180529183143.ker46to34gr5hx3w@ninjato>
References: <20180516071647.29277-1-peda@axentia.se>
 <20180516071647.29277-3-peda@axentia.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ywla3ypxi7fbwfzy"
In-Reply-To: <20180516071647.29277-3-peda@axentia.se>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--ywla3ypxi7fbwfzy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 16, 2018 at 09:16:47AM +0200, Peter Rosin wrote:
> Because it looks neater.
>=20
> For diolan, this allows factoring out some code that is now common
> between if and else.
>=20
> For eg20t, pch_i2c_writebytes is always called with a write in
> msgs->flags, and pch_i2c_readbytes with a read.
>=20
> For imx, i2c_imx_dma_write and i2c_imx_write are always called with a
> write in msgs->flags, and i2c_imx_read with a read.
>=20
> For qup, qup_i2c_write_tx_fifo_v1 is always called with a write in
> qup->msg->flags.
>=20
> For stu300, also restructure debug output for resends, since that
> code as a result is only handling debug output.
>=20
> Reviewed-by: Guenter Roeck <linux@roeck-us.net> [diolan]
> Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> [emf32 a=
nd imx]
> Acked-by: Linus Walleij <linus.walleij@linaro.org> [stu300]
> Signed-off-by: Peter Rosin <peda@axentia.se>

Applied to for-next, thanks!


--ywla3ypxi7fbwfzy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlsNnI8ACgkQFA3kzBSg
KbZC4A/7B0QIKCSquWwTUwVg/hBiXgsZTb1tAbuqsmSLFLUN0S/GD2du/zLhpqlc
tQwrw4SPFDEbDHTLLgu9YOI7Gxfn6IcNm5BEJ3tL7ef1A1Yy/PCpv3/UPAG2QXBd
Q019MAuoQpanhU3k7L7XSbVAXrPcmspeuYJzSsCvNKnk5/Io8uJ77hl5K8NWryKQ
MP9Tw8CRaH/vihI+4ZnhU0YUqKJBlFnRXcHThcda1baF6HsNFlqM2PT5XP9TtDvp
3+Q+g8OCV9TRCFhAeDvJ84CR8TwdXwK0qftlbH4QVl2eq480CBi9r9+Ze5TuaIlH
4kTJvS+IyRT29GJ+u3VlaD12ZdkcRTW5WQghGhQlTVkmGSSxpybNs3cVoha37/Es
ntiSMG7YurcXD68hnMkAPpI7cUINMY6/y9mkgTE8Jae/AKf4qTIWtpkDwYiBa+Jh
SY1WJFPAAhY0Avz/0h13ZZaAu0eeTVbM4kGNiHtV8OTl6FnCmLEfm3gtUE/a2Cnx
3WdhkQFDlbl2/J3P/MLJcik+fPTSWZPrHblHVn9wtMt++2uCr88R5XCcpJ08pkcH
F5adRaRAVoI5MDpDT7VifZ7zqVyvfdwjIHEQrjrRnDDIsmo9R+P1+C9WiWsMwLdB
St94YeEV2gbxn+XFd1SliCKEaoKtu9lnsE2hQGLGwujq1rKyyt8=
=qpJp
-----END PGP SIGNATURE-----

--ywla3ypxi7fbwfzy--
