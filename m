Return-Path: <marc.leeman@gmail.com>
Date: Thu, 21 Jun 2007 21:09:36 +0200
From: Marc Leeman <marc.leeman@gmail.com>
To: Matt Sealey <matt@genesi-usa.com>
Subject: Re: network load 8245 vs. 8347E
Message-ID: <20070621190936.GU5417@chiana.homelinux.org>
References: <20070621141519.GQ5417@chiana.homelinux.org>
	<0090CCD0-EBB4-4475-BF03-36AF41E2DDA1@kernel.crashing.org>
	<20070621155616.GR5417@chiana.homelinux.org>
	<20070621171340.GS5417@chiana.homelinux.org>
	<467ABCDC.8060401@genesi-usa.com>
	<20070621183349.GT5417@chiana.homelinux.org>
	<467AC93C.2020408@genesi-usa.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WVf18ZLo9bznw8Mz"
In-Reply-To: <467AC93C.2020408@genesi-usa.com>
Cc: Linuxppc-dev@ozlabs.org
Reply-To: Marc Leeman <marc.leeman@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--WVf18ZLo9bznw8Mz
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> You might just be lucky that 2.4 is less bloated and has to handle less
> features than 2.6 and it's lowering the CPU usage :)

Actually, I backported the e100 driver from the 2.6 series to the 2.4
series. It performed better. Perhaps I should re-sync again with what is
currently in the 2.6, but as I said, not much work is put in the older
platforms due to a load of proto 8347e boards being ported..

--=20
  greetz, marc
Long enough for me to see your blue backside meditating, but not long
enough for you to touch me.
	Rygel - PK Tech Girl
chiana 2.6.18-4-ixp4xx #1 Tue Mar 27 18:01:56 BST 2007 GNU/Linux

--WVf18ZLo9bznw8Mz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGeszvUQpj09NWLeERAtlvAJ49+mvuW4NHIXLC511jHW6N2G7DEACfSQIY
or7EJ3KbmlRv3NCfm85+bxg=
=SOqI
-----END PGP SIGNATURE-----

--WVf18ZLo9bznw8Mz--
