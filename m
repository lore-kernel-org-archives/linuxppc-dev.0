Return-Path: <wsa@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id C3DBDB7B77
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Oct 2009 03:12:24 +1100 (EST)
Date: Fri, 9 Oct 2009 18:12:12 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: Nate Case <ncase@xes-inc.com>
Subject: Re: [RFC] misc/at24: add experimental OF support for the generic
	eeprom driver
Message-ID: <20091009161212.GA588@pengutronix.de>
References: <1255010672-21656-1-git-send-email-w.sang@pengutronix.de>
	<20091008143301.GA6084@oksana.dev.rtsoft.ru>
	<fa686aa40910080753v6f597b0h4ce835db9f7a653@mail.gmail.com>
	<20091008151007.GA21328@oksana.dev.rtsoft.ru>
	<fa686aa40910080848r459c47baob73fc70a95a08604@mail.gmail.com>
	<20091008202723.GA8116@pengutronix.de>
	<20091009051409.GA2361@pengutronix.de>
	<1255095793.16018.32.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
In-Reply-To: <1255095793.16018.32.camel@localhost.localdomain>
Cc: devicetree-discuss@ozlabs.org, linux-embedded@vger.kernel.org,
	linuxppc-dev@ozlabs.org, linux-i2c@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Aside from any issues you have with the properties themselves, what's
> your take on this approach?

Well, my approach for AT24 looked very similar to your approach. In fact, e=
ven
the motivation was the same as yours :) Well, the outcome of this is the
current thread and no definite solution yet. The archdata surely helps for =
this
issue, it just seems that a bit more generalization is needed.

Kind regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkrPYNwACgkQD27XaX1/VRthAQCgmbhZhN8QwsE/NfoPF7/Dw4uw
b7wAn1akxUYU/L7SuKrgc2S6gzY1IXZL
=OuHm
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--
