Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 244B1C433EF
	for <linuxppc-dev@archiver.kernel.org>; Sat, 25 Dec 2021 01:52:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JLRlS3VGBz3c57
	for <linuxppc-dev@archiver.kernel.org>; Sat, 25 Dec 2021 12:52:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gentoo.org (client-ip=2001:470:ea4a:1:5054:ff:fec7:86e4;
 helo=smtp.gentoo.org; envelope-from=gyakovlev@gentoo.org; receiver=<UNKNOWN>)
X-Greylist: delayed 71677 seconds by postgrey-1.36 at boromir;
 Sat, 25 Dec 2021 12:52:29 AEDT
Received: from smtp.gentoo.org (dev.gentoo.org
 [IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JLRl13NpZz2yXc
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Dec 2021 12:52:24 +1100 (AEDT)
Date: Fri, 24 Dec 2021 17:52:09 -0800
From: Georgy Yakovlev <gyakovlev@gentoo.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: aacraid (PM8068) freqent EEH with kernel 5.15 on talos2
Message-ID: <20211225015209.cy3mysa7yxbsxxzj@cerberus.local.sysdump.net>
References: <20211224055728.hionqurxggnkoye2@cerberus.local.sysdump.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211224055728.hionqurxggnkoye2@cerberus.local.sysdump.net>
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

On 23.12.2021 21:57, Georgy Yakovlev wrote:
> Hi,
> 
> I'm looking for help or directions or pointers with my issue.
> I have a Talos2 machine and built-in SAS controller (PM8068) is
> basically unusable due to EEH errors with kernel 5.15+
> 
and it just crashed on 5.10.86 too right on boot in healthcheck command
that controller sends periodically.
I guess I could bisect kernels between
5.10-5.10.8x and find the commit that broke it, that'd be
easier than bisecting between 5.10 and 5.15
