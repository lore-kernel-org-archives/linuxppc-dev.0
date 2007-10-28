Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 4042FDDF81
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Oct 2007 10:50:16 +1100 (EST)
Date: Mon, 29 Oct 2007 10:50:05 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v2] pcmcia: Remove replace kio_addr_t with unsigned int
	everywhere
Message-Id: <20071029105005.d85e212e.sfr@canb.auug.org.au>
In-Reply-To: <20071028201858.GA10048@lixom.net>
References: <20070905142742.GA1760@lixom.net>
	<20070914034854.1658a9cf.akpm@linux-foundation.org>
	<20070921221516.GA7926@lixom.net>
	<20070921233936.2aeb2504@the-village.bc.nu>
	<20070922062551.GE10625@parisc-linux.org>
	<20070922091303.GA12525@lst.de> <20071019201720.GA13234@lixom.net>
	<20071028134414.GF26943@isilmar.linta.de>
	<20071028201034.GB9472@lixom.net>
	<20071028201858.GA10048@lixom.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Mon__29_Oct_2007_10_50_05_+1100_/wj1YA2jLaKIDaIk"
Cc: Matthew Wilcox <matthew@wil.cx>, linux-pcmcia@lists.infradead.org,
	linux-kernel@vger.kernel.org, Alan, linuxppc-dev@ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, Cox <alan@lxorguk.ukuu.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Mon__29_Oct_2007_10_50_05_+1100_/wj1YA2jLaKIDaIk
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Olof,

diffstat output is very useful - especially for patches like this that
touch lots of files.  It makes it easier for potential reviewers to see
if they should be potential reviewers.  :-)

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__29_Oct_2007_10_50_05_+1100_/wj1YA2jLaKIDaIk
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHJSAyTgG2atn1QN8RAv7yAKCObr3GjbrpzJI8sXVagHeKbC0ZmgCfYFac
F/JZV1JYRRVd1IICT1KeiTo=
=Uyqn
-----END PGP SIGNATURE-----

--Signature=_Mon__29_Oct_2007_10_50_05_+1100_/wj1YA2jLaKIDaIk--
