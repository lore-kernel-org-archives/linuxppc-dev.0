Return-Path: <SRS0=aJM7=ML=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7DECC43143
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Sep 2018 03:59:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51A9220666
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Sep 2018 03:59:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Q8SyC3lP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51A9220666
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42MZY81fglzDqq8
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Sep 2018 13:59:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Q8SyC3lP";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42MZVf3nPLzF3LK
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Sep 2018 13:56:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=canb.auug.org.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=canb.auug.org.au header.i=@canb.auug.org.au
 header.b="Q8SyC3lP"; dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42MZVf12YSz9sCR
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Sep 2018 13:56:58 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
 s=201702; t=1538193418;
 bh=wSlEG1anvCG/IPTeiXttjymQowE8pvIQgvQXOvjEIOY=;
 h=Date:From:To:Subject:From;
 b=Q8SyC3lP6nx23X1icO7DJrNta1jKkEs56Ga++4EFdhLcnrAI+Jpvw4RXtB5BdIW5D
 IfoJZIcL6ncHQPRqN5/l7YTGhRB3Q89VXRlde0MhoGV4Ni5QlsqPga9l4Bj+FRperJ
 Xoypi7hePLnJUhl9SbnyVnI0DDHpXym+ppVh8n2gU0wCoNP5ZwerC55hszvuloNo6P
 /oz/gZUBlHZGZ6MWoSn/Qv9u2EB5AL9BYPoc135HWRQxXW7B8w+02xh/fJ4dhc3upX
 xAH3PwUrV8L4kZThRK4JU3C5WXLbGP6uNp8fzT4fPC5pbdbyfeRGsSF/1UDQJomH5K
 RJmml2mKRRzlA==
Date: Sat, 29 Sep 2018 13:56:28 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: ppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: New mail archive
Message-ID: <20180929135628.783ca76e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/PqcA99lxeN_I3aY8k0rQKq2"; protocol="application/pgp-signature"
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

--Sig_/PqcA99lxeN_I3aY8k0rQKq2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

This mailing list is now also archived at
https://lore.kernel.org/linuxppc-dev/

--=20
Cheers,
Stephen Rothwell

--Sig_/PqcA99lxeN_I3aY8k0rQKq2
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluu9+0ACgkQAVBC80lX
0Gz6jwgAoxhKUZUmtqjBJHSkMOT5wUXWhc30OX7UTt6MJxnLbLdK8zh88ObbNkIZ
y0IQXs13W5sSCgGWs1QWkNHshG8eDBis4WHVSa9auR5Pz4Ibvda5oXWRdlprxsMQ
cvvFCRKdRoGO+N998/HpiiyS0GRH53bc6oZ7lfWUlVHGT8Q+tWwTFqzFtAMIJXTB
Be+RVgaRrj8CVLYjWgwq7Lh63g88we6ZqZO80TjkQ25WQkHY4VndS05J+ltmRTaL
W6tBJ2z+pvXEJPL3GbfnRDVpOxmCdloKwp7tlYc/Om0m66Rc90ZEFqcHm1OjXSbU
Fpqa+0jKmuBdseXIviChWQWDmhTpqg==
=yXG7
-----END PGP SIGNATURE-----

--Sig_/PqcA99lxeN_I3aY8k0rQKq2--
