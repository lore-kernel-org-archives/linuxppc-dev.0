Return-Path: <SRS0=pcIm=NN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE1DC4338F
	for <linuxppc-dev@archiver.kernel.org>; Sun, 22 Aug 2021 17:11:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68A236103B
	for <linuxppc-dev@archiver.kernel.org>; Sun, 22 Aug 2021 17:11:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 68A236103B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Gt22V4kjLz30Fy
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Aug 2021 03:10:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ErUOWLhl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=pr-tracker-bot@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=ErUOWLhl; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Gt21j45wcz2yfZ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Aug 2021 03:10:17 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPS id 5BDD461266;
 Sun, 22 Aug 2021 17:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1629652213;
 bh=gaJ9wHL88SpphYcVif0RN4HGPXwlZsWqDIhFdweDQOw=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=ErUOWLhlUTQbstBK5fWWmWKm2LXzVdnU1vJ0MebifgvtNUhxuw3BpswBvehjnKiC2
 mKZnpr2hbDAMSIJswOfAVamvyXRQTEMZyyaPefYNUJdBve48w61eY0XWdbczMaBzEp
 JLOV48/V4JFZ8JZpL+g+9b7ASpJ59FcapF78hCFNBSyJ4v2/1pYTSLuW61vM+G+ZyA
 41gLgT/a8Z4mrIreLJrvgo9jJ3NJxNqlj7fWhIpLPiv1oWOpprxX5N6FP0fWnWzoJG
 +Dlveq9EoGFYj/m43AvZ/IMk53iTIIFTS7pCjwNbnmIcjyp3VWyAEugzA6TQi9Kbfr
 HYulQoV6QDopw==
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.14-6 tag
From: pr-tracker-bot@kernel.org
In-Reply-To: <87mtpacq35.fsf@mpe.ellerman.id.au>
References: <87mtpacq35.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: Linux on PowerPC Developers Mail List
 <linuxppc-dev.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <87mtpacq35.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git
 tags/powerpc-5.14-6
X-PR-Tracked-Commit-Id: 9f7853d7609d59172eecfc5e7ccf503bc1b690bd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1bdc3d5be7e199ff56f39dafb0e5f63a9b8c975d
Message-Id: <162965221323.3005.13288383826569608839.pr-tracker-bot@kernel.org>
Date: Sun, 22 Aug 2021 17:10:13 +0000
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
Cc: nathan@kernel.org, linuxppc-dev@lists.ozlabs.org,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The pull request you sent on Sun, 22 Aug 2021 09:53:18 +1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.14-6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1bdc3d5be7e199ff56f39dafb0e5f63a9b8c975d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
