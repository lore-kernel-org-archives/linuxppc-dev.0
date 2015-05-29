Return-Path: <wsa@the-dreams.de>
Received: from pokefinder.org (sauhun.de [89.238.76.85])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 079AE1A0CAA
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 21:06:25 +1000 (AEST)
Date: Fri, 29 May 2015 20:06:09 +0900
From: Wolfram Sang <wsa@the-dreams.de>
To: Takashi Iwai <tiwai@suse.de>
Cc: Dan DeVoto <dand1972@yahoo.com>, linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 alsa-devel@alsa-project.org, linux-i2c@vger.kernel.org,
 Mark Elliott <txlitebeer@gmail.com>
Subject: Re: [alsa-devel] [RFC] sound: ppc: keywest: check if DEQ was already
 instantiated
Message-ID: <20150529110559.GB4282@katana>
References: <1432397711-3186-1-git-send-email-wsa@the-dreams.de>
 <1432631974.85649.YahooMailBasic@web141501.mail.bf1.yahoo.com>
 <s5htwuxb1h4.wl-tiwai@suse.de> <20150529105020.GB3168@katana>
 <s5hsiaf6489.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="jho1yZJdad60DJr+"
In-Reply-To: <s5hsiaf6489.wl-tiwai@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--jho1yZJdad60DJr+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> Do you think from which stable kernel version can this be applied?

The offending commit is 3a3dd0186f619b74e61e6f29dddcaf59af7d3cac
("i2c/powermac: Improve detection of devices from device-tree") which
came in with v3.6 if I read correctly.


--jho1yZJdad60DJr+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVaEgXAAoJEBQN5MwUoCm29EwQAJlAm6rwP7/KulvtQ6DbnSkY
hOhSvuFzZDfkYE/j+oBsgvflqs9WeySZmCctqTABJbEe9HcbZXk6O28oZ7olo8PZ
OG+vDxcf5jl4e7ilsbhAh4rLGY2qV6NGM4FSVhrsDN8mwB8SMV4ibgAc58q+pL4z
Yu5JqjBV88TQqS5CDEfK4p+X6Pu90DxBfBJdaW9Pr1oPsX7PRCViNt5e9s3PtETS
WExeU7PeRrWofYdrowtiz+XDrvRae0gY1A5J7XQueJCdNsy/pwiX3mUW5fvrSoUc
5ReA/PoFIuVud/QDGIeWckwfRSze+3s7lhumOmEBUKwXPbe77hXrftFsURVQxnz0
wHwt0Uu+sbNJgDFFnJNnuQCCS9cPPPzZRl6V2yC1yY+KTHUYzCZuHMpA7viATmMC
Uu2+nL/1ucESdJa3DN6fmi5hGHdHL7wQlv7/fA4zuOW0LFWGzEfJ9oijOatfck4V
kXN+ftAVp7PfLhsFvCqZZAUgx1xwlLncBY23fJUiLUG30zbBgc2ib0kgfBpiESGo
FNYsOAlJhQnmSuHsbC9Zj3ceiscgNamHW3duCi9khBGjYNEaoWkrgWR2/m2bsZnJ
qH4tne14DJ7fohkyIJB43CIoESLJYbq9b7yU70vshOSN+wO007/NZX8avLWq32oX
nLb3LQ02giOrUxnvgllE
=+uBG
-----END PGP SIGNATURE-----

--jho1yZJdad60DJr+--
