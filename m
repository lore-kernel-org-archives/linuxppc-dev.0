Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 82408DDD0C
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Oct 2008 19:13:35 +1100 (EST)
Date: Tue, 21 Oct 2008 19:13:24 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: build failure on powerpc with current -git
Message-Id: <20081021191324.d4810d40.sfr@canb.auug.org.au>
In-Reply-To: <18685.27030.529655.761257@cargo.ozlabs.ibm.com>
References: <48F8E86B.702@nortel.com>
	<18685.27030.529655.761257@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__21_Oct_2008_19_13_24_+1100_yTaNXRAow3v+=FeB"
Cc: Linux, kernel <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__21_Oct_2008_19_13_24_+1100_yTaNXRAow3v+=FeB
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Paulus,

On Tue, 21 Oct 2008 16:33:10 +1100 Paul Mackerras <paulus@samba.org> wrote:
>
> It's a bug in older versions of ld (including 2.16.1) that's fixed in
> the current version (2.18).  However, this patch appears to work
> around the problem - at least, it let me build a 32-bit kernel with a
> cross-toolchain including a 2.16.1 ld.  Let me know if this gets it
> working for you.

With that patch applied I got these errors for a powerpc ppc64_defconfig
build (linux-next).

/usr/bin/objcopy: Warning: '/dev/null' is not an ordinary file
make[2]: *** [arch/powerpc/boot/zImage.pmac] Error 1
make[2]: *** Waiting for unfinished jobs....
/usr/bin/objcopy: Warning: '/dev/null' is not an ordinary file
make[2]: *** [arch/powerpc/boot/zImage.pseries] Error 1
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__21_Oct_2008_19_13_24_+1100_yTaNXRAow3v+=FeB
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkj9jyQACgkQjjKRsyhoI8w9yACfWKeMDbrd+UnysP1+LceONeGj
UxEAoLbraQzCB2HYZzYx2BX2EYytkenX
=gnzE
-----END PGP SIGNATURE-----

--Signature=_Tue__21_Oct_2008_19_13_24_+1100_yTaNXRAow3v+=FeB--
