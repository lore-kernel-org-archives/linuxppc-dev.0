Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (unknown [213.151.39.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3FB49679E6
	for <linuxppc-dev@ozlabs.org>; Sun,  2 Apr 2006 02:32:17 +1000 (EST)
Subject: Re: suspend2 on PowerBook: keyboard doesn't work on resume [now it
	does!]
From: Johannes Berg <johannes@sipsolutions.net>
To: Dustin Lang <dstn@cs.toronto.edu>
In-Reply-To: <Pine.LNX.4.58.0604011108240.2100@monte.ai>
References: <Pine.LNX.4.58.0603112043460.25986@monte.ai>
	<1142232047.4228.1.camel@quad.lan>
	<Pine.LNX.4.58.0604011108240.2100@monte.ai>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-ABixZqBEN0fh/RPDUAub"
Date: Sat, 01 Apr 2006 18:32:07 +0200
Message-Id: <1143909127.23254.8.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-ABixZqBEN0fh/RPDUAub
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2006-04-01 at 11:18 -0500, Dustin Lang wrote:

> To follow up on my previous post: after upgrading to suspend2.2.2 and
> kernel 2.6.16.1, suspend/resume works perfectly on my PowerBook.

Good to know. Nigel told me it now uses the mainline suspend code for
doing the hard stuff, so a lot of the hacks I had previously went out
and were replaced by some proper stuff :)

johannes

--=-ABixZqBEN0fh/RPDUAub
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARC6rBqVg1VMiehFYAQKWaBAAriBqeM9jCBkxiP3C1yVnH66m77ORpsjH
X+a4KYr67WCei4cn7zOn039946jMmlJWspsRNQRYg9LzCpLgUgLdpOiaIX6vACIT
1nXONJEbVckl79JxDXJpcyfvnAZsVzJRb1j2vbJlE/fDql9SuG6/XkRGiIJjnKjz
E22Jczo+4Lzsa1P8jNUMT2mJ0V3IL8XX6N9wUqMQ9ftLrCApyXIBSHSESH+JI+Pa
upPzytyMRSlBSi5SIZn8sNZEhd5TOrfBHUIy+KQoZA45qhraUJU7nnoxP1IVo64t
JSaL1AnC3J7kB43aJxwiZVq/6VtD+EGMAkhpr5WmjbY8+hfUA7ABKHg6hQ8M+WWa
UYmi14ely+zSBTZcd3d7Csa2X7qz0+gUZlTN+qa1LSpZa4HE8KSV413WjcoQLuHE
yW2JcXuUcFX+rNWB3k1dvAycbGxfapPB4LP5MBMo32g2RTReP+k4Mftqt60c0Rw5
YtTdg1wItCP4r7bY+dxFrkau2glpEVaOtRp/bC3xOmeejTBmypulYpL6t2wU89lQ
sQ+vFaODdl1kPZgLwB5wt5anS407VdPz1I1JIG7RFLJVzlHUnI8WIoUNAzqD5EOa
lUBYyH546+9l/qMx/27zZiLg5NISz9bWykN+zvlHnZJhp15xj5ZY5I6qrN7+/e5c
aKj1D2fVbDc=
=RzKx
-----END PGP SIGNATURE-----

--=-ABixZqBEN0fh/RPDUAub--
