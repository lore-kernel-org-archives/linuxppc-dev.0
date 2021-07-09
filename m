Return-Path: <SRS0=Utub=MB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F9F2C07E99
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Jul 2021 17:42:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 733B3613CA
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Jul 2021 17:42:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 733B3613CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GM0ps6x1Pz3bmG
	for <linuxppc-dev@archiver.kernel.org>; Sat, 10 Jul 2021 03:42:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=RlrkjDc/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=pr-tracker-bot@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=RlrkjDc/; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GM0pG2m9Xz303X
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Jul 2021 03:41:42 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPS id D6ECF613E1;
 Fri,  9 Jul 2021 17:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1625852497;
 bh=MOul283O27ZPovFHmST+I98tyMjYlh5cPQnCahGxJV4=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=RlrkjDc/LLmCwdiUVWHl3XMUakqy/hSR/3b+Nph8eVEbZZZUBmz3MWyTJUgQ/w3Ps
 Z8Lz0syhxW0XT6W/dKDUJI/fgXCeT20NIu1Oxc7ZDdG/2F+LYHZAzRVYoMMYhudXJs
 nuwpmo8kONhyYF6Lra0Rpfb0EpRDZSxep5Ly1gPcA5/7CjaEVjYSFjshvJ+XSKUKR5
 Wldjbb4KVrEM18mLTisZgMzHHiqMO0yvQSvalDAhTdfds29QL5r/6y7F5jYBaiED8z
 1rizsNuzAQofs1mTaHT63lWa0rKYCyTX3u6ixgkFd+qrwWkVzXci0tX59E9RKHLz+J
 jb18LOxnLENcg==
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.14-2 tag
From: pr-tracker-bot@kernel.org
In-Reply-To: <87czrrob2g.fsf@mpe.ellerman.id.au>
References: <87czrrob2g.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: Linux on PowerPC Developers Mail List
 <linuxppc-dev.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <87czrrob2g.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git
 tags/powerpc-5.14-2
X-PR-Tracked-Commit-Id: 2c669ef6979c370f98d4b876e54f19613c81e075
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1459718d7d79013a4814275c466e0b32da6a26bc
Message-Id: <162585249784.25269.8545698719361257106.pr-tracker-bot@kernel.org>
Date: Fri, 09 Jul 2021 17:41:37 +0000
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
Cc: daniel@iogearbox.net, linuxppc-dev@lists.ozlabs.org, ast@kernel.org,
 npiggin@gmail.com, linux-kernel@vger.kernel.org, clg@kaod.org,
 naveen.n.rao@linux.vnet.ibm.com,
 Linus Torvalds <torvalds@linux-foundation.org>, valentin.schneider@arm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The pull request you sent on Fri, 09 Jul 2021 23:45:27 +1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.14-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1459718d7d79013a4814275c466e0b32da6a26bc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
