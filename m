Return-Path: <Simon.Richter@hogyros.de>
Message-ID: <43A97CAF.50301@hogyros.de>
Date: Wed, 21 Dec 2005 17:02:55 +0100
From: Simon Richter <Simon.Richter@hogyros.de>
MIME-Version: 1.0
To: Alessandro Zummo <azummo-lists@towertech.it>
References: <20051220220022.4e9ff931@inspiron>	<43A94811.4010704@hogyros.de>
	<20051221160712.2d322f42@inspiron>
In-Reply-To: <20051221160712.2d322f42@inspiron>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigE2BB3CC6A8421382CEC04DB6"
Cc: linuxppc-dev@ozlabs.org, lm-sensors@lm-sensors.org,
	linuxppc-embedded@ozlabs.org
Subject: Re: [RFC] RTC subsystem
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE2BB3CC6A8421382CEC04DB6
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

Alessandro Zummo wrote:

>   the proposal actually had a fully-working patch attached :)

Ah, didn't see that, as I just skimmed over the web archive page you 
linked to, which has no link to the actual patch (or I'm too stupid to 
find it).

>  In my code, the first rtc that register is bound
>  to /proc/driver/rtc and /dev/rtc (if those interfaces
>  are compiled in, as they are all selectable).

It would be good to have a way to change which clock is the "primary" 
one from userspace later (userspace because this is clearly site policy).

>  You have full control of which functions you will provide
>  to the upper layer. Obivously if you try to set the
>  time on a read-only rtc, you will get an error.

Sure. I was thinking of the question which error that should be.

    Simon

--------------enigE2BB3CC6A8421382CEC04DB6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iQCVAwUBQ6l8slYr4CN7gCINAQJtXAP8C3tnOw0TlhAKiXYJ2v00MV0BJy2IW+DT
jn9CPA1aT2UY2MsPhzgh1bwKX5IlDkf1tvpGxIo6TO4vRxb2luVsh8q9zUCtmvym
tHWJhSW71W9dJMLTWWNVmmxUF14duXYrH/RAXA+25FOAGrx3CIU0xhHo3gb9+Cw2
T7SiXEj7g/I=
=fJSn
-----END PGP SIGNATURE-----

--------------enigE2BB3CC6A8421382CEC04DB6--
