Return-Path: <SRS0=6dJf=FJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A690C4361A
	for <linuxppc-dev@archiver.kernel.org>; Sat,  5 Dec 2020 20:40:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74433230F9
	for <linuxppc-dev@archiver.kernel.org>; Sat,  5 Dec 2020 20:40:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74433230F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CpM0F2NpkzDqWf
	for <linuxppc-dev@archiver.kernel.org>; Sun,  6 Dec 2020 07:40:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=pr-tracker-bot@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=G4+DE28O; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CpKFH1kCyzDqFS
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  6 Dec 2020 06:21:39 +1100 (AEDT)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.10-5 tag
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1607196096;
 bh=6eyBkcMPMeqlM83jdEBCrZVIfNyg0S8EsBP2WDZLCZs=;
 h=From:In-Reply-To:References:Date:To:Cc:From;
 b=G4+DE28OPk3cylqUnozlGeypcjMv3H97I+cm1FMGOo3mV5/HioKTbkZTfObtjpBAP
 5ux/Iz8ZA6E7tLDuL5Tnk/+GJ/DCJOx7pZXoLofTrdEo7Z7rvCE2sCaGyATmHc7JxN
 EFsNozCWNSUDde4/Z+txgMtv4VIh/Sl22ht7ri3rQiIg5i8no6t0OvVwEvr0cG5AgY
 mFcuqsCBsz3z1wutIcCJs0sDCyEhr8VP8YXDDxd//dW68bZP3x70yHlWQHYSvMUzin
 y+v+5czEWEp0qir4N5o/SFVbXCyViMILrS6Pa+ieuC0G7rfBJdjbgWRH7abtW5ml3H
 nSb9QRdmp6fNw==
From: pr-tracker-bot@kernel.org
In-Reply-To: <87im9gtpge.fsf@mpe.ellerman.id.au>
References: <87im9gtpge.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: Linux on PowerPC Developers Mail List
 <linuxppc-dev.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <87im9gtpge.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git
 tags/powerpc-5.10-5
X-PR-Tracked-Commit-Id: a1ee28117077c3bf24e5ab6324c835eaab629c45
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 32f741b02f1a84dd15cdaf74ea3c8d724f812318
Message-Id: <160719609666.18711.2227466213357171756.pr-tracker-bot@kernel.org>
Date: Sat, 05 Dec 2020 19:21:36 +0000
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
Cc: srikar@linux.vnet.ibm.com, peterz@infradead.org,
 linuxppc-dev@lists.ozlabs.org, mahesh@linux.ibm.com, npiggin@gmail.com,
 linux-kernel@vger.kernel.org, groug@kaod.org,
 Linus Torvalds <torvalds@linux-foundation.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The pull request you sent on Sat, 05 Dec 2020 23:19:45 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.10-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/32f741b02f1a84dd15cdaf74ea3c8d724f812318

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
