Return-Path: <albrecht.dress@arcor.de>
Received: from cc-smtpout2.netcologne.de (cc-smtpout2.netcologne.de
	[89.1.8.212]) by ozlabs.org (Postfix) with ESMTP id 00B53B6F86
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Mar 2011 07:46:04 +1100 (EST)
Received: from cc-smtpin1.netcologne.de (cc-smtpin1.netcologne.de [89.1.8.201])
	by cc-smtpout2.netcologne.de (Postfix) with ESMTP id 123EA12820
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Mar 2011 21:46:01 +0100 (CET)
Received: from antares (xdsl-89-0-94-220.netcologne.de [89.0.94.220])
	by cc-smtpin1.netcologne.de (Postfix) with ESMTPSA id 08B3B11E89
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Mar 2011 21:46:00 +0100 (CET)
Received: from antares (antares [127.0.0.1])
	by antares (Postfix) with ESMTPS id D87CCBA032
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Mar 2011 21:45:59 +0100 (CET)
Date: Wed, 09 Mar 2011 21:45:51 +0100
From: Albrecht =?iso-8859-1?b?RHJl3w==?= <albrecht.dress@arcor.de>
Subject: [5200B/slightly ot] MPC52xx LPB FIFO memory requirements
To: Linux PPC Development <linuxppc-dev@ozlabs.org>
Message-Id: <1299703559.1817.3@antares>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg=PGP-SHA1; boundary="=-JLOKofaZ1Ed9C+gUcK9R"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--=-JLOKofaZ1Ed9C+gUcK9R
Content-Type: text/plain; charset=us-ascii; DelSp=Yes; Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

I have a slightly off-topic question regarding the use of mpc52xx_lpbfifo_s=
ubmit() & friends...

In struct mpc52xx_lpbfifo_request, the element 'data' (with address 'data_p=
hys') is apparently the chunk of data which is transferred through bestcomm=
, right?  Dumb question: has this chunk of memory to be DMA mem (i.e. alloc=
ated via dma_alloc_coherent), or is "normal" kernel memory (kmalloc) suffic=
ient?

Thanks,
Albrecht.

--=-JLOKofaZ1Ed9C+gUcK9R
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iD8DBQBNd+cHn/9unNAn/9ERAkLRAJ94YosA2jVOHoO1DQu336gUeatOGgCeOZLD
HUeiiRxQkvySH9ZaUEF6EfA=
=PLRD
-----END PGP SIGNATURE-----

--=-JLOKofaZ1Ed9C+gUcK9R--
