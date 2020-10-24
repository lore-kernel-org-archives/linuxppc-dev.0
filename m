Return-Path: <SRS0=qtOt=D7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E07E9C4363A
	for <linuxppc-dev@archiver.kernel.org>; Sat, 24 Oct 2020 10:33:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A7E72226B
	for <linuxppc-dev@archiver.kernel.org>; Sat, 24 Oct 2020 10:33:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A7E72226B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CJHWT6jqNzDr9L
	for <linuxppc-dev@archiver.kernel.org>; Sat, 24 Oct 2020 21:33:41 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CJHNv1c8SzDqlR
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Oct 2020 21:27:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4CJHNv1LNKz9sVH; Sat, 24 Oct 2020 21:27:59 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, Oliver O'Halloran <oohall@gmail.com>
In-Reply-To: <20201021232554.1434687-1-oohall@gmail.com>
References: <20201021232554.1434687-1-oohall@gmail.com>
Subject: Re: [PATCH] powerpc/eeh: Fix eeh_dev_check_failure() for PE#0
Message-Id: <160353524026.3419015.7292966014896302736.b4-ty@ellerman.id.au>
Date: Sat, 24 Oct 2020 21:27:59 +1100 (AEDT)
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

On Thu, 22 Oct 2020 10:25:54 +1100, Oliver O'Halloran wrote:
> In commit 269e583357df ("powerpc/eeh: Delete eeh_pe->config_addr") the
> following simplification was made:
> 
> -       if (!pe->addr && !pe->config_addr) {
> +       if (!pe->addr) {
>                 eeh_stats.no_cfg_addr++;
>                 return 0;
>         }
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/eeh: Fix eeh_dev_check_failure() for PE#0
      https://git.kernel.org/powerpc/c/99f6e9795a68fe23f96a2b5b0be07a3dd9457f99

cheers
