Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id CC416DDF4D
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jul 2008 10:15:39 +1000 (EST)
Date: Mon, 28 Jul 2008 10:15:33 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] isdn: mISDN HFC PCI support depends on virt_to_bus()
Message-Id: <20080728101533.beb1250d.sfr@canb.auug.org.au>
In-Reply-To: <20080727182709.1dac0556@lxorguk.ukuu.org.uk>
References: <20080728023732.090aff83.sfr@canb.auug.org.au>
	<20080727182709.1dac0556@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Mon__28_Jul_2008_10_15_33_+1000_GNfKP+ALpr7twsJe"
Cc: ppc-dev <linuxppc-dev@ozlabs.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>,
	Karsten Keil <kkeil@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Mon__28_Jul_2008_10_15_33_+1000_GNfKP+ALpr7twsJe
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, 27 Jul 2008 18:27:09 +0100 Alan Cox <alan@lxorguk.ukuu.org.uk> wrot=
e:
>
> On Mon, 28 Jul 2008 02:37:32 +1000 Stephen Rothwell <sfr@canb.auug.org.au=
> wrote:
>=20
> > On powerpc (allyesconfig build) we get this error:
> >=20
> > drivers/isdn/hardware/mISDN/hfcpci.c:1991: error: implicit declaration =
of function 'virt_to_bus'
> >=20
> > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
>=20
> Can we please not merge new virt_to_bus users and instead fix the actual
> code to use the right functions?

Absolutely.  But I currently just want my trees to build (I am a bear of
little brain with simple needs :-))

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__28_Jul_2008_10_15_33_+1000_GNfKP+ALpr7twsJe
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkiND6UACgkQjjKRsyhoI8yh8gCdFxS/DySxGjWUC7Poy80amb4C
g+0An2LFyxLwKXjyJ4X068RjUKL42yb4
=CF5w
-----END PGP SIGNATURE-----

--Signature=_Mon__28_Jul_2008_10_15_33_+1000_GNfKP+ALpr7twsJe--
