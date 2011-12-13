Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [IPv6:2001:6f8:1178:4:290:27ff:fe1d:cc33])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 5D0E41007D3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Dec 2011 21:19:00 +1100 (EST)
Date: Tue, 13 Dec 2011 11:18:46 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: Eric =?iso-8859-15?Q?B=E9nard?= <eric@eukrea.com>
Subject: Re: [PATCH 01/19] mxc_udc: add workaround for ENGcm09152 for i.MX25
Message-ID: <20111213101846.GC2619@pengutronix.de>
References: <1323757911-25217-1-git-send-email-eric@eukrea.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="c3bfwLpm8qysLVxt"
In-Reply-To: <1323757911-25217-1-git-send-email-eric@eukrea.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>,
 "open list:FREESCALE USB PER..." <linux-usb@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>, Felipe Balbi <balbi@ti.com>,
 Sascha Hauer <kernel@pengutronix.de>,
 "open list:FREESCALE USB PER..." <linuxppc-dev@lists.ozlabs.org>,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--c3bfwLpm8qysLVxt
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 13, 2011 at 07:31:33AM +0100, Eric B=E9nard wrote:
> this patch gives the possibility to workaround bug ENGcm09152
> on i.MX25 when the hardware workaround is also implemented on
> the board.
> It covers the workaround described on page 42 of the following Errata :
> http://cache.freescale.com/files/dsp/doc/errata/IMX25CE.pdf

Nit: The title of the ENG would help reviewing, like it is preferred to
cite patch titles when mentioning the commit-id.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--c3bfwLpm8qysLVxt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk7nJoYACgkQD27XaX1/VRvhpgCeO5eCLJWGf1Mqh1tG7IV1N60o
WlIAnR+7WBUZGAjLmgxBMpEf+zG0hw9n
=/0UZ
-----END PGP SIGNATURE-----

--c3bfwLpm8qysLVxt--
