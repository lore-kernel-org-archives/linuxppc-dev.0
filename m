Return-Path: <tony@bakeyournoodle.com>
Date: Thu, 1 Dec 2011 15:29:38 +1100
From: Tony Breeds <tony@bakeyournoodle.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Josh Boyer <jwboyer@gmail.com>,
 LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 6/6] 44x/currituck: Add support for the new IBM currituck
 platform
Message-ID: <20111201042938.GI15560@thor.bakeyournoodle.com>
References: <1322630640-13708-1-git-send-email-tony@bakeyournoodle.com>
 <1322630640-13708-7-git-send-email-tony@bakeyournoodle.com>
 <1322634022.21641.61.camel@pasglop>
 <20111201040524.GF15560@thor.bakeyournoodle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Az4VpBrmI9+OyhK/"
In-Reply-To: <20111201040524.GF15560@thor.bakeyournoodle.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--Az4VpBrmI9+OyhK/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 01, 2011 at 03:05:24PM +1100, Tony Breeds wrote:
> On Wed, Nov 30, 2011 at 05:20:22PM +1100, Benjamin Herrenschmidt wrote:
> > On Wed, 2011-11-30 at 16:24 +1100, Tony Breeds wrote:

<snip>

> > > +void platform_init(void)
> > > +{
> > > +	/* Cap the zImage to 512MB */
> >=20
> > Any reason ? If yes, please document it a bit more.
>=20
> XXX
=20
Where 'XXX' means come back and anser this point /before/ hitting send.

Basically is was lazyness.

Now that I know the memsize I'll allow the zImage to use it all but
512MB should be enought for anywone right?

Yours Tony

--Az4VpBrmI9+OyhK/
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCAAGBQJO1wKyAAoJEEsCiJRY75GKY5AP/2S6/8FBMf2YomfoV7s0tJqm
J9I/OIxgjF/2mEUmVUW8C9W6nsWjziTyVbXxbm6vm8CtoWni6FmAs1yi2okMt8cJ
Jf7UkqUztljoPpIScmorP3S2qqfXqTHFw11fyCzhcvFiixW27X7fc8QYgQlafOxW
mOECnWHb21zxS9bnMI7/MOn9LSEswFi2daYwqC55JZ/gcihoZYqQu/ipTmQeWoQs
kVIcaFRrp1zQGbn74uDO6yyFX+JM4F0N0rTjN7kRxxMUnJxRB4f16kX1cqT66OXv
peKjVQpvlrs8KbGIsV3BFZR9gL8HoHkd1b2A127L/YKAFYtbxUVa4MAoYnc6GO1D
wawT6Q2c1HZReI2pln1vhkDIF686E+CBnhlntPa5TO+uTay1Z6CH0/nkRf1tcHH8
IztjRejc33ee61OfWNv2d2tE+2i0arjAUPeMvwRi9f6igjyv9267iydmGbCUMWsQ
zHWu+vFu/ybP65sKxg7p39pW8AZZt55uGeY3z1UsfG7+47lRX+QQmOM32XKj1+oo
4fNOkRfnc73rpKAyqWZIlAnkDjj6KOPmS+oA/8g3Vb4bLUY6f/0qMFnTyhK2WFx5
CP7/SmnwC7ARpe2SyIT5L2+EZqaSJES/mKQ9q5ohefuK43DHcvwhEzP/jAQ+CCyQ
BJApdu4dUpodVOi6dxSR
=jC0J
-----END PGP SIGNATURE-----

--Az4VpBrmI9+OyhK/--
