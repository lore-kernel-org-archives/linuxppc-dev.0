Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5A49D1A005A
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Jun 2015 11:40:17 +1000 (AEST)
Date: Tue, 2 Jun 2015 10:47:20 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH kernel v11 29/34] powerpc/powernv/ioda2: Use new helpers
 to do proper cleanup on PE release
Message-ID: <20150602004720.GB3186@voom.fritz.box>
References: <1432889098-22924-1-git-send-email-aik@ozlabs.ru>
 <1432889098-22924-30-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Y7xTucakfITjPcLV"
In-Reply-To: <1432889098-22924-30-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--Y7xTucakfITjPcLV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2015 at 06:44:53PM +1000, Alexey Kardashevskiy wrote:
> The existing code programmed TVT#0 with some address and then
> immediately released that memory.
>=20
> This makes use of pnv_pci_ioda2_unset_window() and
> pnv_pci_ioda2_set_bypass() which do correct resource release and
> TVT update.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Y7xTucakfITjPcLV
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVbP0YAAoJEGw4ysog2bOSwecQALCiYs7kkKCZLk6Uu9N1uePm
s+4z3Vasc0np1PYvAdqHmf3MSccXesaDvecAk5o0g1bywimAq3ea+xtnlbKSee8g
MI0q7ijZH+W551uZ6B7PkDLDrEa4V18QIDr21XJEVcSNYTTcs0Ir4nEJ+UooMvfg
48LOGrJmA36kSZZuBY0FN7P4NnXz/9HGB3ZVoNffsGrh5BXjVbwhz8TUc0PoD7UL
4Hy7DW1YuCi7/tIPk3nUN+eDT2BiT81Du9mYN4cXGOCqGPGndPJP59rl4TCIaIkq
oKMUaa6uYHsp5MAioLepAkAJehWrlEHzxHYx479lWRpJrjfXrtCSfZTLuarcGH6L
2ZJVvdYl3/Dbb+jPcqfz6BUJ5iwaLr8hkvkYBFUDZjz6WTiDicIzkmD2jazXKB91
FCNEZ/e8imtljZeaeWuyyryyp7+ohbqpoxmCan6RxjHEp+prhYZGPVYjvZpFYsbo
MWOuyRQg/OrxuCi+A5yyYllEJk8ax833AYpAanCupARlxS4j+mCOgs2Sg42o96Ts
br/8JijpI90MHpPxV3Y/+0CUbZYiiiRLASy4cfb6cFIUOZ6wRSgioKDTdu0TOtvl
GtRjgik0emfsiHW+vkM+tw988ho2jzHudtzhgEt3/0pcRghjccvWBreSa8fp2QZy
u41+H5XzrkS9tWJd/Au7
=zU7t
-----END PGP SIGNATURE-----

--Y7xTucakfITjPcLV--
