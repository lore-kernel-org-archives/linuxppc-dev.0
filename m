Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A58A967A07
	for <linuxppc-dev@ozlabs.org>; Thu, 18 May 2006 20:15:10 +1000 (EST)
Subject: Re: snd-aoa status update / automatic driver loading
From: Johannes Berg <johannes@sipsolutions.net>
To: Andreas Schwab <schwab@suse.de>
In-Reply-To: <jey7x04edq.fsf@sykes.suse.de>
References: <1147860564.14395.6.camel@johannes> <jey7x04edq.fsf@sykes.suse.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-Vb1uq03TcJgQeUSQu8Nh"
Date: Thu, 18 May 2006 12:14:47 +0200
Message-Id: <1147947287.15507.43.camel@johannes>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	debian-powerpc <debian-powerpc@lists.debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-Vb1uq03TcJgQeUSQu8Nh
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-05-17 at 21:53 +0200, Andreas Schwab wrote:

> 	/* PowerBook6,7 */
> 	{ .layout_id =3D 92,
> 	  .codecs[0] =3D {
> 		.name =3D "tas",
> 		.connections =3D tas_connections_nolineout,
> 	  },
> 	},

Thanks, I'll add that.

Autodetection will come some time too :)

johannes

--=-Vb1uq03TcJgQeUSQu8Nh
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARGxJFaVg1VMiehFYAQKfxhAAoO9+Cke2Gqmsx3Ry3X7IlqX/pMZY3v2H
WCC2u17rdxh2z7sPBBpREzc6UXM/zMUNeA9bKhNh0N0D2HOuu3MHPBJ7D7cmR8ks
XtERq2JXuE0J9D5dMddeoYHZqP/xsvLaV9cT+6IuUN+sbsvAY+3OkJYY/7Ag64l5
dA3/bxnSPTCQMD1D8maSgRgYmAFnLKy9JaFdh7Xz4eG+2G5rst+PUrOExXJz1llI
0oNz6fiznCTHrtG9KxQYw2isQNvjnNGwjrQtq8+vzrx/emWXzBNQorJEH5MjEbAg
yNsdjRclMCZ9a2AbNmk3sxhQCUAahQE9K6hFSQPwbS4YYLO3wka8H1a5Q4pXrTE2
XvaYY8Rhgqb9YKCmQHWzKez/c9cirviHnLyuillpIPX+shb+11fNASbaXkY5XNjn
eVqtYic9a8NzJdtznXD5nWMFmGCVQtjKVipMWFCdemCYzQIP9BZt7ATzGS4KWCzI
EzyJ4b97dtiGgXNCW373LvhOTf8I6xn2SQ7mKqFD2foEeDYpIhVT5DO3t/vHc6/g
F+6anRF1CV3KYWAB312lacKmzVaLhD29JV0f/+SkE9zHQxfM90+5SZcWEkz+P76y
xj2iyGidC0I5peVZ7/tqrU7nNKNFUR0+CQbIXTt0tgkh6nTVNa/CdkExCR6D5BIt
8WL6tPS2ICA=
=jx6g
-----END PGP SIGNATURE-----

--=-Vb1uq03TcJgQeUSQu8Nh--
