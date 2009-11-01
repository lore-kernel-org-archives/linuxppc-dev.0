Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id B5BC3B7C4A
	for <linuxppc-dev@ozlabs.org>; Sun,  1 Nov 2009 22:41:35 +1100 (EST)
Date: Sun, 1 Nov 2009 22:41:29 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Giuseppe Coviello <cjg@cruxppc.org>
Subject: Re: Fail building 2.6.31.x for CHRP using gcc-4.4.x
Message-Id: <20091101224129.4ea50c7b.sfr@canb.auug.org.au>
In-Reply-To: <a265241c0911010117m65335b80g94457a07d0610cbe@mail.gmail.com>
References: <a265241c0911010117m65335b80g94457a07d0610cbe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Sun__1_Nov_2009_22_41_29_+1100_S=45ue82K.1Ch1mz"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Sun__1_Nov_2009_22_41_29_+1100_S=45ue82K.1Ch1mz
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Giuseppe,

On Sun, 1 Nov 2009 10:17:00 +0100 Giuseppe Coviello <cjg@cruxppc.org> wrote:
>
> Hi, we are having trouble while building kernel 2.6.31.x and also
> 2.6.32rc for CHRP platforms using gcc-4.4.x, the error that give us
> the compilation is:
>=20
>   CC      arch/powerpc/sysdev/indirect_pci.o
>   CC      arch/powerpc/sysdev/i8259.o
>   LD      arch/powerpc/sysdev/built-in.o
>   CC      arch/powerpc/platforms/chrp/setup.o
> cc1: warnings being treated as errors
> arch/powerpc/platforms/chrp/setup.c: In function 'chrp_event_scan':
> arch/powerpc/platforms/chrp/setup.c:378: error: the frame size of 1040
> bytes is larger than 1024 bytes
> make[2]: *** [arch/powerpc/platforms/chrp/setup.o] Error 1
> make[1]: *** [arch/powerpc/platforms/chrp] Error 2
> make: *** [arch/powerpc/platforms] Error
>=20
> The same kernel, with the same configuration builds fine using gcc-4.3.x.

For now, just enable CONFIG_PPC_DISABLE_WERROR.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sun__1_Nov_2009_22_41_29_+1100_S=45ue82K.1Ch1mz
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkrtc+kACgkQjjKRsyhoI8x+wQCfTaFq20RsZ6K0ynxFKOmwBDSU
HxYAoJOPrHXMPR/RmzzkBi/3okZ4IZds
=uyLf
-----END PGP SIGNATURE-----

--Signature=_Sun__1_Nov_2009_22_41_29_+1100_S=45ue82K.1Ch1mz--
