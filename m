Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D425DDDEBE
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Nov 2007 07:48:50 +1100 (EST)
Subject: Re: time accounting problem (powerpc only?)
From: Johannes Berg <johannes@sipsolutions.net>
To: =?ISO-8859-1?Q?J=F6rg?= Sommer <joerg@alea.gnuu.de>
In-Reply-To: <1195850245.4149.170.camel@johannes.berg>
References: <1195814816.4149.94.camel@johannes.berg>
	<slrnfkdnma.681.joerg@alea.gnuu.de>
	<1195850245.4149.170.camel@johannes.berg>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-XC8BhilXGUmiYUrCxzVK"
Date: Fri, 23 Nov 2007 21:48:42 +0100
Message-Id: <1195850922.4149.175.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-XC8BhilXGUmiYUrCxzVK
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


On Fri, 2007-11-23 at 21:37 +0100, Johannes Berg wrote:
> Hi,

> > - 25:   18063968   MPIC 1    Level     VIA-PMU
> > + 25:   18064241   MPIC 1    Level     VIA-PMU

> > - 42:    1415066   MPIC 1    Level     keywest i2c
> > - 47:    2075159   MPIC 1    Level     GPIO1 ADB
> > - 48:    6686659   MPIC 1    Level     radeon@pci:0000:00:10.0
> > + 42:    1415084   MPIC 1    Level     keywest i2c
> > + 47:    2075193   MPIC 1    Level     GPIO1 ADB
> > + 48:    6686778   MPIC 1    Level     radeon@pci:0000:00:10.0

> Are you sure about that? I'm fairly sure that I always had rather high
> numbers of interrupt here. And the system isn't sluggish or unresponsive
> as you'd expect if the IRQs actually did take 90% of the CPU time!

Also, I'm pretty sure I see the same on my powermac (haven't tested but
I did see the same symptoms) and it has neither a PMU nor radeon :)

johannes

--=-XC8BhilXGUmiYUrCxzVK
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUAR0c8qaVg1VMiehFYAQKeCg/9EQg9Y/7+0kqMtdG/IlSCmzBKEPozkuDb
8WQYFz3MWvCVV4gz122nKifiBqoKgEQq+UT8L2g2LFU2gdWQNpjDcsQy2YAmD2v+
f0y01VDrsMb+mQz/8jcAguiXJZB8N86GnwSBWr9moQnGmMB+qKoRtQQTUpy+I+0Q
60hhvuEZVovC90ZYuwt8/Tuzv108UwJjelo2Qmm1K6RPkdiCCrWZr158UEbS6iXr
i3pyqbBjGtV08zrpDAKbTPWZ3a4tVCr19/RPJjbeNOvgdApmzoWk6MM/oXTou6WG
2qnoJqIk8Qtil2bE9/ro2sIlOcO09HwBXUdlMjwywymy8uQs+JtRecJ3aMA97I2h
2S549YzurNCAPSOYO175uQO9PTbp26/e2C3Fqzc0UV26b4ydZk9HYkZ5XWoLdH9O
M9xM+mmfVwWHBcvEkjM7M6eFeYk0XNcC2SZKVcHC/CgZPO/wb7qoVDDc+TwL57oy
bVq/9f41BdeXBFDJXU/vw20XR3IAEtd7CIvg0mhuH/nQ0UWb2U3iYgfWBcgrILz7
Wl4LaI8sZMKdjZYWxdJE6xEevCSrvgK+6MlGqtYjM2uXkfC1VPLjdJ1FBqEzKqz3
gTT2snSO8sPGCTtOIAM+4zedikPEHwOaPlQ0yJXLt6jwpxVG48C3uEeFGCzmc7mC
79I842v8RDw=
=pvbJ
-----END PGP SIGNATURE-----

--=-XC8BhilXGUmiYUrCxzVK--
