Return-Path: <SRS0=zfR2=G3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D7EC433DB
	for <linuxppc-dev@archiver.kernel.org>; Sun, 24 Jan 2021 18:37:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6ADE722C9F
	for <linuxppc-dev@archiver.kernel.org>; Sun, 24 Jan 2021 18:37:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ADE722C9F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DP1v00SMBzDqXR
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Jan 2021 05:37:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=pr-tracker-bot@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=VXLprnrc; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DP1rG4wYgzDqWl
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jan 2021 05:34:54 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPS id 0CA0B22CF6;
 Sun, 24 Jan 2021 18:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1611513292;
 bh=Kffcz1wAhen1BarIl0DYIR7DQjOt9KbQPSFaIKnatbE=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=VXLprnrceSsj+GWH9oWdu5zMnbm/9UTIzVrjaWhUItQo5cOf3rJ7cpvYQh36yxuvj
 cibdKhmdJqJFyepxAk8N2pNQ32ZPHniuDWK8VFqVx7HEaBHUKl9iicpBc9QrJj1gpS
 4KZTxmR6wGxoipUjBGpBV/dDG84sA6sOZyeSU0VqT/u7o79zFgmvg1lxNU2th80KXq
 GtopUvfBhXyXIfhmkwlN9NFkKzF9vfAFT6E5ZUJCOjlFUWDvLG2tdItztRGfuVyOZx
 /nfavsmLx6GAWA+m6QpLXTwNmy29XAXmpmopKQropk6Ytfh3WKxRxQhC4AnpVXNInV
 4ZUTznzSHBckA==
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.11-5 tag
From: pr-tracker-bot@kernel.org
In-Reply-To: <87tur6pm2v.fsf@mpe.ellerman.id.au>
References: <87tur6pm2v.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: Linux on PowerPC Developers Mail List
 <linuxppc-dev.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <87tur6pm2v.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git
 tags/powerpc-5.11-5
X-PR-Tracked-Commit-Id: 08685be7761d69914f08c3d6211c543a385a5b9c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 14c50a66183856672d822f25dbb73ad26d1e8f11
Message-Id: <161151329202.2223.9266502406259930102.pr-tracker-bot@kernel.org>
Date: Sun, 24 Jan 2021 18:34:52 +0000
To: Michael Ellerman <mpe@ellerman.id.au>
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
Cc: linuxppc-dev@lists.ozlabs.org,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org,
 npiggin@gmail.com, sandipan@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The pull request you sent on Sun, 24 Jan 2021 23:15:52 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.11-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/14c50a66183856672d822f25dbb73ad26d1e8f11

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
