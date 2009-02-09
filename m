Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id E01E0DDD1B
	for <linuxppc-dev@ozlabs.org>; Mon,  9 Feb 2009 17:50:56 +1100 (EST)
Date: Mon, 9 Feb 2009 17:50:43 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Sachin P. Sant" <sachinp@in.ibm.com>
Subject: Re: 2.6.29-rc4-git1 build break : cell/spu_profiler.o
Message-Id: <20090209175043.04889757.sfr@canb.auug.org.au>
In-Reply-To: <498FD09D.2070207@in.ibm.com>
References: <498FD09D.2070207@in.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Mon__9_Feb_2009_17_50_43_+1100_CO+r+h28L77lbVGU"
Cc: Mel Gorman <mel@csn.ul.ie>, linuxppc-dev@ozlabs.org, arnd@arndb.de,
	Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Mon__9_Feb_2009_17_50_43_+1100_CO+r+h28L77lbVGU
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Sachin,

On Mon, 09 Feb 2009 12:13:41 +0530 "Sachin P. Sant" <sachinp@in.ibm.com> wr=
ote:
>
> 2.6.29-rc4-git1 randconfig build on powerpc fails with
>=20
>   CALL    arch/powerpc/kernel/prom_init_check.sh
>   CC [M]  arch/powerpc/oprofile/cell/spu_profiler.o
> arch/powerpc/oprofile/cell/spu_profiler.c: In function set_spu_profiling_=
frequency:
> arch/powerpc/oprofile/cell/spu_profiler.c:52: error: ppc_proc_freq undecl=
ared (first use in this function)
> arch/powerpc/oprofile/cell/spu_profiler.c:52: error: (Each undeclared ide=
ntifier is reported only once
> arch/powerpc/oprofile/cell/spu_profiler.c:52: error: for each function it=
 appears in.)
> make[1]: *** [arch/powerpc/oprofile/cell/spu_profiler.o] Error 1
> make: *** [arch/powerpc/oprofile] Error 2

See http://patchwork.ozlabs.org/patch/22628/

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__9_Feb_2009_17_50_43_+1100_CO+r+h28L77lbVGU
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkmP0kMACgkQjjKRsyhoI8wwlwCfZJ34WciOJudPOTTWaZXt1mTL
8+MAoIhiMt58woHG35lyjt0+6w5Eu4P0
=BwRE
-----END PGP SIGNATURE-----

--Signature=_Mon__9_Feb_2009_17_50_43_+1100_CO+r+h28L77lbVGU--
