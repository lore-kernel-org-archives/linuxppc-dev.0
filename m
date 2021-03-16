Return-Path: <SRS0=5tyt=IO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ABA6C433E0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Mar 2021 17:14:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B41B965013
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Mar 2021 17:14:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B41B965013
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F0Kf20Gwxz3bn7
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Mar 2021 04:14:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=JJhWXyR9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05; helo=desiato.infradead.org;
 envelope-from=geoff@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=desiato.20200630 header.b=JJhWXyR9; 
 dkim-atps=neutral
Received: from desiato.infradead.org (desiato.infradead.org
 [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F0KdW16qlz30Dd
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Mar 2021 04:14:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
 :MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=SNd1NC05kzjzUXrk9iyFECNnh7DNfCihWph8pL99bq8=; b=JJhWXyR9bT6NbKdEAKE9PYA+Wn
 pcarwhC/oci2ZPPjV+XG3kjJ2mmxJn9ShFlXQy1faXD3HMdTfn7qwq1pgftW/tO7DLKKGqftH0UPK
 rZyO9Rd4nijI6xbwUeVkYlwoA0pXneE+vc9W+HOQw76EJiKXvqj+9nVqHyZJ9tfGwHo1c4WBUji8L
 UN1MLo+ble4DXOuQ3ckQBh/FUYhiz+2vnGJwOpEQF0fNo9qD7yWzpCsEIF+m7+vLNmjfIaCTUMuvP
 CbXWKUkmZNEeSJICcxGKWoe1W+E6dEWcSvSz3z7uvC5cw6wceI8G4ntr8wosGzzEz+ECXfT1tuYAg
 kKPYVdiw==;
Received: from [2602:306:c5a2:a380:9e7b:efff:fe40:2b26]
 by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lMDGY-001O05-Bx; Tue, 16 Mar 2021 17:13:59 +0000
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
From: Geoff Levand <geoff@infradead.org>
Subject: [PATCH] MAINTAINERS: Update Spidernet network driver
Message-ID: <6399e3a4-c8b0-e015-c766-07cbb87780ab@infradead.org>
Date: Tue, 16 Mar 2021 10:13:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Change the Spidernet network driver from supported to
maintained, add the linuxppc-dev ML, and add myself as
a 'maintainer'.

Cc: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 MAINTAINERS | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index aa84121c5611..7451cd55af18 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16887,8 +16887,10 @@ F:	tools/spi/
 
 SPIDERNET NETWORK DRIVER for CELL
 M:	Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
+M:	Geoff Levand <geoff@infradead.org>
 L:	netdev@vger.kernel.org
-S:	Supported
+L:	linuxppc-dev@lists.ozlabs.org
+S:	Maintained
 F:	Documentation/networking/device_drivers/ethernet/toshiba/spider_net.rst
 F:	drivers/net/ethernet/toshiba/spider_net*
 
-- 
2.25.1

