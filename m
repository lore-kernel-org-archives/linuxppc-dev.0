Return-Path: <j.neuschaefer@gmx.net>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zmk7p6TQgzF103
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Feb 2018 03:53:09 +1100 (AEDT)
Date: Wed, 21 Feb 2018 17:52:57 +0100
From: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: Christophe LEROY <christophe.leroy@c-s.fr>
Cc: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
 linuxppc-dev@lists.ozlabs.org, Joel Stanley <joel@jms.id.au>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 0/6] DISCONTIGMEM support for PPC32
Message-ID: <20180221165257.kyf35ifr4ndblowt@latitude>
References: <20180220161424.5421-1-j.neuschaefer@gmx.net>
 <193a407d-e6b8-9e29-af47-3d401b6414a0@c-s.fr>
 <20180221144240.pfu2run3pixt3pzo@latitude>
 <a36983ec-5e97-e968-8143-1b2615ea55f8@c-s.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="okldkbspm4p3rco7"
In-Reply-To: <a36983ec-5e97-e968-8143-1b2615ea55f8@c-s.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--okldkbspm4p3rco7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2018 at 04:02:25PM +0100, Christophe LEROY wrote:
[...]
> > > My question might me stupid, as I don't know PCC64 in deep, but when =
looking
> > > at page_is_ram() in arch/powerpc/mm/mem.c, I have the feeling the PPC=
64
> > > implements ram by blocks. Isn't it what you are trying to achieve ? W=
ouldn't
> > > it be feasible to map to what's done in PPC64 for PPC32 ?
> >=20
> > Using page_is_ram in __ioremap_caller and the same memblock-based
> > approach that's used on PPC64 on PPC32 *should* work, but I think due to
> > the following line in initmem_init, it won't:
> >=20
> > 	memblock_set_node(0, (phys_addr_t)ULLONG_MAX, &memblock.memory, 0);
>=20
> Can't we just fix that ?

I'll give it a try.


Thanks,
Jonathan Neusch=C3=A4fer

--okldkbspm4p3rco7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAABAgAGBQJajaPhAAoJEAgwRJqO81/b+aAP/A8ieDpgUlAvsfT1R0W2JTwZ
fWSbAAewS0RNzEyDXJMKuhPHPIFsed0oBGKLd2MelE0DPqIqAab+nC8gtXjFWcWT
ze47sr01w+ePMhnX3UtVT71WFXMYlYder8iaj3CTBtNFSAZlt7hgouHFRDuqXos9
IogPzpgqsHml/4rOP0Qr/i9EKmCeXOKW4jRI3xTxTOUlaJaxbWUky+7CofvxRXpc
quq3ljk6SlBXeiZuskiN9u3g7h1uBfRXsl50QH/XrRaMZB5xVyzUSbT5hSHdmI1b
F/XS54jsZVFN0PcUOTg8E5XuLYA9/fZPxk/9+XwrI854VU5Br9qFmCW4grwsMIVE
efJEft6/2LRlZsLh2M/iJKNJ7isFKbzwI96x5SqT0lpY2QdrXYrlTWlWQY9UpMIY
urWQxOPogQ1LCqgKyi7aTBcWJh5VQ/imU4a91SancINfUMu0fpGkdquhCFLoLpTK
ZvkzsRJdLoy/urFxXFoWOsIeiz0MoHPW7dCfU9qZx/7jj3DQojqBxtltmrVXZdEc
bgOTMGGiYe2E6cbA6pXgVCNpbL0VqEzlc8Wkb3AQQCQbvZf+A5y1bLp7boHRD91z
zsmDfdCDxkbXqNhSKaBSwlO9zQIElbPauoidd2zDu3WBPH0CLPMr7P1o63By7HKA
6t8sFNQ2NavTaYaFH6Ij
=H5py
-----END PGP SIGNATURE-----

--okldkbspm4p3rco7--
