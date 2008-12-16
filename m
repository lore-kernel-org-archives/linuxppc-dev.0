Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id 7C728DDEF7
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Dec 2008 23:42:06 +1100 (EST)
Date: Tue, 16 Dec 2008 13:41:56 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: Paul Mundt <lethal@linux-sh.org>, hjk@linutronix.de, gregkh@suse.de,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: Re: [RESEND][PATCH] uio: Add of_platform_driver to uio_pdrv_genirq
Message-ID: <20081216124156.GD3275@pengutronix.de>
References: <1229007937-5501-1-git-send-email-w.sang@pengutronix.de>
	<20081216122524.GA29546@linux-sh.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8nsIa27JVQLqB7/C"
In-Reply-To: <20081216122524.GA29546@linux-sh.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--8nsIa27JVQLqB7/C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> It is pretty poor form to not even bother to Cc the only author of the
> code you are modifying, and have no Signed-off-by or Acked-by to even
> suggest that it was ever even looked at. This isn't something that ought
> to have to be pointed out, either.

Oops, yes, forgot this in the resend, I am sorry. I did CC Magnus in the
first round, though, and he replied to me that he liked adding OF and
just waited for Hans' reply first.

> In addition to the stuff pointed out by Greg, I don't see what you
> actually gain by hacking the OF crap in to this driver. You would be
> better off layering the OF driver on top of this, rather than trying to
> make them live together in the same file.
>=20
> See pata_platform/pata_of_platform for an example of how to do this a bit
> more sanely.

See my reply just posted. I found two ways to go, and from reading
discussions on the lists, finally decided for this way. May have been
the wrong path, but nothing that could not be changed.

Kind regards,

   Wolfram

--=20
  Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry

--8nsIa27JVQLqB7/C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAklHohQACgkQD27XaX1/VRtDVgCgmBwZFM4DcUO+/N8f+rskSM7u
tmoAn0ANaw6rBxCMWu4rrcWs1lswV4E5
=LhNM
-----END PGP SIGNATURE-----

--8nsIa27JVQLqB7/C--
