Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 8DE23DDEBF
	for <linuxppc-dev@ozlabs.org>; Mon, 14 May 2007 14:13:06 +1000 (EST)
Date: Mon, 14 May 2007 14:13:01 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] Wire up some more syscalls
Message-Id: <20070514141301.14ddae91.sfr@canb.auug.org.au>
In-Reply-To: <1AF532FF-A994-47AF-9394-5DFFC6C8FDA1@kernel.crashing.org>
References: <20070514135033.07c1b840.sfr@canb.auug.org.au>
	<1AF532FF-A994-47AF-9394-5DFFC6C8FDA1@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Mon__14_May_2007_14_13_01_+1000_qGZNAdZAuVcD_8QB"
Cc: ppc-dev <linuxppc-dev@ozlabs.org>,
	Andrew Morton <akpm@linux-foundation.org>, paulus@samba.org,
	Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Mon__14_May_2007_14_13_01_+1000_qGZNAdZAuVcD_8QB
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Sun, 13 May 2007 22:55:01 -0500 Kumar Gala <galak@kernel.crashing.org> wrote:
>
> Just out of interest, what makes a syscall COMPAT_SYS_SPU vs
> SYSCALL_SPU?

COMPAT_ syscalls need a compatibilty wrapper around the 32 bit calls on
64 bit kernels.

--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__14_May_2007_14_13_01_+1000_qGZNAdZAuVcD_8QB
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGR+HRFdBgD/zoJvwRAkwHAJwNLC9UGyhvcD9FPliBcE2e4ybRwQCfX8ME
IK3zD2FoC83O8z6vm77KZWU=
=P01S
-----END PGP SIGNATURE-----

--Signature=_Mon__14_May_2007_14_13_01_+1000_qGZNAdZAuVcD_8QB--
