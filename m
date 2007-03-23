Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 80DB7DDF60
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Mar 2007 17:00:06 +1100 (EST)
Date: Fri, 23 Mar 2007 17:00:13 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Olaf Hering <olaf@aepfle.de>
Subject: Re: [PATCH] fix xmon print_bug_trap compile error
Message-Id: <20070323170013.4ead779f.sfr@canb.auug.org.au>
In-Reply-To: <20070322221117.GA13481@aepfle.de>
References: <20070322221117.GA13481@aepfle.de>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Fri__23_Mar_2007_17_00_13_+1100_bhwUc1ehF+i.iYDd"
Cc: linuxppc-dev@ozlabs.org, Paul Mackeras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Fri__23_Mar_2007_17_00_13_+1100_bhwUc1ehF+i.iYDd
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Thu, 22 Mar 2007 23:11:17 +0100 Olaf Hering <olaf@aepfle.de> wrote:
>
>
> These 2 members of struct bug_entry are inside CONFIG_DEBUG_BUGVERBOSE

This is fixed by commit 0a7c7efccc08f00ae6fc8e1f2de0ee61f07357fd in
Paulus' powerpc tree.

--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__23_Mar_2007_17_00_13_+1100_bhwUc1ehF+i.iYDd
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGA2z0FdBgD/zoJvwRAlAhAKCUJP1ls54qgo94DfNm2q88qYRkxACgnFmC
7JBSVuiqEP0GTj2dMaKtFiA=
=arXN
-----END PGP SIGNATURE-----

--Signature=_Fri__23_Mar_2007_17_00_13_+1100_bhwUc1ehF+i.iYDd--
