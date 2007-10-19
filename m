Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 1944EDDDDB
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 14:48:47 +1000 (EST)
Date: Fri, 19 Oct 2007 14:48:41 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Li Yang-r58472" <LeoLi@freescale.com>
Subject: Re: [PATCH v6 4/9] add platform support for MPC837x MDS board
Message-Id: <20071019144841.5e45dc30.sfr@canb.auug.org.au>
In-Reply-To: <989B956029373F45A0B8AF0297081890019B5C3A@zch01exm26.fsl.freescale.net>
References: <1192719847-25045-1-git-send-email-leoli@freescale.com>
	<1192719847-25045-2-git-send-email-leoli@freescale.com>
	<1192719847-25045-3-git-send-email-leoli@freescale.com>
	<1192719847-25045-4-git-send-email-leoli@freescale.com>
	<20071019104318.edfd2ad1.sfr@canb.auug.org.au>
	<989B956029373F45A0B8AF0297081890019B5C3A@zch01exm26.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Fri__19_Oct_2007_14_48_41_+1000_N07ZsENOCz3C3LoL"
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Fri__19_Oct_2007_14_48_41_+1000_N07ZsENOCz3C3LoL
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 19 Oct 2007 11:56:34 +0800 "Li Yang-r58472" <LeoLi@freescale.com> w=
rote:
>
> <asm/prom.h> is included in <linux/of.h> now.  Do you think it should be
> included explicitly?

Yes.  It may not be included by linux/of.h in the future.

(My general opinion is that if you use something, you should explictly
include the file that defines/declares it.)

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__19_Oct_2007_14_48_41_+1000_N07ZsENOCz3C3LoL
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHGDcuTgG2atn1QN8RAho5AKCAKaXTOjr+/+kFSJpCAFRHoIhA8ACggKpq
vHt5ds4onRTD2X7kZ0Ux4Fg=
=owOa
-----END PGP SIGNATURE-----

--Signature=_Fri__19_Oct_2007_14_48_41_+1000_N07ZsENOCz3C3LoL--
