Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 74872DDEE2
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Apr 2008 09:54:04 +1000 (EST)
Date: Wed, 30 Apr 2008 09:53:56 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] [POWERPC] Add struct iommu_table argument to
	iommu_map_sg()
Message-Id: <20080430095356.adaaece5.sfr@canb.auug.org.au>
In-Reply-To: <20080429175413.GA10269@lixom.net>
References: <4816AF79.502@au1.ibm.com>
	<20080429175413.GA10269@lixom.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__30_Apr_2008_09_53_56_+1000_ylu+=ynSkQt08ioH"
Cc: Mark Nelson <markn@au1.ibm.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__30_Apr_2008_09_53_56_+1000_ylu+=ynSkQt08ioH
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Olof,

On Tue, 29 Apr 2008 12:54:17 -0500 Olof Johansson <olof@lixom.net> wrote:
>
> Consistency is good, but I wonder if the opposite wouldn't be the better
> way to go here: always just pass down just the dev pointer instead. The
> table can be reached from it.

I made the changes that passed the iommu_table so that e.g. iSeries could
call iommu_alloc_coherent without a dev pointer at all so that the
generic powerpc code could be cleaned up quite a bit.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__30_Apr_2008_09_53_56_+1000_ylu+=ynSkQt08ioH
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIF7UZTgG2atn1QN8RAlrnAJ9craVwStwY9NDQeBqcKARNxouKHwCghgne
U8j8EI3eMplyYTTYq1ieWQ4=
=mzT8
-----END PGP SIGNATURE-----

--Signature=_Wed__30_Apr_2008_09_53_56_+1000_ylu+=ynSkQt08ioH--
