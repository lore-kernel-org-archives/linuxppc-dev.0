Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 2E764DDE1F
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Dec 2008 15:44:29 +1100 (EST)
Date: Wed, 31 Dec 2008 15:44:24 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Roland Dreier <rdreier@cisco.com>
Subject: Re: [PATCH] infiniband/ehca: spin_lock_irqsave takes an unsigned long
Message-Id: <20081231154424.77961256.sfr@canb.auug.org.au>
In-Reply-To: <adaiqp1q8ky.fsf@cisco.com>
References: <20081231141257.9bafac41.sfr@canb.auug.org.au>
	<adaiqp1q8ky.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__31_Dec_2008_15_44_24_+1100_A+UYPYB7FLu+F9Fv"
Cc: Heiko J Schick <schickhj@de.ibm.com>, Joachim Fenkes <fenkes@de.ibm.com>,
	ppc-dev <linuxppc-dev@ozlabs.org>, Christoph Raisch <raisch@de.ibm.com>,
	general@lists.openfabrics.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__31_Dec_2008_15_44_24_+1100_A+UYPYB7FLu+F9Fv
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Roland,

On Tue, 30 Dec 2008 20:20:29 -0800 Roland Dreier <rdreier@cisco.com> wrote:
>
> are you trying to land the 'typedef unsigned long u64' change for
> 2.6.28, or can these patches wait for 2.6.29?

2.6.29 (or even 30), I would think at this point.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__31_Dec_2008_15_44_24_+1100_A+UYPYB7FLu+F9Fv
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkla+KgACgkQjjKRsyhoI8zaZgCdEUsLGMHYEkhxkooRAMUrv1YK
YbwAnihto3K6VbefZFrQZDeO2IOgVF8X
=q7R/
-----END PGP SIGNATURE-----

--Signature=_Wed__31_Dec_2008_15_44_24_+1100_A+UYPYB7FLu+F9Fv--
