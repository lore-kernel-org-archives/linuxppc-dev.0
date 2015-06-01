Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 816031A0CC7
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Jun 2015 17:42:58 +1000 (AEST)
Date: Mon, 1 Jun 2015 17:29:22 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH kernel v11 25/34] powerpc/powernv/ioda2: Introduce
 helpers to allocate TCE pages
Message-ID: <20150601072922.GO22789@voom.redhat.com>
References: <1432889098-22924-1-git-send-email-aik@ozlabs.ru>
 <1432889098-22924-26-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="FhKpTYimqQF2+bfE"
In-Reply-To: <1432889098-22924-26-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--FhKpTYimqQF2+bfE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2015 at 06:44:49PM +1000, Alexey Kardashevskiy wrote:
> This is a part of moving TCE table allocation into an iommu_ops
> callback to support multiple IOMMU groups per one VFIO container.
>=20
> This moves the code which allocates the actual TCE tables to helpers:
> pnv_pci_ioda2_table_alloc_pages() and pnv_pci_ioda2_table_free_pages().
> These do not allocate/free the iommu_table struct.
>=20
> This enforces window size to be a power of two.
>=20
> This should cause no behavioural change.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--FhKpTYimqQF2+bfE
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVbAnSAAoJEGw4ysog2bOSLBYP+gLyV0Le2bSJNjttxeF+8aIk
161l7uwPBO+j/efxrBnQlnFe39T2UVNx70PbY9v+lGFma+j+6b/x6cDVZovLUm4G
CI+V9YLvQtDzCnysoiajFx/X9A16eic8TOfCpUDa0eFrSVJHjY04YY73hW6G+gmp
Ga8b05EOuDLYq+sLlDGx4DiBaiqODrTKfmZOyK8k2WF5NN0sahLnDZXV6kQSznP4
pAjSHwdB31EHZq1tOJJpzmUEeInpEWBJnNQy4Db2l96oZxyQdjh6+mBHV51tK259
dffJbZidfTZNvPr+5JPLEjdr6mYlhV79yhKN6/nZP1rLWyNUsUK0VfHxtVeaEM0q
RAA6AofIo8bpbrI5dxXiQKEo9XpuKJwP7+O2uUX2chTFULKzhshtyXY5iGylgi0N
1IV0mlD/0Dsdd9GNNMnUTT3qi+YBPMMaipOa+HbzOOfFotY5mIuUN603AH6ARIWi
BIZDK9fRj1Tcx//mQQ6NkBGpg9E4wtzktGF103OvitT0AuEoq/5LloHDFaZRpSv7
xytApr5mYNvoPSrYfwCMQLtP+BQv/KIPqE5cEbVadHi0a/p2cH86h6qWGOmu4clm
pDupE1Oz8+w4QPArquqlirhxJUZEi2Ty7w/bRgEP/K0nIi3XGNtp69MmnijoLNHZ
ETbRUSueV3UtirKRa7m6
=LT7K
-----END PGP SIGNATURE-----

--FhKpTYimqQF2+bfE--
