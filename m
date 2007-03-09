Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 34F52DDEC5
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Mar 2007 12:02:33 +1100 (EST)
Date: Fri, 9 Mar 2007 12:02:18 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: Re: [PATCH 3/3] [POWERPC] sys_move_pages should be callable from an
	SPU
Message-Id: <20070309120218.59c4e400.sfr@canb.auug.org.au>
In-Reply-To: <20070309115811.23861fcf.sfr@canb.auug.org.au>
References: <20070309115457.611e4c99.sfr@canb.auug.org.au>
	<20070309115710.6050edc8.sfr@canb.auug.org.au>
	<20070309115811.23861fcf.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Fri__9_Mar_2007_12_02_18_+1100_s+OTLM_NbvPI+981"
Cc: pc-dev <linuxppc-dev@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Fri__9_Mar_2007_12_02_18_+1100_s+OTLM_NbvPI+981
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hi Paul,

It would be good if the preceding three patches could get into 2.6.21.

1/3 fixes a bug (effectively adds a new syscall)
2/3 adds a new syscall
3/3 adds a new syscall to the SPU side of things
--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__9_Mar_2007_12_02_18_+1100_s+OTLM_NbvPI+981
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFF8LIrFdBgD/zoJvwRAoD5AJ4uNhv+v/yyXQ5aY9A4vONgtGC8iACggLGA
40MBkrNI4zfiRLLH3Q4dR8c=
=wBgW
-----END PGP SIGNATURE-----

--Signature=_Fri__9_Mar_2007_12_02_18_+1100_s+OTLM_NbvPI+981--
