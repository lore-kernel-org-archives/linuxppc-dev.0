Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2006667A58
	for <linuxppc-dev@ozlabs.org>; Wed, 17 May 2006 22:17:13 +1000 (EST)
Subject: Re: [Alsa-devel] [RFC] alsa integer control ranges
From: Johannes Berg <johannes@sipsolutions.net>
To: Takashi Iwai <tiwai@suse.de>
In-Reply-To: <s5hy7x10y5t.wl%tiwai@suse.de>
References: <1147780945.29795.110.camel@johannes>
	<s5h7j4m40kf.wl%tiwai@suse.de>
	<1147817023.6753.5.camel@localhost.localdomain>
	<s5hy7x10y5t.wl%tiwai@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-9Zq8cjkjFUA1nO6k30kS"
Date: Wed, 17 May 2006 14:16:58 +0200
Message-Id: <1147868218.15507.4.camel@johannes>
Mime-Version: 1.0
Cc: ALSA development <alsa-devel@alsa-project.org>,
	Benjamin Berg <benjamin@sipsolutions.net>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-9Zq8cjkjFUA1nO6k30kS
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-05-17 at 11:59 +0200, Takashi Iwai wrote:

> We have several issuess regarding the conversion of dB <-> raw volume
> values:
>=20
> - some codecs use linear volume
> - some codecs have non-linear dB slopes

And I made a huge table so that the slope is linear! Otherwise it'd have
been logarithmic. Anything else is pretty user-unfriendly though.

johannes

--=-9Zq8cjkjFUA1nO6k30kS
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARGsUOKVg1VMiehFYAQL1HA//SDp/RiOTHCb481p7thrIQInny/N/7+Fz
mG61MkLxCts8kmxRJz1qF93676DPIXUTn53sipPHX1BmgMz+B9A74BpiN9yEK9Ba
fVst+9s2fzirpA7tpoNIzLczmi3IEvOt+ZBNmeep4q3t0So3GYzQI/QOrMZTDcU5
OxfpZbG/fCy2v6iLoLbpHvV5kSX4+mKLwg3qn951Y+B7wnj1z7KgIpyN9vnc1Y4G
v2mXk08GPu50KfvuCiPjRirZuS8+gdRi9qzsPlKC1kpvjZswFFJSHVpFkjtpy9Nc
4h4Du+AYflsTNL8E+3cXkVxedfmItCxc+yuz9asLCyZ0/Wx6LfxY3sYG1XrrLo+4
M7TKteabxIeLGoLTfXwnaV6pucmGGqk5dSZhLU0HqHuFIhmd/97U6A2K7JZ3JhUQ
aAb0X6W+Lh5gQhKFUguXIzceB6pmcub/BnBBi3AYHHE5zFD+oudpV1xO5Xl2KQ1p
x6XsiZGbPDFjeBwKKYaUG2s1shUo5qv+fiJ5cdysXI/k27sdBCXJgZYrhFGwo5AF
sPEM8SspoA93EaTROriZI+2GiM2xQAdqocby5Ni4F1VTco8cU9O6LKLK2USNA/26
NTE8rtd/Qtzk5SC3CgoKS73AxhdIK+0umlO4z9jJpTd3WGUtciAd3SSrJjSU+SJP
61H/iAqfJvI=
=KSuG
-----END PGP SIGNATURE-----

--=-9Zq8cjkjFUA1nO6k30kS--
