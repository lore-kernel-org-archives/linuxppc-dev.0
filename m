Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id EDB84DDFE6
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jul 2008 10:32:59 +1000 (EST)
Date: Mon, 28 Jul 2008 10:32:53 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] powerpc/ibmveth: fix multiple errors with
	dma_mapping_error conversion
Message-Id: <20080728103253.5256e6c0.sfr@canb.auug.org.au>
In-Reply-To: <20080727122414.cac4e336.akpm@linux-foundation.org>
References: <20080728021424.40cf66bc.sfr@canb.auug.org.au>
	<20080727122414.cac4e336.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Mon__28_Jul_2008_10_32_53_+1000_0JQ_/qAiFWNDz46v"
Cc: Jeff Garzik <jeff@garzik.org>, LKML <linux-kernel@vger.kernel.org>,
	FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
	ppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Mon__28_Jul_2008_10_32_53_+1000_0JQ_/qAiFWNDz46v
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Sun, 27 Jul 2008 12:24:14 -0700 Andrew Morton <akpm@linux-foundation.org=
> wrote:
>
> On Mon, 28 Jul 2008 02:14:24 +1000 Stephen Rothwell <sfr@canb.auug.org.au=
> wrote:
>=20
> > The addition of an argument to dma_mapping_error() in commit
> > 8d8bb39b9eba32dd70e87fd5ad5c5dd4ba118e06 "dma-mapping: add the device
> > argument to dma_mapping_error()" left a bit of fallout:
>=20
> Yeah, sorry, that patch was a horror - I fixed it perhaps ten times.  I
> think people were madly adding new dma_mapping_error() calls while we
> were trying to maintain it as well.
>=20
> It should have been dome as a two-stage conversion.

Yes, indeed (my new favourite word :-))

I hope that we all can discuss procedures for API changes at the Kernel
Summit ...

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__28_Jul_2008_10_32_53_+1000_0JQ_/qAiFWNDz46v
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkiNE7UACgkQjjKRsyhoI8zTcgCePJJdfrTRzlwHIQkh2vwNv3Ax
AxUAn0VftUIy32jvnG+ULTZqvOc6dmi8
=9/z9
-----END PGP SIGNATURE-----

--Signature=_Mon__28_Jul_2008_10_32_53_+1000_0JQ_/qAiFWNDz46v--
