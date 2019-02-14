Return-Path: <SRS0=RHZ4=QV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D93DDC43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Feb 2019 17:06:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D2A5222DA
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Feb 2019 17:06:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D2A5222DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 440jVB42v4zDqQr
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 04:06:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=lst.de
 (client-ip=213.95.11.211; helo=newverein.lst.de; envelope-from=hch@lst.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lst.de
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 440jRy1P8YzDqP7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Feb 2019 04:04:45 +1100 (AEDT)
Received: by newverein.lst.de (Postfix, from userid 2407)
 id 0BBFA6FA8D; Thu, 14 Feb 2019 18:04:41 +0100 (CET)
Date: Thu, 14 Feb 2019 18:04:40 +0100
From: Christoph Hellwig <hch@lst.de>
To: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 03/11] kernel/locks: consolidate RWSEM_GENERIC_* options
Message-ID: <20190214170440.GB32441@lst.de>
References: <20190213174005.28785-1-hch@lst.de>
 <20190213174005.28785-4-hch@lst.de>
 <CAMuHMdW4C1McxL-e7ZSiSOiiE5D=xbBK8FZOwuJ1w0kK3CR1Hg@mail.gmail.com>
 <d9aeeedd-ce72-f58f-d858-3e340c073414@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9aeeedd-ce72-f58f-d858-3e340c073414@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
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
Cc: Linux-Arch <linux-arch@vger.kernel.org>,
 linux-s390 <linux-s390@vger.kernel.org>,
 linux-kbuild <linux-kbuild@vger.kernel.org>, linux-xtensa@linux-xtensa.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>, linux-riscv@lists.infradead.org,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Christoph Hellwig <hch@lst.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Feb 14, 2019 at 10:26:52AM -0500, Waiman Long wrote:
> Would you mind dropping just patch 3 from your series?

Sure, we can just drop this patch.
