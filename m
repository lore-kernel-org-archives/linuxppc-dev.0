Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id ECE55B6F1B
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Jan 2010 14:01:42 +1100 (EST)
Date: Tue, 12 Jan 2010 14:01:36 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH]: powerpc: Fix build breakage due to incorrect location
	of autoconf.h
Message-Id: <20100112140136.c8ccc357.sfr@canb.auug.org.au>
In-Reply-To: <20100112022150.GE12666@kryten>
References: <20100112022150.GE12666@kryten>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__12_Jan_2010_14_01_36_+1100_W5vxqymXTs11J3wT"
Cc: Roel Kluin <roel.kluin@gmail.com>, linuxppc-dev@ozlabs.org,
	Richard Purdie <rpurdie@rpsys.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Tue__12_Jan_2010_14_01_36_+1100_W5vxqymXTs11J3wT
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Anton,

On Tue, 12 Jan 2010 13:21:51 +1100 Anton Blanchard <anton@samba.org> wrote:
>
> commit ac4c2a3bbe5db5fc570b1d0ee1e474db7cb22585 (zlib: optimize inffast w=
hen
> copying direct from output) referenced include/linux/autoconf.h which
> is now called include/generated/autoconf.h.

Even with this fix, you cannot build with a separate object directory.
See my other posting "linux-next: origin tree build failure" ...
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__12_Jan_2010_14_01_36_+1100_W5vxqymXTs11J3wT
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAktL5hAACgkQjjKRsyhoI8xzAQCfdPIxGYZ7g7yIIs3BiEc62aZz
UK4AmgMCDS2mo+QHAVzjQU6MmMyj0bCH
=x36t
-----END PGP SIGNATURE-----

--Signature=_Tue__12_Jan_2010_14_01_36_+1100_W5vxqymXTs11J3wT--
