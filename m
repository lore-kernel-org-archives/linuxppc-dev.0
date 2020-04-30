Return-Path: <SRS0=8RrW=6O=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E607C4724C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Apr 2020 19:59:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E09672072A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Apr 2020 19:59:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E09672072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49CmS96DGYzDrGx
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 May 2020 05:59:37 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 49CmPT6tJSzDr76
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 May 2020 05:57:08 +1000 (AEST)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: davem-davemloft)
 by shards.monkeyblade.net (Postfix) with ESMTPSA id 4DE7A1289CE3F;
 Thu, 30 Apr 2020 12:56:55 -0700 (PDT)
Date: Thu, 30 Apr 2020 12:56:54 -0700 (PDT)
Message-Id: <20200430.125654.335144341485365161.davem@davemloft.net>
To: mchehab+huawei@kernel.org
Subject: Re: [PATCH 00/37] net: manually convert files to ReST format - part 2
From: David Miller <davem@davemloft.net>
In-Reply-To: <cover.1588261997.git.mchehab+huawei@kernel.org>
References: <cover.1588261997.git.mchehab+huawei@kernel.org>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12
 (shards.monkeyblade.net [149.20.54.216]);
 Thu, 30 Apr 2020 12:56:56 -0700 (PDT)
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
Cc: marcelo.leitner@gmail.com, linux-doc@vger.kernel.org, dhowells@redhat.com,
 linux-sctp@vger.kernel.org, paulus@samba.org, ioana.ciornei@nxp.com,
 linux-afs@lists.infradead.org, devel@driverdev.osuosl.org,
 rds-devel@oss.oracle.com, socketcan@hartkopp.net, ruxandra.radulescu@nxp.com,
 corbet@lwn.net, linux-rdma@vger.kernel.org, kadlec@netfilter.org,
 coreteam@netfilter.org, kuba@kernel.org, pablo@netfilter.org,
 linux-x25@vger.kernel.org, santosh.shilimkar@oracle.com,
 linux-can@vger.kernel.org, mkl@pengutronix.de, courmisch@gmail.com,
 kvalo@codeaurora.org, fw@strlen.de, nhorman@tuxdriver.com, geoff@infradead.org,
 netdev@vger.kernel.org, vyasevich@gmail.com, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
 gregkh@linuxfoundation.org, johannes@sipsolutions.net,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Date: Thu, 30 Apr 2020 18:03:55 +0200

> That's the second part of my work to convert the networking
> text files into ReST. it is based on today's linux-next (next-20200430).
> 
> The full series (including those ones) are at:
> 
> 	https://git.linuxtv.org/mchehab/experimental.git/log/?h=net-docs
> 
> I should be sending the remaining patches (another /38 series)
> after getting those merged at -next.
> 
> The documents, converted to HTML via the building system are at:
> 
> 	https://www.infradead.org/~mchehab/kernel_docs/networking/

Series applied to net-next, thank you.
