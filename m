Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 31B71B7099
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 27 Aug 2009 17:10:29 +1000 (EST)
Date: Thu, 27 Aug 2009 17:10:16 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: ppc64 allnoconfig build warning
Message-Id: <20090827171016.dbdefaf9.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__27_Aug_2009_17_10_16_+1000_uVjxyMIz0YkE4aC."
Cc: ppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Thu__27_Aug_2009_17_10_16_+1000_uVjxyMIz0YkE4aC.
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ben,

WARNING: vmlinux.o(.text+0x1d864): Section mismatch in reference from the f=
unction .dma_direct_dma_supported() to the function .init.text:.lmb_end_of_=
DRAM()
The function .dma_direct_dma_supported() references
the function __init .lmb_end_of_DRAM().
This is often because .dma_direct_dma_supported lacks a __init=20
annotation or the annotation of .lmb_end_of_DRAM is wrong.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__27_Aug_2009_17_10_16_+1000_uVjxyMIz0YkE4aC.
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkqWMVgACgkQjjKRsyhoI8ypGwCgulcj4mamdgIqzNM2bUjdpAzF
4aUAoKhZP5Kf1I3NyE/vEH3euUUvyY9g
=ygRF
-----END PGP SIGNATURE-----

--Signature=_Thu__27_Aug_2009_17_10_16_+1000_uVjxyMIz0YkE4aC.--
