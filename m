Return-Path: <SRS0=hJnm=LM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB9DBC48BDF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jun 2021 04:31:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DE7561260
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jun 2021 04:31:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DE7561260
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G5mFz6XGXz3c9h
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jun 2021 14:31:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=203.11.71.1; helo=ozlabs.org;
 envelope-from=michael@ozlabs.org; receiver=<UNKNOWN>)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G5m4S2gV9z3c62
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jun 2021 14:23:04 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4G5m4R16CSz9t0T; Fri, 18 Jun 2021 14:23:02 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, paulus@samba.org, arnd@arndb.de,
 mpe@ellerman.id.au, benh@kernel.crashing.org, linux-kernel@vger.kernel.org,
 Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20210601085319.140461-1-libaokun1@huawei.com>
References: <20210601085319.140461-1-libaokun1@huawei.com>
Subject: Re: [PATCH -next] powerpc/spider-pci: Remove set but not used
 variable 'val'
Message-Id: <162398828887.1363949.15561402899101847554.b4-ty@ellerman.id.au>
Date: Fri, 18 Jun 2021 13:51:28 +1000
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
Cc: yangjihong1@huawei.com, yuehaibing@huawei.com, weiyongjun1@huawei.com,
 yukuai3@huawei.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 1 Jun 2021 16:53:19 +0800, Baokun Li wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> arch/powerpc/platforms/cell/spider-pci.c: In function 'spiderpci_io_flush':
> arch/powerpc/platforms/cell/spider-pci.c:28:6: warning:
> variable ‘val’ set but not used [-Wunused-but-set-variable]
> 
> It never used since introduction.

Applied to powerpc/next.

[1/1] powerpc/spider-pci: Remove set but not used variable 'val'
      https://git.kernel.org/powerpc/c/f377f7da26d2af87e2ddc39190546f62ecdb2bd8

cheers
