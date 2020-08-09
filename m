Return-Path: <SRS0=N30B=BT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD406C433E0
	for <linuxppc-dev@archiver.kernel.org>; Sun,  9 Aug 2020 08:59:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 334A3206C0
	for <linuxppc-dev@archiver.kernel.org>; Sun,  9 Aug 2020 08:59:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="W9eyRp8w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 334A3206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BPY1X6x1YzDqX9
	for <linuxppc-dev@archiver.kernel.org>; Sun,  9 Aug 2020 18:59:12 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BPXzZ0LzPzDqTk
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  9 Aug 2020 18:57:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=canb.auug.org.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=canb.auug.org.au header.i=@canb.auug.org.au
 header.a=rsa-sha256 header.s=201702 header.b=W9eyRp8w; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4BPXzX25j8z9sTN;
 Sun,  9 Aug 2020 18:57:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
 s=201702; t=1596963449;
 bh=Wl+ZEPR2nqFKgj/Exq090s6aHL4BBMpUzG1yyNaV4Jk=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=W9eyRp8wR0z6syshAQ+U6lJ8V/+YzTV1SXnc7LrpSwJ3X2e203IswQFFgAYq0n5Py
 LaEM8EV+Js5zOGD1xzmDYEBrvzb0i8CxeJ+EoDsLdw1WWyVh9Kr1vYDNr8cl7g/jUx
 p1YVZgTLAXWFykvQj0T1lp3BVtpUSFAfl7Vsht222ZWD0iuYAVd+25GRax8HhdBf+c
 4eKGQ9m8sFRlBuGOaEmIi4gJLLik5hOFj8+mIUF3kBmEP2+KxhGXRHtvxdCdTb7Rv9
 SyL+ukbSy4cd+O414vfaFrpUzT8N+sXjdFSbbLIkb09vxHZgeUboMn/qsvE7FzWzaV
 zSY0PjkoKodmA==
Date: Sun, 9 Aug 2020 18:57:26 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: linux-next: manual merge of the set_fs tree with the powerpc tree
Message-ID: <20200809185726.5d8e5f55@canb.auug.org.au>
In-Reply-To: <20200717190931.701ddf08@canb.auug.org.au>
References: <20200717190931.701ddf08@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/h4YwlFL/8NIBi9n_EmMIqX8";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Nathan Lynch <nathanl@linux.ibm.com>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

--Sig_/h4YwlFL/8NIBi9n_EmMIqX8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 17 Jul 2020 19:09:31 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>=20
> Today's linux-next merge of the set_fs tree got a conflict in:
>=20
>   arch/powerpc/mm/numa.c
>=20
> between commit:
>=20
>   c30f931e891e ("powerpc/numa: remove ability to enable topology updates")
>=20
> from the powerpc tree and commit:
>=20
>   16a04bde8169 ("proc: switch over direct seq_read method calls to seq_re=
ad_iter")
>=20
> from the set_fs tree.
>=20
> I fixed it up (the former removed the code updated by the latter, so I
> just did that) and can carry the fix as necessary. This is now fixed as
> far as linux-next is concerned, but any non trivial conflicts should be
> mentioned to your upstream maintainer when your tree is submitted for
> merging.  You may also want to consider cooperating with the maintainer
> of the conflicting tree to minimise any particularly complex conflicts.

This is now a conflict between the set_fs tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/h4YwlFL/8NIBi9n_EmMIqX8
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl8vunYACgkQAVBC80lX
0GyH2ggAgjqRQHzD2II/rJWPv7LgkrI6+O9t2qfbxLWMqOmzYHR1cV/VoW7fXEUJ
UOCJwNWGVmS12DYKt4UBudW0bOuZmLTqK09qmifOEbbOYTofa4475Gecq+j7YWxH
aI/s5VwrJdmW13K7+eaBzne1s5oRfVkQ4WDg9nUYd7NAwwOMYHYxQosuvGfaKmR0
PSgwUCYtPjgLW69Ttr5Np3pZ+3/C/txSOhxX/pmLVBtNUcJamOKFVULEzhJDG2na
lhy+QkLQ+Xn83AAgQo1qxAX3E3rUnPe7xk08SgOq6/SMxXzaqKG49Ge+2MpvOg2l
6T0JQn0uGQrMBH9ajfjRBvgjrJSvyA==
=9uU4
-----END PGP SIGNATURE-----

--Sig_/h4YwlFL/8NIBi9n_EmMIqX8--
