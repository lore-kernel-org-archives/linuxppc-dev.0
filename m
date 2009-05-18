Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 72B83DE064
	for <linuxppc-dev@ozlabs.org>; Mon, 18 May 2009 15:47:26 +1000 (EST)
Date: Mon, 18 May 2009 15:47:21 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH]  bug fix in arch/powerpc/mm/tlb_nohash_low.S
Message-Id: <20090518154721.0a9c3dee.sfr@canb.auug.org.au>
In-Reply-To: <1242623523.18075.39.camel@pasglop>
References: <1242622146.31702.26.camel@torez.austin.ibm.com>
	<1242623523.18075.39.camel@pasglop>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Mon__18_May_2009_15_47_21_+1000_.KFVVWCrW.fFSAdQ"
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Torez Smith <lnxtorez@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Mon__18_May_2009_15_47_21_+1000_.KFVVWCrW.fFSAdQ
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ben,

On Mon, 18 May 2009 15:12:03 +1000 Benjamin Herrenschmidt <benh@kernel.cras=
hing.org> wrote:
>
> Thanks, but it's been fixed already :-)
>=20
> See commit b62c31ae401c6df25c61b206681a6e904ef97169.

Should this be submitted for 2.6.29 stable?

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__18_May_2009_15_47_21_+1000_.KFVVWCrW.fFSAdQ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkoQ9mkACgkQjjKRsyhoI8w2kACgpOiTZpFxQQkZB0tHM5M1GkmS
S/AAn0JUm0sFbY3bEQm28Y0BhRPbP+zY
=PJg5
-----END PGP SIGNATURE-----

--Signature=_Mon__18_May_2009_15_47_21_+1000_.KFVVWCrW.fFSAdQ--
