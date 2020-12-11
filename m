Return-Path: <SRS0=d9E3=FP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E7AC433FE
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Dec 2020 00:41:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91C9023DB4
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Dec 2020 00:41:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91C9023DB4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CsX6M12RRzDqsy
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Dec 2020 11:41:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=pr-tracker-bot@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=L4cL4IEn; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CsX4T0FSJzDqlV
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Dec 2020 11:40:08 +1100 (AEDT)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.10-6 tag
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1607647206;
 bh=sOEfvadm1MFJBkWahDkvvu0eQu9e4044ek0+X0D9/58=;
 h=From:In-Reply-To:References:Date:To:Cc:From;
 b=L4cL4IEnJGh3jdEhys1vpmJ4oc1Izhb91A8z5ypQaR0MyU4rE95YbKK2ZiohRB1FG
 hH0effp63qYZ3c2z/+jvuf5KHmciBZ8FuQ7MyJV0j+YkCF+sACQmgQnxG1qWVbjaUU
 zzfzmMdOCwK919YmIuVB8ee0RwGMsRL7Xao2Wog55h9FLBHTntJYnUEce+rGpKpaDB
 K1a82Iqp6ZGC3p67kzFK7EnAJZ6tt4b5tFzJma63yUS0+o0E6NxxNQnuicNuQbxKKO
 yepy6TKe+aRGOYBfqrq1pMguGVZ1YR+IqtacrE24Iudy7Kmoy+dsArCBm/1cJD5X7b
 1rGAUfkks0Vvw==
From: pr-tracker-bot@kernel.org
In-Reply-To: <878sa5rxx4.fsf@mpe.ellerman.id.au>
References: <878sa5rxx4.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <878sa5rxx4.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git
 tags/powerpc-5.10-6
X-PR-Tracked-Commit-Id: 5eedf9fe8db23313df104576845cec5f481b9b60
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 47003b9971cc7c38737f21e07034502ca35ab7af
Message-Id: <160764720624.1595.7316604659116143322.pr-tracker-bot@kernel.org>
Date: Fri, 11 Dec 2020 00:40:06 +0000
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
 Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The pull request you sent on Fri, 11 Dec 2020 11:25:43 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.10-6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/47003b9971cc7c38737f21e07034502ca35ab7af

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
