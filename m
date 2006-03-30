Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (unknown [213.151.39.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CC30C67A0E
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Mar 2006 23:38:32 +1100 (EST)
Subject: Re: snd-aoa: new apple sound driver
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1143604878.3585.5.camel@localhost.localdomain>
References: <1143547826.13615.24.camel@localhost>
	<1143604878.3585.5.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-/m58zqFbfazy30ohDoaH"
Date: Thu, 30 Mar 2006 02:38:42 +0200
Message-Id: <1143679122.20571.9.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, debian-powerpc <debian-powerpc@lists.debian.org>,
	Alastair Poole <netstar@gatheringofgray.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-/m58zqFbfazy30ohDoaH
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-03-29 at 15:01 +1100, Benjamin Herrenschmidt wrote:

> Oh, and jackd seems to be unhappy even if I tell it to ignore the
> capture channels, it's probably a problem with setting the sample
> formats, I haven't looked in detail (yet).

Yeah, that's exactly it, it is trying to set 48KHz which I don't support
yet because I'd need to do i2s cell manipulations (serial format
register etc)

$ jackd -d alsa -r 44100 -S

starts for me. Not like it actually seems to work though...

johannes

--=-/m58zqFbfazy30ohDoaH
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARCsokaVg1VMiehFYAQIAqxAAo7xfCiuWE5pw+C57jI+UkO5wbndRrKqc
DZNENuS68Y8jKPP/QEuWJ6o6CGv/w8qIj90hwMMImLtdkagVuEUyG1B5Or4D6ept
/jMLfDpSzX55cA/UtWoJqcXA7HYTq00Y+BCKNgji3C6sVOO9mheAFlWIVYJeRpj8
37eR5kE/B/TKHxVguODdOWZ8nkm6GsN2GR0Lr77pwMrjO/cYBqQzDqukmBgyeqxJ
HlO9gs1qtYfeioqivXXirz7abLLYqxj8YuP9toE8V/XwreAgp3vTRO4gh7n4pmwN
9+UczTaa7FHUVbg6GmA2IFEBAl5myVjXxD6JE24VTIFFIL+E26bAgRdA4p2VcXM1
jdlPmdjdqZoqwzxTSRlt3I95EUA8+x7qgzncK10BpfvfTWfDTDCxt3x/ryfhmGu8
R3G3vC62WmhtRBbTvZ95zm/V53aKzglxzJV+mrSAsZ5cFlv5zn64qmPdu1ThpYLx
LEgVy4lg/W5/+aWgaK9VNUfjiqz5OOElebiLC/wPUvKhrNfLpT0delJ3lZB0XCWF
iOaAyZyEBlw2vdRw98nMpkRzv9iOwoOsRGks5fnLwDnR/STSUcKw/zFXz5BO3xSd
20sfEaGNVowWWW656hKB3w9lBliaGODo5etl5w4h/xxfrwprc7e4UWMxYbylYhY7
Ze4tgaPGWNY=
=1GxS
-----END PGP SIGNATURE-----

--=-/m58zqFbfazy30ohDoaH--
