Return-Path: <SRS0=aJM7=ML=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E855EC43143
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Sep 2018 04:02:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51CBE206B7
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Sep 2018 04:02:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="PkPAgc9b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51CBE206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42MZcg2LmfzDqq8
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Sep 2018 14:02:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="PkPAgc9b";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42MZZ4115VzDqq8
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Sep 2018 13:59:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=canb.auug.org.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=canb.auug.org.au header.i=@canb.auug.org.au
 header.b="PkPAgc9b"; dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42MZZ3615Zz9sCR
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Sep 2018 13:59:55 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
 s=201702; t=1538193595;
 bh=/cFs5n0UCtcSNcRG1NWGRgd7hl5axRxgqEZROFkgNbo=;
 h=Date:From:To:Subject:In-Reply-To:References:From;
 b=PkPAgc9bElbTSMimy9KOLb2BbAh97oKmC0GkH1hiHUkYFLR7P1UUuVtFlWYfOWWuP
 d7PwJJogphe+wPPsva9DXumIG/RsdxVej2dIiGGcVwpVAi0tgczP3jqtOTqLOnxVtc
 YD17i5+yT6RmXXlN7aptzkuuuCNKxIuugimXlCGijmPsQh7w0Wi8HN2fcQcEYTY8lG
 76r+dldwSXyhrY59cs8KGIg8bQTDC+u0P5OsQYuZAokHZI36HP9w6G1GQV3eyHqM9s
 IcYGhYVU6z1IMcceSwFpRI7P4KHRH4/Y0gu7hyjAE6p9gKJmP+b4UOBghFHrqkM+h1
 dM0Xf9eHcW6EA==
Date: Sat, 29 Sep 2018 13:59:53 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: ppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: New mail archive
Message-ID: <20180929135953.6ab09fcb@canb.auug.org.au>
In-Reply-To: <20180929135628.783ca76e@canb.auug.org.au>
References: <20180929135628.783ca76e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/zxEyeyCw7Eyp.iipQNEsxXV"; protocol="application/pgp-signature"
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

--Sig_/zxEyeyCw7Eyp.iipQNEsxXV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Sat, 29 Sep 2018 13:56:28 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> This mailing list is now also archived at
> https://lore.kernel.org/linuxppc-dev/

A few of the earliest emails have been misdated in the archive (to today
or yesterday), sorry.

Also, this archive includes as much as we had of the linuxppc-embedded
archive as well.

--=20
Cheers,
Stephen Rothwell

--Sig_/zxEyeyCw7Eyp.iipQNEsxXV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluu+LkACgkQAVBC80lX
0GySKQgAidDBqNWxvJGzR9B/vmsfPIXTN68NCglNN0c1CNcgZXTLfvv2BaxR47KS
sEiX2k1Z+1k/d+whspGRUwAmJPiuW1ASFp9t1wi+j5roMWjNSuHv2pea+KsNf/eW
O3eiFIxdrwo3NAc6X9a0DD3swmpXrrL+NikY1YKY/Fc6D4lTyUGqMMbdGTIT/OnQ
RkJ2OsbY3Gtipct7k9n1iZK9lW5RiqGwXWpAgcec5vZEPV2oRWIHIGt51Q2iZ1ej
M+TOLq0MUWxtD22krErA7GmR+NshKz0jXGQUJ5Q23+3wWi8cH++HazFCPn5zQJRQ
yf+wLuMYS49oyNASgY5WsdCb6xjdQg==
=wXKu
-----END PGP SIGNATURE-----

--Sig_/zxEyeyCw7Eyp.iipQNEsxXV--
