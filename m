Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (xc.sipsolutions.net [83.246.72.84])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8C999B7B9C
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Oct 2009 01:46:55 +1000 (EST)
Subject: Re: [PATCH] sound: Don't assume i2c device probing always succeeds
From: Johannes Berg <johannes@sipsolutions.net>
To: Jean Delvare <khali@linux-fr.org>
In-Reply-To: <20090930170006.76e145ca@hyperion.delvare>
References: <20090930152542.3ef753ee@hyperion.delvare>
	<s5hbpksy0yq.wl%tiwai@suse.de>
	<20090930170006.76e145ca@hyperion.delvare>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-9nANDWYa+cju1uLBmJ/R"
Date: Wed, 30 Sep 2009 17:05:11 +0200
Message-Id: <1254323111.3959.6.camel@johannes.local>
Mime-Version: 1.0
Cc: Takashi Iwai <tiwai@suse.de>, linuxppc-dev@ozlabs.org,
	alsa-devel@alsa-project.org, Tim Shepard <shep@alum.mit.edu>,
	Jaroslav Kysela <perex@perex.cz>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-9nANDWYa+cju1uLBmJ/R
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2009-09-30 at 17:00 +0200, Jean Delvare wrote:

> The NULL check of client->driver, if followed by a call to
> i2c_unregister_device(), would indeed be enough. But unlike the onyx
> driver which we know we sometimes load erroneously, the other drivers
> should never fail.

All of these drivers can be loaded manually and then fail though, or am
I misunderstanding something?

johannes

--=-9nANDWYa+cju1uLBmJ/R
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJKw3OjAAoJEODzc/N7+QmamFMQAIK1ekBv4Oe7SMJtvy2ak7aS
DN/+VauZYbxThtspvdWxHLhgd/y2iF+tjfyGJ5FYRFyA+mnZyOUislCQ2YJEH4Sn
B84b6QVdi/ImxdujtzLlv1Kg1nr8y9QlLcgLkbQ2F/VXFTjmSkqVzlUp1WoMtgQN
Pg3PWzPH+brgTkLbTMiz0DGIxt6LnhJ3H7JP6FfNFL2KISyfQD8ci5Zd0K9I5JHb
Jvp2STrgEH5lvI0wq+aiIwQfme+9WCybLPFRhDuNFg0yCk3OwlPI51er6mFcV9Ml
s8TwAQD5Z/4x+i30uu3oXixsvIvul48Yw1Pbafd5AQYFLAGiYLOIygjSyy98pxmh
/hKmaDmtgDMXtCTrRSLFBArSDJyUuuQZ5XcOPW/zzHjGBcslt5ITyaCIlgfBoFyd
6i6dtGhryV/KC0Iyol55WXG6v3M8imkb8x0s6jVTG05HTq/+vXnZg7Pgkf40RGle
OGppvKTzHAo1BSj3ux0kXH1V8D29f0tVOIOg4NnTy//gl1XAv29cDxVK8Zfhik/u
XYspooLVktwRoHAnOA5Lj1h6bCG6p83MJjRXZehRRPowzi9i307Qd2TMuxvzm2LE
ioU+jcR7FJLISAO68S3NMqXKqtry3VN+76WeKTo9Sz/GOf0UaoNnPRMP5h90RRfG
6zj41PIWvLhj5vvD/LHQ
=9htZ
-----END PGP SIGNATURE-----

--=-9nANDWYa+cju1uLBmJ/R--
