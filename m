Return-Path: <SRS0=2rUD=Q5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D345C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 07:18:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC9F520818
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 07:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="GzWxaENd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC9F520818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 445N3s0FV0zDqQs
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 18:18:33 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 445Mz236QVzDqVP
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 18:14:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=canb.auug.org.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=canb.auug.org.au header.i=@canb.auug.org.au
 header.b="GzWxaENd"; dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 445Mz16KDnz9s9L;
 Fri, 22 Feb 2019 18:14:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
 s=201702; t=1550819662;
 bh=BUotE6TJCLy3uPerF71sH4otRbu4tnk2oqTCpT0GvvU=;
 h=Date:From:To:Cc:Subject:From;
 b=GzWxaENdNSlHkSNu8kE4lbFZmnPVv33hQmdZuA29yF8ZfKqqdcuVJoZ7FwwTbO6Nw
 SMyD2bhdWmv0j5dvPZV6fHdKHRRlT9C6sCKqD43NpDwVotL5UIUgOYEqt3U4+7JN07
 D0BthU8u+iKSZk3ySmCq9f6FGrZQNkJ5UGv6qG2s9iF1Yz74Sza+FTzMtXEvUgtTOg
 tP7F2gxp6d3IzRMUIEoWdrClnZM1zJNZSScopihuXljGM64qRVvCBwN2OXJEzowry0
 XIs7RukmqrGoZ6JBNpydO393c1zDyywD0UdE1ybfsIASj3vNlgoTPCZCzAn6QU+aTt
 l1VrbDQI/C/jw==
Date: Fri, 22 Feb 2019 18:14:03 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <mpe@ellerman.id.au>, PowerPC
 <linuxppc-dev@lists.ozlabs.org>
Subject: linux-next: build failure after merge of the powerpc tree
Message-ID: <20190222181403.4ce373bd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/+FbZc7FKr5m2vNkwx0fiVQQ"; protocol="application/pgp-signature"
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

--Sig_/+FbZc7FKr5m2vNkwx0fiVQQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the powerpc tree, today's linux-next build (powerpc
allyesconfig) failed like this:

make[4]: *** No rule to make target 'arch/powerpc/mm/ptdump/core.o', needed=
 by 'arch/powerpc/mm/ptdump/built-in.a'.

Caused by commit

  5df1cfa43394 ("powerpc: Move page table dump files in a dedicated subdire=
ctory")

I have reverted that commit for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/+FbZc7FKr5m2vNkwx0fiVQQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxvoTsACgkQAVBC80lX
0Gwdbgf9FSrUjejdUoAe9U3PpHeJakQyVdhu9ZoCWGxHwRsdnWi7ZUT4yEB4FD7Q
YRBbEm5sugDNBU+s5vlLHDzUqA34reGO6ntx+rO0ZOtUVnHBZSkpEI+Cn2ipGPWA
t2ximMCh1IYR1kyOB/iNBT8+bv8ep9AhOfyxtjUqNhAB35OvvtMURv5+rZYMuxHX
kdqFgTMsux674D0/ajFqMbh/j79AcIERxVPfjHLCPaXUIoJyjVFLx/2MRvRtaUL2
jbRP4npWJaFapY5xXo+hHQ3kyPCZdBujIvychdEKbVkQToPXXAfKHtcRs4n+LTsz
fqGvP2mfO4oZuRag4Ns71k8S7pArPQ==
=g7aE
-----END PGP SIGNATURE-----

--Sig_/+FbZc7FKr5m2vNkwx0fiVQQ--
