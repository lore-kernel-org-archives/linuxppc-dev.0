Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 6E60B1007D3
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Nov 2009 17:25:48 +1100 (EST)
Date: Tue, 24 Nov 2009 17:25:42 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: Fix bug in gup_hugepd()
Message-Id: <20091124172542.1eece8ac.sfr@canb.auug.org.au>
In-Reply-To: <20091124060340.GE2737@yookeroo>
References: <20091124060340.GE2737@yookeroo>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__24_Nov_2009_17_25_42_+1100_MMRNPWt8qQLyFnhY"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Tue__24_Nov_2009_17_25_42_+1100_MMRNPWt8qQLyFnhY
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi David,

On Tue, 24 Nov 2009 17:03:40 +1100 David Gibson <david@gibson.dropbear.id.a=
u> wrote:
>
> Commit a4fe3ce7699bfe1bd88f816b55d42d8fe1dac655 introduced a new

When you quote a SHA1, please also quote the summary line for the commit
so those without git access may find it.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__24_Nov_2009_17_25_42_+1100_MMRNPWt8qQLyFnhY
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAksLfGYACgkQjjKRsyhoI8yYYwCgjxcpBO5BmBws9av6bl65yXXH
P60An0sdjRveSwq0a3lOjdiOyRxcFHv4
=hLB9
-----END PGP SIGNATURE-----

--Signature=_Tue__24_Nov_2009_17_25_42_+1100_MMRNPWt8qQLyFnhY--
