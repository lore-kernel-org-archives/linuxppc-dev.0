Return-Path: <SRS0=UD/r=UN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C83AC31E44
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Jun 2019 07:51:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86A492084E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Jun 2019 07:51:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86A492084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45QCVQ1sRDzDrRJ
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Jun 2019 17:51:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=lst.de
 (client-ip=213.95.11.211; helo=newverein.lst.de; envelope-from=hch@lst.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lst.de
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45QCSW0182zDr6L
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Jun 2019 17:50:00 +1000 (AEST)
Received: by newverein.lst.de (Postfix, from userid 2407)
 id 9112068B02; Fri, 14 Jun 2019 09:49:28 +0200 (CEST)
Date: Fri, 14 Jun 2019 09:49:28 +0200
From: Christoph Hellwig <hch@lst.de>
To: Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: remove asm-generic/ptrace.h v2
Message-ID: <20190614074928.GA9631@lst.de>
References: <20190520060018.25569-1-hch@lst.de> <20190604070205.GA15438@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190604070205.GA15438@lst.de>
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
Cc: linux-arch@vger.kernel.org, linux-sh@vger.kernel.org, x86@kernel.org,
 linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Jun 04, 2019 at 09:02:05AM +0200, Christoph Hellwig wrote:
> Is anyone going to pick this series up?

ping?  Arnd, this might be asm-generic tree material?
