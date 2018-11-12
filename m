Return-Path: <SRS0=Ph+o=NX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A3AC43441
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Nov 2018 21:33:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36D1A2241E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Nov 2018 21:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B6zkJWtl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36D1A2241E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42v3sW6Gj4zF1yM
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Nov 2018 08:33:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=infradead.org header.i=@infradead.org header.b="B6zkJWtl";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1231::1; helo=merlin.infradead.org;
 envelope-from=geoff@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="B6zkJWtl"; dkim-atps=neutral
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:8b0:10b:1231::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42v3q21HMDzF3LT
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Nov 2018 08:31:26 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hpMwYXKPi2k2kndV9SPZvFH4cZLQ4AgmoRzDv/06R40=; b=B6zkJWtlujzMC4VKfcezPAfF1X
 lSgU3RQPEU0Qyr74WXcoT8bpOI5lHdms/0Ro44VWmz+jsaXJDKfKecoxVzyF68cVAHaWRkTcSenlc
 tbZPpsbB8lSQUwxtOpvE8yeFUaId/q8xYNAKmMyllhH0lzqKFmAHDstER+uM4wkSH5w1obBRKWhK+
 iQU039wPXGGe8V7CGKALrQ2ReFDKBawUfWiiEiHMJe5e/EcqP5Gdng3YCJ3TTVlj0Ln7CBbGuMrN5
 WSi7kNPg4LxqHkq/fDBlKZNQ/UJrMAOp704/dLbRKLZR88Sq1nev13yPQ0HcSi2JjJuyfianhToUR
 x+90nPzw==;
Received: from 50-233-148-155-static.hfc.comcastbusiness.net ([50.233.148.155]
 helo=[10.18.6.178])
 by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gMIcM-0003y7-SG; Mon, 12 Nov 2018 20:15:31 +0000
Subject: Re: [PATCH] Documentation: fix spelling mistake, EACCESS -> EACCES
To: Michael Ellerman <mpe@ellerman.id.au>, Jeremy Kerr <jk@ozlabs.org>,
 Jonathan Corbet <corbet@lwn.net>, Colin King <colin.king@canonical.com>
References: <20181026172549.3628-1-colin.king@canonical.com>
 <20181107153104.71eddf4d@lwn.net>
 <d1048515-239a-2686-e897-fb2a2b8d180f@ozlabs.org>
 <87bm6ua1xp.fsf@concordia.ellerman.id.au>
From: Geoff Levand <geoff@infradead.org>
Message-ID: <84e64a8b-765b-e89d-7427-5fd3a660575f@infradead.org>
Date: Mon, 12 Nov 2018 12:15:27 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87bm6ua1xp.fsf@concordia.ellerman.id.au>
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
Cc: kernel-janitors@vger.kernel.org, linux-doc@vger.kernel.org,
 David Airlie <airlied@linux.ie>, linuxppc-dev@lists.ozlabs.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 linux-kernel@vger.kernel.org, Maxime Ripard <maxime.ripard@bootlin.com>,
 Sean Paul <sean@poorly.run>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Everyone,

On 11/12/2018 04:57 AM, Michael Ellerman wrote:
> But maybe Geoff has a better feel for how many people (other than him)
> are still running upstream on PS3s.

There are still PS3 users out there.  They are hobbyists who
generally don't post to Linux kernel mailing lists.  I usually
get one or two mail or IRC inquiries every month, many asking
how to get a recent kernel running.

I try keep my dev repo at k.org up to the latest -rc release
and tested on the retail PS3.  For more info see:

  https://git.kernel.org/pub/scm/linux/kernel/git/geoff/ps3-linux.git
  https://www.kernel.org/pub/linux/kernel/people/geoff/cell/README

-Geoff
