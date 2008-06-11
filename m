Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id ACFB2DDEDA
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jun 2008 19:27:58 +1000 (EST)
Date: Wed, 11 Jun 2008 19:27:48 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: linux-next: powerpc build failure
Message-Id: <20080611192748.686236fd.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__11_Jun_2008_19_27_48_+1000_bYvf7rdRWHA=kzf6"
Cc: linuxppc-dev@ozlabs.org, linux-next@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__11_Jun_2008_19_27_48_+1000_bYvf7rdRWHA=kzf6
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next build (powerpc allyesconfig) failed like this:

vmlinux.o: In function `ipx_ioctl':
/scratch/sfr/next/net/ipx/af_ipx.c:1830: relocation truncated to fit: R_PPC=
64_REL24 against symbol `._mcount' defined in .text section in vmlinux.o

(and lots more similar)

I am assuming that this has something to do with how big vmlinux is for
allyesconfig and the addition of -pg to KBUILD_CFLAGS for ftrace.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__11_Jun_2008_19_27_48_+1000_bYvf7rdRWHA=kzf6
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhPmpQACgkQTgG2atn1QN8EsgCgmPnYeRCAPOMgE2zSgPjLpXUF
ycUAn3HXoodQ+2YO2zNLFtF4MZs7liLe
=aQlN
-----END PGP SIGNATURE-----

--Signature=_Wed__11_Jun_2008_19_27_48_+1000_bYvf7rdRWHA=kzf6--
