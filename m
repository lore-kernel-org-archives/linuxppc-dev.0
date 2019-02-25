Return-Path: <SRS0=+31F=RA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C64C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Feb 2019 06:46:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FDD520842
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Feb 2019 06:46:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="S5Tnu+8S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FDD520842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 447CC301GPzDq64
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Feb 2019 17:46:07 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 447C8d3ZnKzDqNt
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Feb 2019 17:44:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=canb.auug.org.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=canb.auug.org.au header.i=@canb.auug.org.au
 header.b="S5Tnu+8S"; dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 447C8d0GJmz9s9T;
 Mon, 25 Feb 2019 17:44:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
 s=201702; t=1551077041;
 bh=lmVs1hT0QQWLsvKg/U6KhyGLPlbJl1E6/182Q7hmkYs=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=S5Tnu+8SBbht4e7A0TFxOhNs8TxiSPWx5pZrBfObNP1lBb9G8bPWPIs3G6uRgLfOq
 DI7H0/xjcWrpF/2lfWufMS+WeNHLZ7VoZL1r7CzlJaEglgkN5RNuG1Js6/OqNWgNwg
 zZzxzKcqn/v2cX5AQK/0aIiM/7PlO3cXeFFBqLENq5x3vOpuWaqMZ5cpwUEuaD3FTG
 WBBOOa12SNAB2svEf6N/NJszFl2u8LdYh1vpQE3IxOuhP031ReGZCteZp34ViN22q4
 7Cpgg4lLkyMj/S+edQD7DCovKNafIw4wp4Hm8j7doNMpZY4enRltq9+SkWoF4g4imv
 9jXCDQzfji9iw==
Date: Mon, 25 Feb 2019 17:44:00 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>, Michael Ellerman
 <mpe@ellerman.id.au>, PowerPC <linuxppc-dev@lists.ozlabs.org>
Subject: Re: linux-next: manual merge of the akpm-current tree with the
 powerpc tree
Message-ID: <20190225174400.5bdafa10@canb.auug.org.au>
In-Reply-To: <20190225174248.54aceebd@canb.auug.org.au>
References: <20190225174248.54aceebd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/GqQvoPQHf6A=dm3VZXg1K90"; protocol="application/pgp-signature"
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
Cc: Linux Next Mailing List <linux-next@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

--Sig_/GqQvoPQHf6A=dm3VZXg1K90
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 25 Feb 2019 17:42:48 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the akpm-current tree got a conflict in:

This was actually the akpm tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/GqQvoPQHf6A=dm3VZXg1K90
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxzjrAACgkQAVBC80lX
0Gxb1Qf8C4i23ZrR8/vEGRDTU4flKaWN2Z5qbCqEHaVZg8oZe072WIkAaRVyfbqb
w1fafTTNAjFTdRMyt+WQFhhwqU7O4uhIsISWmONiBQv5OEX2LEGgSZkqsMJAX0ZS
04Y+bU4B80fUWo0TfBkPc5csbhXvQECsHGicewMtjUbomS7rZt9VnvN94+n3BNKR
BBCzUTI0Vnu6Yaqk8OJooYfODof8TBU6d3Oft/vV7qMCiw/dmrXn5q12HJ/XBpr9
brIlZmXL/TecAzlErGep+/bl9w001n8dkoKxxWU4d0Vj5nwAeTWLiec8EPfsfdEZ
UbRuK4Exnj2YXL7apMqjGQ4Q3aqhBw==
=DUpk
-----END PGP SIGNATURE-----

--Sig_/GqQvoPQHf6A=dm3VZXg1K90--
