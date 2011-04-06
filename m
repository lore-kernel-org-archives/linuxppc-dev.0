Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 77AA7B6EF7
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Apr 2011 15:41:53 +1000 (EST)
Date: Wed, 6 Apr 2011 15:41:47 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [RFC][PATCH] powerpc/book3e: Fix CPU feature handling on e5500
Message-Id: <20110406154147.f736d92e.sfr@canb.auug.org.au>
In-Reply-To: <1302067772-32104-1-git-send-email-galak@kernel.crashing.org>
References: <1302067772-32104-1-git-send-email-galak@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__6_Apr_2011_15_41_47_+1000_xR3vMXKWYnzvf3Fn"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Wed__6_Apr_2011_15_41_47_+1000_xR3vMXKWYnzvf3Fn
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Kumar,

On Wed,  6 Apr 2011 00:29:32 -0500 Kumar Gala <galak@kernel.crashing.org> w=
rote:
>
> * I'm concerned if its ok to assume 'enum' can handle a 64-bit mask or no=
t.
>   I'm assuming this is the reason that we use a #define on __powerpc64__

enums are *ints* and therefore 32 bit.  gcc can cope, but warns about it
(I think). So we must use the #define if any of the included bits are
above 2^32.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__6_Apr_2011_15_41_47_+1000_xR3vMXKWYnzvf3Fn
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJNm/0bAAoJEDMEi1NhKgbs6ZMIAJB9wuVzYj1ov/X9nGjGPNob
YN26D61whbf7RNFN3tl1w8jyws2phr+iAZiV1VAbRJHFUix0Rw6CxCX3wALh2apA
Jr/zksXR3GpPt3IDV0thJE7UHWfqP4xEMNtDu6Ul4p3z0+rEjgpEzbf7nR8F1xLF
z2caPy46WznJLTKi8v2/THaygjGvSJeQEHWeXJaSCJdLW0Ya+umPvQkIVt42oCik
aDjFEHzC8ptbDQWcrEoHy0I6hHTLaqAZZf5n3tJKpXGtr1KJOhY4iaOahIpiGFmx
mSqiC6fIZUTrKHqcgpC0t5tR1SNb4O+tYki/tg23U6trtsqB3KeN5De1ANTPJ8g=
=YCoy
-----END PGP SIGNATURE-----

--Signature=_Wed__6_Apr_2011_15_41_47_+1000_xR3vMXKWYnzvf3Fn--
