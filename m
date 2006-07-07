Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EB1AE679F0
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Jul 2006 18:40:59 +1000 (EST)
Subject: Re: [Alsa-devel] [RFC 01/12] snd-powermac: no longer
	handle	anything with a layout-id property
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1152260861.9862.59.camel@localhost.localdomain>
References: <20060607130909.584205000@sipsolutions.net>
	<20060607130910.156412000@sipsolutions.net>
	<jey7vjiqwv.fsf@sykes.suse.de>
	<s5hac7yvfhe.wl%tiwai@suse.de> <jehd26aa25.fsf@sykes.suse.de>
	<jeu0631xpr.fsf@sykes.suse.de> <1151619973.22380.50.camel@mindpipe>
	<jehd231rjx.fsf@sykes.suse.de>
	<1152250720.9862.32.camel@localhost.localdomain>
	<1152259477.15068.15.camel@localhost>
	<1152260005.9862.53.camel@localhost.localdomain>
	<1152260564.15068.20.camel@localhost>
	<1152260861.9862.59.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-A9GKFKA1KJeB9uJDkN3b"
Date: Fri, 07 Jul 2006 10:40:48 +0200
Message-Id: <1152261648.15068.23.camel@localhost>
Mime-Version: 1.0
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>,
	netstar@gatheringofgray.com, linuxppc-dev@ozlabs.org,
	Lee Revell <rlrevell@joe-job.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-A9GKFKA1KJeB9uJDkN3b
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-07-07 at 18:27 +1000, Benjamin Herrenschmidt wrote:

> Well, when the master volume shows up, softvol can "unplug" itself :)

Hmm, not a bad idea, that way there's always a master volume. And when
some cards have an unusable master volume then softvol could be forced
to superimpose via the config file.

johannes

--=-A9GKFKA1KJeB9uJDkN3b
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUARK4eDaVg1VMiehFYAQLy3A//YkihwnQkSLgcedaYzk35KJB0/4RCTdFD
dXVVjRtx0knc+3xRgm58R81np9nErn9hjEy8V7odofuYf0GeXRBvo7XjiwyTFgJS
xcAcXpISx/lVuC8srpxyucDUIAXUILt2BwzJn+ChOtryFnPZ9/2mH+rtAzd8yMos
JxOQUsZXTlcVrtimRHlmga9uAD0p66t0CiwWHcvf2+g0/eDpTDsLTLGVYAcZwlai
SC8XLviJpKbAugPwgmo2N45EmVdZZ/yKNEs5bakgVzQ5xJM7uDxUfEl6jHvJxDpp
sNzu7z6Sm4mFSfMLo2o6Hc47etzuga1MRnjLzvE4yWxonp5AUc8NFiN/RBu8bca9
hgP7SkhZCxGv8CVz5o17dLP8QSySgynJgAOcYDYw/Acxd2udTQVhVk4bx0i7Lg7P
hWicekBE11KhzM1hFj0hV6T8LT3eC49yT1pd8NH0RL4nAblHEo3q/8Dw9Mba0v5k
pBRRlkP6e/od59sFz9WHTjvtRdizzMBOZiMmAQeoq+27SpUmsvoIgXckfoEIyY0k
PuFLXhZ8RyNV39o6tqf0eGRWLIf+FYyXCO37eOjD4F7K1gZPu43xATpKP2orBtK9
YNjXZs+UYD63gzItgToh3ED5C3LfvXGItbxZtqrDJdYcuJaz178lPjfS2Ju3Hu0w
Zzf8unDUUTg=
=TWuS
-----END PGP SIGNATURE-----

--=-A9GKFKA1KJeB9uJDkN3b--
