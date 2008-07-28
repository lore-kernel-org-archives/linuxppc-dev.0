Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id DE6DEDDF83
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jul 2008 10:20:43 +1000 (EST)
Date: Mon, 28 Jul 2008 10:20:35 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] isdn: mISDN HFC PCI support depends on virt_to_bus()
Message-Id: <20080728102035.8a2f5723.sfr@canb.auug.org.au>
In-Reply-To: <20080727.161432.237385384.davem@davemloft.net>
References: <20080727182709.1dac0556@lxorguk.ukuu.org.uk>
	<20080727.125604.73857337.davem@davemloft.net>
	<adamyk35aoi.fsf@cisco.com>
	<20080727.161432.237385384.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Mon__28_Jul_2008_10_20_35_+1000_8Dh=CkFJWb7nz5=O"
Cc: kkeil@suse.de, rdreier@cisco.com, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, akpm@linux-foundation.org,
	torvalds@linux-foundation.org, alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Mon__28_Jul_2008_10_20_35_+1000_8Dh=CkFJWb7nz5=O
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dave,

On Sun, 27 Jul 2008 16:14:32 -0700 (PDT) David Miller <davem@davemloft.net>=
 wrote:
>
> The driver went directly into Linus's tree.
>=20
> Stephen hit the build problem once he synced linux-next up with
> Linus's current tree.

It didn't even get as far as linux-next, I was just browsing the
bloodbath that is/was Linus' tree
(http://kisskb.ellerman.id.au/kisskb/branch/3/) :-(.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__28_Jul_2008_10_20_35_+1000_8Dh=CkFJWb7nz5=O
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkiNENMACgkQjjKRsyhoI8zx+ACfUUeLkOPOgV2Gs8Y9bfiC+V9d
L/MAni7xOGxtSzIaaYYS/xErKv54tAaw
=Wi4t
-----END PGP SIGNATURE-----

--Signature=_Mon__28_Jul_2008_10_20_35_+1000_8Dh=CkFJWb7nz5=O--
