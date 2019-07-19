Return-Path: <SRS0=ugCm=VQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB850C76195
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Jul 2019 07:34:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E640120693
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Jul 2019 07:34:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="txmGVyXS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E640120693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45qjSr2wn0zDqsH
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Jul 2019 17:34:52 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45qjQj4qyqzDqS9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jul 2019 17:33:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=canb.auug.org.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=canb.auug.org.au header.i=@canb.auug.org.au
 header.b="txmGVyXS"; dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 45qjQj2rh9z9s3Z
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jul 2019 17:33:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
 s=201702; t=1563521581;
 bh=zZQfdjcJH/hdrsr4OGa6Kd3ZRxGgdWOwTXQ1EaK5VVc=;
 h=Date:From:To:Subject:From;
 b=txmGVyXScTIM8uSqn8/ifypxfhzt2V6wDjety/FB0IvPEI1/fQlJAZ7DRfHuj9AuT
 PDfOPOYdJz/QLdrvm6pEJlJH3uYlwC93cRGhSqpBeYcpm1SlxXou29efIYViUJicVD
 xIrM9+Cx5BwMEK2tG2GGcIMYjMVtXNAaW6QKcVvQu+1fqVmKDts+Bpxs8mV1m2UCWQ
 syHXjBhu0ZU2kxDEo+tikDniwp/I2Bnrf/DphrWyj4QsoY3Y8N9I/omQzsn+v5reEb
 IGejXmUJSHqJbr5ubq/l2fkwYuSH0y55j936oUe/AY0pOEzWClhqBDBu8kUKbXbQAp
 8kQC9k02T7aZg==
Date: Fri, 19 Jul 2019 17:32:45 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: ppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: List etiquette
Message-ID: <20190719173245.324739e4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/vt.8lZWA.vHebVa1RR8A4VH";
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

--Sig_/vt.8lZWA.vHebVa1RR8A4VH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Just a short note to mention a couple of things:

	- please do *not* post html formatted emails.  I may start just
rejecting them soon.

	- please cut down the quoting in replies to what is needed for
context.

Thanks
--=20
Cheers,
Stephen Rothwell

--Sig_/vt.8lZWA.vHebVa1RR8A4VH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0xch0ACgkQAVBC80lX
0Gyj7gf6ApkhFHeLyivGI0XElee4PScZeOAIl0l5rPUTD4TDssCDL4LTlBKu+VfA
t0QllSChwvn/ebMy8o8owCAeadz1rXddSjl3MzsMI+CWeN4onP61zakOKPLXZoHY
2awG+5qUSTYjlPNEOIvHmPLomHh5faFHxjpJEAfTOBeopnmJkC/P8CJaRE2yrRLw
bj5+bbtKCIYn0y2h12rPvPdDTgULzejDI0T92j6IgNhegx3s4VXZES16SHaxUJR8
OL/4Z4UPv3kblMkTZCOf6GrjgQEwJ6vBckNke4xiMAM4vnGCrVbvUl5XGaEidrBp
cjE/40eIw0s7C6ogRbG5ZDuVdgl3Ug==
=Yhnp
-----END PGP SIGNATURE-----

--Sig_/vt.8lZWA.vHebVa1RR8A4VH--
