Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 49113DDE4A
	for <linuxppc-dev@ozlabs.org>; Wed,  9 May 2007 17:31:00 +1000 (EST)
Date: Wed, 9 May 2007 17:30:54 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Domen Puncer <domen.puncer@telargo.com>
Subject: Re: [PATCH 2/2] [POWERPC] Wire up sys_utimensat
Message-Id: <20070509173054.54f2e137.sfr@canb.auug.org.au>
In-Reply-To: <20070509064203.GY18236@moe.telargo.com>
References: <20070509162151.6a54507a.sfr@canb.auug.org.au>
	<20070509162442.11760e79.sfr@canb.auug.org.au>
	<20070509064203.GY18236@moe.telargo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__9_May_2007_17_30_54_+1000_/mI=8dl6TfDanJV8"
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__9_May_2007_17_30_54_+1000_/mI=8dl6TfDanJV8
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Wed, 9 May 2007 08:42:03 +0200 Domen Puncer <domen.puncer@telargo.com> wrote:
>
> > +#define __NR_utimensat		303
>
> 					^ 304?

Oops!  :-)

New patch following.

--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__9_May_2007_17_30_54_+1000_/mI=8dl6TfDanJV8
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGQXi4FdBgD/zoJvwRAprwAJ9LyRRIhfn1dSAzbs+nATug9AnbPgCeJiOu
9oxJFJCqZgKeFQeXhK6KR1k=
=qv8r
-----END PGP SIGNATURE-----

--Signature=_Wed__9_May_2007_17_30_54_+1000_/mI=8dl6TfDanJV8--
