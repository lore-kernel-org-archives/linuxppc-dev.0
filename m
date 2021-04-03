Return-Path: <SRS0=+tx8=JA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F39C433ED
	for <linuxppc-dev@archiver.kernel.org>; Sat,  3 Apr 2021 18:19:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C44861247
	for <linuxppc-dev@archiver.kernel.org>; Sat,  3 Apr 2021 18:19:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C44861247
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FCQDF6whDz3c4J
	for <linuxppc-dev@archiver.kernel.org>; Sun,  4 Apr 2021 04:19:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=cjuF4ugf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=pr-tracker-bot@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=cjuF4ugf; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FCQCl21Hgz2xZL
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  4 Apr 2021 04:18:42 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPS id D679061247;
 Sat,  3 Apr 2021 18:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617473919;
 bh=PY+a1N+fZF+1R0kW1kSHaP53kLviE/U+7+MGrM/eIwE=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=cjuF4ugfYdcyeQ43VZw1X8XGKYcLrarAG/dHsPTO05OYkihwS72ebYQvtMiRb4FB8
 8pRMwiez7DYaap/fXEiPQ+pM4QUDvatqEyyHUKe3fnhj/p6ejgMwRJDPR10LTp5M3G
 YloGJBnK7HUpPrw+Uet4zsTa+Da6n4/MPLp/yoN+L6Dq2ESWZdXveEcnJ9IYmVXkOU
 MvQ0dxX7rB+kO6zrk0uC1GD8X58uXJn1zOvawJ8r57065ySwiL8bZWniZB+4ZJEVse
 P821rTXoqlLMAjlKqFuN+kgt8djiPBo4KSyd0rcUBAH//t3h3I9QV7UfCnGfwjbuxQ
 TNU4ldcTbMdhw==
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.12-5 tag
From: pr-tracker-bot@kernel.org
In-Reply-To: <871rbr1te5.fsf@mpe.ellerman.id.au>
References: <871rbr1te5.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: Linux on PowerPC Developers Mail List
 <linuxppc-dev.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <871rbr1te5.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git
 tags/powerpc-5.12-5
X-PR-Tracked-Commit-Id: 53f1d31708f6240e4615b0927df31f182e389e2f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9c2ef23e4dae122d2b18e834d90f8bd4dda48fe6
Message-Id: <161747391973.13474.14283872332789051789.pr-tracker-bot@kernel.org>
Date: Sat, 03 Apr 2021 18:18:39 +0000
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
Cc: nathanl@linux.ibm.com, aneesh.kumar@linux.ibm.com,
 Linus Torvalds <torvalds@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The pull request you sent on Sat, 03 Apr 2021 22:48:02 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.12-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9c2ef23e4dae122d2b18e834d90f8bd4dda48fe6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
