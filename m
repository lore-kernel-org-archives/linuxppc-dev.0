Return-Path: <SRS0=nFyT=4K=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C7C1C35669
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Feb 2020 00:17:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D680320675
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Feb 2020 00:17:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JIIpA3aS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D680320675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48PTRb5GfpzDqpk
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Feb 2020 11:17:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=pr-tracker-bot@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=default header.b=JIIpA3aS; dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48PTNy6V7MzDqfr
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Feb 2020 11:15:14 +1100 (AEDT)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.6-3 tag
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1582330511;
 bh=W3W8pYm8I7eHMCrdn3ZXX+yGKhlB96u/mT1KxqIfAv0=;
 h=From:In-Reply-To:References:Date:To:Cc:From;
 b=JIIpA3aScnOPW9wex9YeSv3xkK8mNA43T2pRU1hOt0f3jiXHwjoni/RUHtw+6ja88
 I2F8Ep2WScZrYfaVPCTzeLQa6z/WOQNSp4Y0BHtU14QOD0l/EJU1PyyVTbVfCzs2bq
 /eH8PxCWnK/zMaW8MQl+3nkuJMAJX/vdiQ8Hae/0=
From: pr-tracker-bot@kernel.org
In-Reply-To: <87lfowdv54.fsf@mpe.ellerman.id.au>
References: <87lfowdv54.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87lfowdv54.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git
 tags/powerpc-5.6-3
X-PR-Tracked-Commit-Id: 9eb425b2e04e0e3006adffea5bf5f227a896f128
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2865936259e27629fac422bc80c9b55ca1f108a5
Message-Id: <158233051185.15315.18250424563849105546.pr-tracker-bot@kernel.org>
Date: Sat, 22 Feb 2020 00:15:11 +0000
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
Cc: mikey@neuling.org, gustavold@linux.ibm.com, sbobroff@linux.ibm.com,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org,
 oohall@gmail.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The pull request you sent on Fri, 21 Feb 2020 22:42:15 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.6-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2865936259e27629fac422bc80c9b55ca1f108a5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
