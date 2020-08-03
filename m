Return-Path: <SRS0=LND+=BN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C08C433DF
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2020 05:35:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCD842068F
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2020 05:35:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCD842068F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BKmnH4W74zDqTx
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2020 15:35:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=1wt.eu
 (client-ip=62.212.114.60; helo=1wt.eu; envelope-from=w@1wt.eu;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=1wt.eu
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
 by lists.ozlabs.org (Postfix) with ESMTP id 4BKmlC4CrQzDqT5
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Aug 2020 15:33:42 +1000 (AEST)
Received: (from willy@localhost)
 by pcw.home.local (8.15.2/8.15.2/Submit) id 0735XTuL015640;
 Mon, 3 Aug 2020 07:33:29 +0200
Date: Mon, 3 Aug 2020 07:33:29 +0200
From: Willy Tarreau <w@1wt.eu>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: powerpc: build failures in Linus' tree
Message-ID: <20200803053329.GA15637@1wt.eu>
References: <20200802204842.36bca162@canb.auug.org.au>
 <20200802172019.GB26677@1wt.eu> <20200803034547.GA15501@1wt.eu>
 <20200803141017.55dd6cc7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200803141017.55dd6cc7@canb.auug.org.au>
User-Agent: Mutt/1.6.1 (2016-04-27)
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
Cc: Linux-kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Paul Mackerras <paulus@samba.org>, PowerPC <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Aug 03, 2020 at 02:10:17PM +1000, Stephen Rothwell wrote:
> Our mails have crossed.

Ah indeed :-)

> I just sent a more comprehensive patch.  I
> think your patch would require a lot of build testing and even then may
> fail for some CONFIG combination that we didn't test or added in the
> future (or someone just made up).

Your looks far more complete and very likely more future-proof, I
totally agree.

Thanks!
Willy
