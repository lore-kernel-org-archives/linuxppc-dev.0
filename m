Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B0920DDF2E
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Oct 2007 23:35:38 +1000 (EST)
Subject: Re: [PATCH] fix appletouch geyser 1 breakage
From: Johannes Berg <johannes@sipsolutions.net>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
In-Reply-To: <d120d5000710240634j21d2b660t267ace56bd9d6af6@mail.gmail.com>
	(sfid-20071024_143412_422062_819BA31A)
References: <1193222676.4510.5.camel@johannes.berg>
	<d120d5000710240555m545a4f95v8bfc1ac790273001@mail.gmail.com>
	<1193231110.4510.42.camel@johannes.berg>
	<d120d5000710240634j21d2b660t267ace56bd9d6af6@mail.gmail.com>
	(sfid-20071024_143412_422062_819BA31A)
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-YM/FySy+c2QNZ2TmED3J"
Date: Wed, 24 Oct 2007 15:36:55 +0200
Message-Id: <1193233015.4510.44.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Anton Ekblad <valderman@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-YM/FySy+c2QNZ2TmED3J
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-10-24 at 09:34 -0400, Dmitry Torokhov wrote:

> Well, but what about fountains then? Regardless of the model, if there
> is a way to stop "empty" meaurements, we should do it.

There is no way on fountains though. We could check the measurement
ourselves and if no finger is detected decrease the polling frequency or
something, but there's no hw support.

johannes

--=-YM/FySy+c2QNZ2TmED3J
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUARx9KdqVg1VMiehFYAQKtbhAAmLetTl29iqmxwtcbCB52h5dQtPVIGzLT
11gUdXl5QtC1XQGiwQ7gC2y3e3YUcfCzHIGVg+xxB4iwVp3hewuzmM5puOEm8eDD
DC9fwYKmqCEyvr0n4WW7xIggRJFLV/e1rmuBqOClB9ibC5ZCPr5KMi20rhnAnNKJ
igYoPd3gy5h88/jkbomxO9rxTjizi8EDWMOEbpjA1nEb5XPRFsfXDWRBfnUeOkeS
vGk5xtmbTdrQ8WU2ABEaQqIw7No7DsuWzr0EpSZnq+DQ8+DtZAFtnY1CGfzizDPj
FAh9eS8VXj7oB1UzGhdq+SoUyz5m8RyDBZfHimlPXK9wi6wvYpksj1vUyjGNAI8q
GUPfqz70p/NXHAh3xCoz9/N2y1PxfJVsXwQvxpmpurG9+Zkaj9ggW58cN4v82V6+
DtQSgOuIZktGbojYrK3GLjHh9oEmO1FxHsp/XjV5Hlivtf4ZUTuHKAJfoSc/JMgW
OCbDRNK0XsroEYEzyNbThzdcXP+ojIt3x9SWhqhtN5BGnd5QospCoGOzMyJMY/s4
C1E0Y7Rn8Y7A/dWcHvcoKOx+GELxpSmqCqWBH6Fe/fJlr4+2v3QA46cVBRqGyalY
DYOxz3/3E3rEtdBWbgH/G76j/uvIYxcMEo7tfHYrbZnjw6tgoCtHtrkAnFQ3B0zG
0pwnQEFZd08=
=UzVc
-----END PGP SIGNATURE-----

--=-YM/FySy+c2QNZ2TmED3J--
