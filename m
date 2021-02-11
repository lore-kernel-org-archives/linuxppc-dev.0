Return-Path: <SRS0=2rmQ=HN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 902DBC433E0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Feb 2021 23:53:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8595B64E44
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Feb 2021 23:53:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8595B64E44
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DcD3Y0FzpzDwr2
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Feb 2021 10:53:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=pr-tracker-bot@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=AZVv5t5L; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DcD1S43sxzDwpf
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Feb 2021 10:51:40 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPS id 5A50264E44;
 Thu, 11 Feb 2021 23:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1613087498;
 bh=hCu6gUGDP9UN+JzdIaPKdPU+JA0XEE3mofDzVcBUxUM=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=AZVv5t5L128wKsYqO0qy5imi2ONRaWlkl/vdXGGQwjbhwQcjUfsS36nMfE4vaunVd
 iHYTuBTbq9EdXpFHXVB5MawmhpQQHVbWVBxNx4SDgNk+i1eHeCVabZLmdMchVJbdVJ
 NdbgTpIdRnD6dAkGmsUu67oDV8z7350lHKyvgvfq3J428IclBcuWwxW6u/jxEDzSH5
 C+mUN8pX2R7f9O+u7UqxQjA2ZckzbxpXdraQXclLwfUB22Z53THWJ/ZquKAyi9jv13
 XJQCDZo5JKVtRZXTscKuG528OZ98a8rd57ePUtW4C+SSb0JItoGyxi8Np43+RS86PN
 5h6qviTNIe97w==
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.11-8 tag
From: pr-tracker-bot@kernel.org
In-Reply-To: <87blcqnqkw.fsf@mpe.ellerman.id.au>
References: <87blcqnqkw.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: Linux on PowerPC Developers Mail List
 <linuxppc-dev.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <87blcqnqkw.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git
 tags/powerpc-5.11-8
X-PR-Tracked-Commit-Id: 8c511eff1827239f24ded212b1bcda7ca5b16203
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dcc0b49040c70ad827a7f3d58a21b01fdb14e749
Message-Id: <161308749821.14652.3292558738499889917.pr-tracker-bot@kernel.org>
Date: Thu, 11 Feb 2021 23:51:38 +0000
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
Cc: aneesh.kumar@linux.ibm.com, Linus Torvalds <torvalds@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The pull request you sent on Fri, 12 Feb 2021 10:15:59 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.11-8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dcc0b49040c70ad827a7f3d58a21b01fdb14e749

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
