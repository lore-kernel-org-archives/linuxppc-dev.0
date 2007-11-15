Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id E78D1DDDFF
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Nov 2007 14:17:43 +1100 (EST)
Date: Thu, 15 Nov 2007 14:17:40 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: mel@skynet.ie (Mel Gorman)
Subject: Re: Do not depend on MAX_ORDER when grouping pages by mobility
Message-Id: <20071115141740.d22acb0e.sfr@canb.auug.org.au>
In-Reply-To: <20071114181044.GB773@skynet.ie>
References: <20071112132108.7c98f011.sfr@canb.auug.org.au>
	<20071112155452.GB6653@skynet.ie>
	<20071113114401.73d81ce2.sfr@canb.auug.org.au>
	<20071114181044.GB773@skynet.ie>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__15_Nov_2007_14_17_40_+1100_cVg65ctFvwxy8YUM"
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__15_Nov_2007_14_17_40_+1100_cVg65ctFvwxy8YUM
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Mel,

On Wed, 14 Nov 2007 18:10:45 +0000 mel@skynet.ie (Mel Gorman) wrote:
>
> libhugetlbfs test suite and boot test on iSeries is sufficient in this
> case. However, the version I sent would break on IA-64 due to the lack of
> a definition for HPAGE_SHIFT when CONFIG_HUGETLB_PAGE is not set. Can you
> confirm this patch still fixes the problem please? If it does, I'll send
> it to Andrew as a fix for 2.6.24. Whether iSeries is legacy or not, this =
is
> breakage and should be fixed.

The new patch works fine.  I reran the libhugetlbfs tests on a Power5+
machine and the ppc64_defconfig boots on legacy iSeries.

So

Tested-by: Stephen Rothwell <sfr@canb.auug.org.au> iSeries boot test and
		hugetlb tests on PPC64

Thanks.
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__15_Nov_2007_14_17_40_+1100_cVg65ctFvwxy8YUM
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHO7peTgG2atn1QN8RAnefAJ9lKYLMuDpiRxlfqmFtRwFAnFamKgCgh+0m
7FGAULfcV8PFdIFH/XGpLzw=
=JTBY
-----END PGP SIGNATURE-----

--Signature=_Thu__15_Nov_2007_14_17_40_+1100_cVg65ctFvwxy8YUM--
