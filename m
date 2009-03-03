Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id D3101DDEFD
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Mar 2009 13:52:09 +1100 (EST)
Date: Tue, 3 Mar 2009 13:52:03 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: powerpc allnoconfig
Message-Id: <20090303135203.b36312a0.sfr@canb.auug.org.au>
In-Reply-To: <20090302184049.27a73395.akpm@linux-foundation.org>
References: <20090302171948.d1e2aa00.akpm@linux-foundation.org>
	<12051.1236047470@neuling.org>
	<20090302184049.27a73395.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__3_Mar_2009_13_52_03_+1100_Bv7+4TMJ.=VMXHlt"
Cc: linuxppc-dev@ozlabs.org, Michael Neuling <mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__3_Mar_2009_13_52_03_+1100_Bv7+4TMJ.=VMXHlt
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Mon, 2 Mar 2009 18:40:49 -0800 Andrew Morton <akpm@linux-foundation.org>=
 wrote:
>
> It's a cross-compiler: http://userweb.kernel.org/~akpm/cross-compilers/

What does
"/opt/crosstool/gcc-4.1.0-glibc-2.3.6/powerpc64-unknown-linux-gnu/bin/power=
pc64-unknown-linux-gnu-gcc -v" say?

I suspect you have a 64 bit only compiler and allnoconfig produces a 32
bit kernel.  Is this a new error?

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__3_Mar_2009_13_52_03_+1100_Bv7+4TMJ.=VMXHlt
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkmsm1MACgkQjjKRsyhoI8xG7wCbB6xgQ8ke/DmFlSNReOQs73uG
XWEAn0ByYDxvrbAEtavOIDl6AYhfxoKv
=E9I+
-----END PGP SIGNATURE-----

--Signature=_Tue__3_Mar_2009_13_52_03_+1100_Bv7+4TMJ.=VMXHlt--
