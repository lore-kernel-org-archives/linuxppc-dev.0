Return-Path: <vapier@gentoo.org>
Received: from smtp.gentoo.org (smtp.gentoo.org [140.211.166.183])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 442161007D4
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Mar 2012 04:25:10 +1100 (EST)
From: Mike Frysinger <vapier@gentoo.org>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH 1/2] atomic: Allow atomic_inc_not_zero to be overridden
Date: Thu, 1 Mar 2012 12:19:14 -0500
References: <20120301180953.0f61576f@kryten>
In-Reply-To: <20120301180953.0f61576f@kryten>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1733415.TSW5sbkbnq";
 protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <201203011219.18114.vapier@gentoo.org>
Cc: eric.dumazet@gmail.com, linux-kernel@vger.kernel.org, paulus@samba.org,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org, asharma@fb.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--nextPart1733415.TSW5sbkbnq
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

On Thursday 01 March 2012 02:09:53 Anton Blanchard wrote:
> We want to implement a ppc64 specific version of atomic_inc_not_zero
> so wrap it in an ifdef to allow it to be overridden.

Acked-by: Mike Frysinger <vapier@gentoo.org>
-mike

--nextPart1733415.TSW5sbkbnq
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJPT6+VAAoJEEFjO5/oN/WB0dIP/1rmcRlyH6LDxo4zPnYU5dWE
X4+tGDj2nD2rQ0KTQsbB+HIhNzXOKkx2RrqVf/y28XpWl+hR4HOFfeQp7N6TG1Y4
LX0n253SFaSq0/3LUZYpuRh0WvJlqCoT9mherOr6EKd9+W4TJpaScz45MoYikgb0
LrfOznpoPs8m+Hx1bM3Ret1L+glZZ6OQfamGd/63DDpfdPrYM0JzjcIvxsPvVMeT
+s/9+K7DuVsT1AdORcqF7RawsStx3NigA6HDoioF9pxakdyZmfSZvginJXRCr32r
TH7N8TEIRxbNeMk3KbYG5YzCEur/sl6p+5wN6TrPGlmseiV2YHDWZXzsSH2pPrKv
cuBMrEab7eILakLdA9B98vMV7yRnfoujM2chESaKuAULKKiYzTfacMJyjgxY/N2k
4QVOKwE7kUIgWTRD9VHaSP0/oVZQ0v50CI9V9YFv91+iFuAL31xHqOmRYuplu5uS
dKqHT9FW8a0C9hwzNWqccurrOGSk5kJw92ArLI9j7FgtUTQ/02QofHCuA5sHFbzw
w8tA9vZ4h6GO2j7yB4J3BLYgqz35j4/d6aib2CcMeQKpd08yQFd8CShsNIwA6uL7
zl2u/A7eTB0FNIYb6Jid/iIzJrRcm0LDbpSK1gEjcg8gfnEU6t6uGKpxmx+FRlp+
6dt4DQAZ2HdlqY7QToTU
=op66
-----END PGP SIGNATURE-----

--nextPart1733415.TSW5sbkbnq--
