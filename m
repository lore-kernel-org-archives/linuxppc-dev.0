Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 41816DDEC0
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Nov 2007 07:37:33 +1100 (EST)
Subject: Re: time accounting problem (powerpc only?)
From: Johannes Berg <johannes@sipsolutions.net>
To: =?ISO-8859-1?Q?J=F6rg?= Sommer <joerg@alea.gnuu.de>
In-Reply-To: <slrnfkdnma.681.joerg@alea.gnuu.de>
References: <1195814816.4149.94.camel@johannes.berg>
	<slrnfkdnma.681.joerg@alea.gnuu.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-pTvK+/p4L9+B+N0KSOVw"
Date: Fri, 23 Nov 2007 21:37:25 +0100
Message-Id: <1195850245.4149.170.camel@johannes.berg>
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


--=-pTvK+/p4L9+B+N0KSOVw
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

> % diff /proc/interrupts <(sleep 2; cat /proc/interrupts)
> --- /proc/interrupts    2007-11-23 15:04:06.004846901 +0100
> +++ /proc/self/fd/11    2007-11-23 15:04:05.952841422 +0100
> @@ -1,15 +1,15 @@
>             CPU0      =20
>   21:          5   MPIC 1    Edge      PMac Output
>   24:         68   MPIC 1    Level     ide1
> - 25:   18063968   MPIC 1    Level     VIA-PMU
> + 25:   18064241   MPIC 1    Level     VIA-PMU
>   26:       2426   MPIC 1    Level     keywest i2c
>   29:          1   MPIC 1    Level     ohci_hcd:usb2
>   30:          1   MPIC 1    Edge      PMac Input
>   39:     843910   MPIC 1    Level     ide0
>   41:     990592   MPIC 1    Level     eth0
> - 42:    1415066   MPIC 1    Level     keywest i2c
> - 47:    2075159   MPIC 1    Level     GPIO1 ADB
> - 48:    6686659   MPIC 1    Level     radeon@pci:0000:00:10.0
> + 42:    1415084   MPIC 1    Level     keywest i2c
> + 47:    2075193   MPIC 1    Level     GPIO1 ADB
> + 48:    6686778   MPIC 1    Level     radeon@pci:0000:00:10.0
>   61:          0   MPIC 1    Edge      Sound Headphone Detection
>   63:      94238   MPIC 1    Level     ehci_hcd:usb1, ohci_hcd:usb3, ohci=
_hcd:usb4
>  BAD:         19
>=20
> I don't know where they come from, but that's the cause of the high IRQ
> time.

Are you sure about that? I'm fairly sure that I always had rather high
numbers of interrupt here. And the system isn't sluggish or unresponsive
as you'd expect if the IRQs actually did take 90% of the CPU time!

johannes

--=-pTvK+/p4L9+B+N0KSOVw
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUAR0c6BKVg1VMiehFYAQLyFhAAxIiqmxyefycxOoI4sfp/DImTmm8fWxlY
5yDObXEUaPLInr4PxVw8YzpW5zHxmQVkuJBBbdVcNzxa9Z/uX4FIh3Sd53LuNUOq
9gTTdl1EgCKNLKKZAxK+qBmz7Z66Kb5sFLogqJBin5jUgJER24ITz++LfhLta5AE
qBUCfNP73L88QSGSoj1hr4cQiJTj9ULC3Ap7ZVsvvS91MI/WY/dqnJ1y1FW2Df6R
+oqqRTYmdGhn0/4lrL14LpOteT4Hx/kR5oAff9cED55ucufVZdI1h5S2/HCDQroB
gt5/1ywjbyBQcXsGhznFU7KTqkgRbmEhhEfBI356egv9yjlUppNLvb+MVJx72Xdc
8kP+ndYalNzbDKu9OWIrgcZv9CqflSSSQORGV+Uj6Gz2fj8IkgPPq0glh//bDK4e
UtmP8KJbROT95ZcdbaemBAJVF4sPAQmkx0FEeO6Sp2EPgqwOz+UyMWEEdzJTcZ9H
bSgMFONLxlgGSrfDbLpXq4X+iOKvfKseeRr/5a/skxKbemx+GKT52J7aOBDbCGIl
IfJQlRbkpAre2PGuKrqhvVuBL2/2dQnycUsss/OKPAeY6TtiazGOIn+gYZFllv2r
y0jcZ8jBF10+BoudOM4jslqH/ln0oQjtQDXrAJqLx3S/BVwcgwHw2fxZwsODTS3U
s1bdGxh4HmU=
=cPE6
-----END PGP SIGNATURE-----

--=-pTvK+/p4L9+B+N0KSOVw--
