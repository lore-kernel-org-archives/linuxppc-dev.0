Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id B7F22B7120
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 16 Jun 2009 16:43:02 +1000 (EST)
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id A70CDDDD04
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Jun 2009 16:43:02 +1000 (EST)
Date: Tue, 16 Jun 2009 16:42:57 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Greg KH <greg@kroah.com>
Subject: Re: linux-next: manual merge of the driver-core tree with the
	powerpc tree
Message-Id: <20090616164257.d7e8d460.sfr@canb.auug.org.au>
In-Reply-To: <20090616061849.GA32109@kroah.com>
References: <20090616155317.d1f1217e.sfr@canb.auug.org.au>
	<20090616061849.GA32109@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__16_Jun_2009_16_42_57_+1000_.Ru1NNGs2YwIrBQd"
Cc: Roel Kluin <roel.kluin@gmail.com>, linux-kernel@vger.kernel.org,
	ppc-dev <linuxppc-dev@ozlabs.org>, linux-next@vger.kernel.org,
	Geert, Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Tue__16_Jun_2009_16_42_57_+1000_.Ru1NNGs2YwIrBQd
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Greg,

On Mon, 15 Jun 2009 23:18:49 -0700 Greg KH <greg@kroah.com> wrote:
>
> I pushed out an update a number of hours ago (like 6+), so you should
> have gotten it with this update.
>=20
> When did you pull from my tree?  I also just sent a merge request to
> Linus, so everything should be fixed up now.

OK, thanks.  I fetch the trees usually between 8:30am and 10:00am UTC
+1000 (or +1100 in summer), so about 7 hours ago :-)

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__16_Jun_2009_16_42_57_+1000_.Ru1NNGs2YwIrBQd
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAko3PvEACgkQjjKRsyhoI8wx0QCdFcBRhrSoIDIYL6XzQvm9BdN9
EOsAn0oiH4BUvXJ1NuivpYnFhMIt0AH5
=uo5E
-----END PGP SIGNATURE-----

--Signature=_Tue__16_Jun_2009_16_42_57_+1000_.Ru1NNGs2YwIrBQd--
