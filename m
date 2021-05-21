Return-Path: <SRS0=GbMY=KQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 931C9C433ED
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 May 2021 08:44:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E400061363
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 May 2021 08:44:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E400061363
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FmgCJ3nx1z3btT
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 May 2021 18:44:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=fP5rQdvO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=johan@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=fP5rQdvO; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FmgBq6HqLz2ydJ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 May 2021 18:44:19 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2551C61132;
 Fri, 21 May 2021 08:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1621586657;
 bh=fY4e7ykqhvSoW1RpAc1F8J1V9nk15p3JpTYuVVpm084=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=fP5rQdvOGkUlGaxvZZRkFpsiBQs84cK1wUJ26p1FuLErCL9f5W2Amjp9j6M5WiXhR
 fkbrdZ4Pr8UrJzli4BFy8X2iazL3l2h11JeklyzjIcNDjnvbwTlF0yEDM6UKEb5OTz
 OQ/6nnPyVk4ID5JICoD4dEPHVlQuv9/UcTitN3kHSL2EWnF90VjJFfP+ZGV/X7Zq57
 XvMvr+IpVK9lABBN+43up9EPKtI0rENzkn2TpuwpeqM7jrDIQFCsnIAKjc6K6Heuhu
 hanoHoG8GxZx/J2htkxVwM1VHjVI4h9Gp9Qz2gVugX2F9KgbrmLEocz0r5xafyRq3e
 5Dv8lrYHfS6EQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
 (envelope-from <johan@kernel.org>)
 id 1lk0lU-000592-T9; Fri, 21 May 2021 10:44:17 +0200
Date: Fri, 21 May 2021 10:44:16 +0200
From: Johan Hovold <johan@kernel.org>
To: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 6/9] tty: hvc_console: Fix coding style issues of block
 comments
Message-ID: <YKdy4PlnhalPIRQv@hovoldconsulting.com>
References: <1621233433-27094-1-git-send-email-tanxiaofei@huawei.com>
 <1621233433-27094-7-git-send-email-tanxiaofei@huawei.com>
 <YKJ6ZjT8o5xJmBCr@hovoldconsulting.com>
 <e88b6fcd-bfe1-9812-905a-862825f420ce@huawei.com>
 <YKYcFfKiHT39Gyey@hovoldconsulting.com>
 <3173f7f10e0c212c8c828d9ca4450927f757e7d2.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3173f7f10e0c212c8c828d9ca4450927f757e7d2.camel@perches.com>
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
Cc: gregkh@linuxfoundation.org, linuxppc-dev@lists.ozlabs.org,
 linuxarm@openeuler.org, linux-kernel@vger.kernel.org,
 Xiaofei Tan <tanxiaofei@huawei.com>, jirislaby@kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, May 20, 2021 at 08:21:39AM -0700, Joe Perches wrote:
> On Thu, 2021-05-20 at 10:21 +0200, Johan Hovold wrote:
> > On Tue, May 18, 2021 at 12:01:22PM +0800, Xiaofei Tan wrote:
> > > On 2021/5/17 22:15, Johan Hovold wrote:

> > > > How is this an improvement? First, the multi-line comment style is
> > > > 
> > > > 	/*
> > > > 	 * ...
> > > > 	 */
> > > > 
> > > 
> > > Yes, mostly we use this style. I can follow it if new version is needed.
> > 
> > This is the preferred style outside of networking.
> > 
> > > BTW, How about add the '/*' check into checkpatch.pl?
> > 
> > Checkpatch already has too many checks IMO
> 
> I sometimes agree.  What checkpatch messages do you think are excessive?

The "unsigned" -> "unsigned int" one comes to mind (at least when
running with -f).

Most of the questionable ones are probably hidden behind --subjective,
but due to the unfortunate alias of that switch as --strict, people
don't get the message to use their own judgement and instead think
they'll get a gold star for "full compliance".

So my issue isn't so much which checkpatch itself rather than with how
it is being used and promoted, for example, to introduce aspiring
developers to kernel development in staging.

It's a great tool to run on your own patches before submission (as was
originally intended judging by the apt name), but if I could change
something I'd drop the --strict alias for the --subjective checks and
disable that switch for staging.

Perhaps also add a warning or similar when running with -f on in-tree
code outside of staging.
 
> > and I'm a bit surprised that
> > it doesn't check this already. Perhaps it's because you used the -f to
> > run checkpatch on in-kernel code, which you should not.
> 
> Likely not.  If it was run on a suggested patch, checkpatch doesn't emit
> many messages on unmodified patch context lines.  And it shouldn't.

Right, but here it appears to have been run using -f on in-tree code.

You could still check for this when adding new comments, and perhaps it
already does.

> > it's just that you
> > introduce noise in the logs and do pointless changes of context which
> > makes it harder to use tools like git blame and makes backporting harder
> > for no good reason.
> 
> Pretty pointless metric IMO.  Context changes in comments are mostly harmless.

This isn't just about comment changes but the whole array of
white-space shifting and other pendantry. And also reformatted comments
makes it harder to do code forensics.

> IMO: backporting of these sorts non-bug fix changes is done _far_ too often.

I have yet to see AUTOSEL pick up white-space cleanups but there are
certainly a few non-bug-fix patches currently being backported.

Johan
