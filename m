Return-Path: <SRS0=m9yV=MQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED344C4338F
	for <linuxppc-dev@archiver.kernel.org>; Sat, 24 Jul 2021 15:39:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C5356056C
	for <linuxppc-dev@archiver.kernel.org>; Sat, 24 Jul 2021 15:39:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2C5356056C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GX9NM2D7xz3bnL
	for <linuxppc-dev@archiver.kernel.org>; Sun, 25 Jul 2021 01:39:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GX9N00dSTz2ymZ
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Jul 2021 01:39:07 +1000 (AEST)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
 by localhost (Postfix) with ESMTP id 4GX9Mm2wCszB8p0;
 Sat, 24 Jul 2021 17:39:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Mhdamgu_XzUK; Sat, 24 Jul 2021 17:39:00 +0200 (CEST)
Received: from vm-hermes.si.c-s.fr (vm-hermes.si.c-s.fr [192.168.25.253])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4GX9Mm1qk3zB8nr;
 Sat, 24 Jul 2021 17:39:00 +0200 (CEST)
Received: by vm-hermes.si.c-s.fr (Postfix, from userid 33)
 id 5083C653; Sat, 24 Jul 2021 17:44:16 +0200 (CEST)
Received: from 37-165-72-176.coucou-networks.fr
 (37-165-72-176.coucou-networks.fr [37.165.72.176]) by messagerie.c-s.fr
 (Horde Framework) with HTTP; Sat, 24 Jul 2021 17:44:16 +0200
Date: Sat, 24 Jul 2021 17:44:16 +0200
Message-ID: <20210724174416.Horde.SGJpvfIKCho_9unV7fRnmA7@messagerie.c-s.fr>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Geoff Levand <geoff@infradead.org>
Subject: Re: [PATCH v4 03/10] net/ps3_gelic: Format cleanups
References: <cover.1627068552.git.geoff@infradead.org>
 <56efff53fcf563a1741904ea0f078d50c378b6cc.1627068552.git.geoff@infradead.org>
In-Reply-To: <56efff53fcf563a1741904ea0f078d50c378b6cc.1627068552.git.geoff@infradead.org>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.3)
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
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
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Geoff Levand <geoff@infradead.org> a =C3=A9crit=C2=A0:

> In an effort to make the PS3 gelic driver easier to maintain, cleanup the
> the driver source file formatting to be more consistent.

Many of your changes in this patch go in the wrong direction.

For instance, you shall not use { } in an if/else sequence with single=20=
=20
lines=20in both the if and the else. See=20=20
https://www.kernel.org/doc/html/latest/process/coding-style.html#placing-br=
aces-and-spaces

In=20a multiline operation, the argument of the second line must be=20=20
aligned=20to the matching parenthesis.

Christophe


