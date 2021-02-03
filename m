Return-Path: <SRS0=8mZb=HF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA5AC433DB
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Feb 2021 12:16:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B193864E2E
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Feb 2021 12:16:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B193864E2E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DW0z83KxqzF15P
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Feb 2021 23:16:36 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DW09D5XMfzDwtB
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Feb 2021 22:40:16 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4DW09B4Ly9z9vDw; Wed,  3 Feb 2021 22:40:14 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Paul Mackerras <paulus@samba.org>
In-Reply-To: <62df436454ef06e104cc334a0859a2878d7888d5.1608274548.git.christophe.leroy@csgroup.eu>
References: <62df436454ef06e104cc334a0859a2878d7888d5.1608274548.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v2] powerpc/32s: Only build hash code when
 CONFIG_PPC_BOOK3S_604 is selected
Message-Id: <161235201025.1516112.5330581039307523183.b4-ty@ellerman.id.au>
Date: Wed,  3 Feb 2021 22:40:14 +1100 (AEDT)
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 18 Dec 2020 06:56:05 +0000 (UTC), Christophe Leroy wrote:
> It is now possible to only build book3s/32 kernel for
> CPUs without hash table.
> 
> Opt out hash related code when CONFIG_PPC_BOOK3S_604 is not selected.

Applied to powerpc/next.

[1/1] powerpc/32s: Only build hash code when CONFIG_PPC_BOOK3S_604 is selected
      https://git.kernel.org/powerpc/c/259149cf7c3c6195e6199e045ca988c31d081cab

cheers
