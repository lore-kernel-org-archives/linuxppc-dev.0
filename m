Return-Path: <SRS0=o62n=O6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 982DFC433EF
	for <linuxppc-dev@archiver.kernel.org>; Sun, 10 Oct 2021 17:18:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E6FF60D42
	for <linuxppc-dev@archiver.kernel.org>; Sun, 10 Oct 2021 17:18:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0E6FF60D42
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HS7tC14d8z303t
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Oct 2021 04:18:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=sBMXhqZB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=pr-tracker-bot@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=sBMXhqZB; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HS7sP3NbCz2y8R
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Oct 2021 04:17:29 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPS id 8B83960F5B;
 Sun, 10 Oct 2021 17:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1633886245;
 bh=eJh/Av348J6EXyMqmxnJs3hSOaKCBJlq1t7N4KMNZq8=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=sBMXhqZBZKFvSSSEj6hyBoV4GdAAE7gFB/iM5o80Ljzd4EZ1niyINxNDRgOwgOqJS
 HSL1ZhAAn7Q4M4V4rj9vJVqgFhuP+/iarlz0vBbSTmmQKIVB0GX5nySGx4cbkNWlhK
 R3YtgSfLNvpYDrVYTXnF7m029Sdc4XfYJw/w55AVztm6Q/PjT57//TF9WrgOLYi0AL
 LvHhsv0e4jttt0DEhkyp+A4XA1HSIKegfs26ud0MF5Vwk2lgV+6m3O+A4ru5whkqaL
 LouebD2JqkpQiEKkdOI8sm4GG4f4CxXSUe8sdnqHqusCcg5GzIvLNLj7LB32mZVc7r
 clx+UR05hNrzg==
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.15-3 tag
From: pr-tracker-bot@kernel.org
In-Reply-To: <87y271m5ft.fsf@mpe.ellerman.id.au>
References: <87y271m5ft.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87y271m5ft.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git
 tags/powerpc-5.15-3
X-PR-Tracked-Commit-Id: eb8257a12192f43ffd41bd90932c39dade958042
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: efb52a7d9511df818391f1afa459507425833438
Message-Id: <163388624552.22826.643587179414757295.pr-tracker-bot@kernel.org>
Date: Sun, 10 Oct 2021 17:17:25 +0000
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
Cc: songliubraving@fb.com, johan.almbladh@anyfinetworks.com, aik@ozlabs.ru,
 linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com, linux-kernel@vger.kernel.org,
 mahesh@linux.ibm.com, clg@kaod.org, naveen.n.rao@linux.vnet.ibm.com,
 Linus Torvalds <torvalds@linux-foundation.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The pull request you sent on Sun, 10 Oct 2021 23:26:30 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.15-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/efb52a7d9511df818391f1afa459507425833438

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
