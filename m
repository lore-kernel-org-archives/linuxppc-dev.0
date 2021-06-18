Return-Path: <SRS0=hJnm=LM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F2B0C48BE8
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jun 2021 04:29:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2FEC61260
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jun 2021 04:29:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2FEC61260
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G5mDM3bQjz3g8h
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jun 2021 14:29:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=2401:3900:2:1::2; helo=ozlabs.org;
 envelope-from=michael@ozlabs.org; receiver=<UNKNOWN>)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G5m4Q0Tw5z3c6C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jun 2021 14:23:02 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4G5m4N62hdz9sWk; Fri, 18 Jun 2021 14:23:00 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Finn Thain <fthain@linux-m68k.org>, Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <a1456e8bbd33ef702e3ff6f14b1bf3919241c62b.1623398307.git.fthain@linux-m68k.org>
References: <a1456e8bbd33ef702e3ff6f14b1bf3919241c62b.1623398307.git.fthain@linux-m68k.org>
Subject: Re: [PATCH v2] powerpc/tau: Remove superfluous parameter in
 alloc_workqueue() call
Message-Id: <162398829913.1363949.18107899985945378048.b4-ty@ellerman.id.au>
Date: Fri, 18 Jun 2021 13:51:39 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Fri, 11 Jun 2021 17:58:27 +1000, Finn Thain wrote:
> This avoids an (optional) compiler warning:
> 
> arch/powerpc/kernel/tau_6xx.c: In function 'TAU_init':
> arch/powerpc/kernel/tau_6xx.c:204:30: error: too many arguments for format [-Werror=format-extra-args]
>   tau_workq = alloc_workqueue("tau", WQ_UNBOUND, 1, 0);

Applied to powerpc/next.

[1/1] powerpc/tau: Remove superfluous parameter in alloc_workqueue() call
      https://git.kernel.org/powerpc/c/ddf4a7bcd09439e82c4d6f959f4ff6c53f07466f

cheers
