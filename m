Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 128BF1007D2
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  4 Dec 2010 02:50:37 +1100 (EST)
Date: Fri, 3 Dec 2010 16:50:31 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: Stefan Roese <sr@denx.de>
Subject: Re: UIO / of_genirq driver
Message-ID: <20101203155031.GC5636@pengutronix.de>
References: <1d3f23371001272313i62fc9158se4cd9173f196fb12@mail.gmail.com>
	<20100128104545.GA3105@pengutronix.de>
	<201012031643.31428.sr@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WfZ7S8PLGjBY9Voh"
In-Reply-To: <201012031643.31428.sr@denx.de>
Cc: hjk@linutronix.de, devicetree-discuss <devicetree-discuss@lists.ozlabs.org>,
	gregkh@suse.de, Linux Kernel list <linux-kernel@vger.kernel.org>,
	linuxppc-dev@lists.ozlabs.org, John Williams <john.williams@petalogix.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--WfZ7S8PLGjBY9Voh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> Is there any update on this in the meantime? Do you know of any plans to =
re-
> work/-push this patchset? Just checking...

I had another look recently; I wouldn't like to just copy/paste the
"new_id"-mechanism from PCI because the code would then exist three
times in the kernel (PCMCIA being the third user I am aware of). I
wondered if it was feasible to make the "new-id"-code generic and make
those subsystems just use it. I haven't started working on it, though.

Kind regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--WfZ7S8PLGjBY9Voh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkz5EccACgkQD27XaX1/VRuMWQCdF8iOdjY8DK3GeACA1YbVY/qX
oVkAniWPpN9kz0GSvHQJuDUZ18Jf0OgD
=8Ygy
-----END PGP SIGNATURE-----

--WfZ7S8PLGjBY9Voh--
