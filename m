Return-Path: <SRS0=Kv2y=OJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11BB1C433F5
	for <linuxppc-dev@archiver.kernel.org>; Sun, 19 Sep 2021 20:37:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70E9E610A8
	for <linuxppc-dev@archiver.kernel.org>; Sun, 19 Sep 2021 20:37:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 70E9E610A8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HCKHr6flLz2yLm
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Sep 2021 06:37:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=NToxPfQI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=pr-tracker-bot@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=NToxPfQI; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HCKH73CFxz2xVt
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Sep 2021 06:36:51 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPS id 2E4E060F9D;
 Sun, 19 Sep 2021 20:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632083806;
 bh=XTHmTVV2APP632VHdloycbk+OBnt05lAmiyLvwqYOxs=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=NToxPfQIVWUxYtAbDmWh7AGCRWYsQOD9Y24YoFMjKQfemW7H2S2mst1ocBbUxVfBh
 uAIcgp0YGCfleLYSrwUVa50wVN0zFIqhOKiyTG4Ug9M5I7FsIHxovdE00BemH5hgsV
 n7uIY2bEtyAPbRTN0bF72LqlyVL6N6wOTuPRo8IHyTyhqdQASmcc/k8gnpJCOxlAHu
 JWo/5ABTtbw33KLqygmWmhcpq9gxemoct4ZNe/K9wK8rlhkdpumFcRAh654LpJS0re
 +YWY+8+JCqoCFhRtwRbg2xjhzt/SzNTE0gUgvZo6s1qRJVHiOkDEp71FWwngeDh1e5
 RbQ2vrdjJDuUg==
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.15-2 tag
From: pr-tracker-bot@kernel.org
In-Reply-To: <87o88oiuc7.fsf@mpe.ellerman.id.au>
References: <87o88oiuc7.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87o88oiuc7.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git
 tags/powerpc-5.15-2
X-PR-Tracked-Commit-Id: c006a06508db4841d256d82f42da392d6391f3d9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 62453a460a000156b100bf20ab78cf77232284d0
Message-Id: <163208380614.27843.1001207654153663082.pr-tracker-bot@kernel.org>
Date: Sun, 19 Sep 2021 20:36:46 +0000
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
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 linux-kernel@vger.kernel.org, npiggin@gmail.com, ganeshgr@linux.ibm.com,
 clg@kaod.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The pull request you sent on Sun, 19 Sep 2021 23:11:04 +1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.15-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/62453a460a000156b100bf20ab78cf77232284d0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
