Return-Path: <SRS0=zlPO=CS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F29C433E2
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2020 15:45:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4CD92065E
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2020 15:45:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4CD92065E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BmmYk4bGxzDqX2
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Sep 2020 01:45:14 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Bmjkd0XjzzDqFh
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Sep 2020 23:37:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4BmjkY6Y9Xz9sVZ; Wed,  9 Sep 2020 23:37:41 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: mpe@ellerman.id.au, zhengbin <zhengbin13@huawei.com>,
 linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org, paulus@samba.org
In-Reply-To: <1574144074-142032-1-git-send-email-zhengbin13@huawei.com>
References: <1574144074-142032-1-git-send-email-zhengbin13@huawei.com>
Subject: Re: [PATCH 0/5] powerpc: Remove five unused variables
Message-Id: <159965824298.811679.9055020425603694906.b4-ty@ellerman.id.au>
Date: Wed,  9 Sep 2020 23:37:41 +1000 (AEST)
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

On Tue, 19 Nov 2019 14:14:29 +0800, zhengbin wrote:
> zhengbin (5):
>   powerpc/fadump: Remove set but not used variable 'elf'
>   powerpc/perf: Remove set but not used variable 'target'
>   powerpc/powernv: Remove set but not used variable 'total_vfs'
>   powerpc/powernv: Remove set but not used variable 'pdn'
>   powerpc/powernv: Remove set but not used variable 'parent'
> 
> [...]

Patches 1, 2 & 5 applied to powerpc/next.

[1/5] powerpc/fadump: Remove set but not used variable 'elf'
      https://git.kernel.org/powerpc/c/738e6cad0ace88edec8f4ffa082749ad5df26409
[2/5] powerpc/perf: Remove set but not used variable 'target'
      https://git.kernel.org/powerpc/c/ef23cf9a89a7aec19a29d548d1e219d436b23b6e
[5/5] powerpc/powernv: Remove set but not used variable 'parent'
      https://git.kernel.org/powerpc/c/18102e4bcc47f5b5ac70e2e4461d022c1ee6df24

cheers
