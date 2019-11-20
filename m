Return-Path: <SRS0=DyCn=ZM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04BD5C432C3
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Nov 2019 20:39:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7623420726
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Nov 2019 20:39:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7623420726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47JF0p6kmgzDqn1
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Nov 2019 07:39:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=davemloft.net
 (client-ip=2620:137:e000::1:9; helo=shards.monkeyblade.net;
 envelope-from=davem@davemloft.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=davemloft.net
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2620:137:e000::1:9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47JDyr43rpzDqld
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Nov 2019 07:37:39 +1100 (AEDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:1e2::3d5])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: davem-davemloft)
 by shards.monkeyblade.net (Postfix) with ESMTPSA id 54DC214C21FFD;
 Wed, 20 Nov 2019 12:37:32 -0800 (PST)
Date: Wed, 20 Nov 2019 12:37:31 -0800 (PST)
Message-Id: <20191120.123731.1860545324110643487.davem@davemloft.net>
To: julietk@linux.vnet.ibm.com
Subject: Re: [PATCH net/ibmvnic 0/2] Support both XIVE and XICS modes in
 ibmvnic
From: David Miller <davem@davemloft.net>
In-Reply-To: <1574265004-8388-1-git-send-email-julietk@linux.vnet.ibm.com>
References: <1574265004-8388-1-git-send-email-julietk@linux.vnet.ibm.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12
 (shards.monkeyblade.net [149.20.54.216]);
 Wed, 20 Nov 2019 12:37:32 -0800 (PST)
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
 tlfalcon@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Juliet Kim <julietk@linux.vnet.ibm.com>
Date: Wed, 20 Nov 2019 10:50:02 -0500

> This series aims to support both XICS and XIVE with avoiding
> a regression in behavior when a system runs in XICS mode.
> 
> Patch 1 reverts commit 11d49ce9f7946dfed4dcf5dbde865c78058b50ab
> (“net/ibmvnic: Fix EOI when running in XIVE mode.”)
> 
> Patch 2 Ignore H_FUNCTION return from H_EOI to tolerate XIVE mode

Series applied, thanks.
