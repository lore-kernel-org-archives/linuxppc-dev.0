Return-Path: <SRS0=yyDT=PY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9234AC433EF
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Nov 2021 16:08:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00AD061390
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Nov 2021 16:08:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 00AD061390
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Hm56G3YHsz30Hj
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Nov 2021 03:08:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=XTTfmGPZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=pr-tracker-bot@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=XTTfmGPZ; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Hm55X3Y9zz2ynX
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Nov 2021 03:08:16 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPS id 51A5C6112E;
 Fri,  5 Nov 2021 16:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1636128493;
 bh=/w4W0ESOTR3ErgXkOkcticBCY+46uc64I7Xlcxy9P2w=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=XTTfmGPZSUdGjiAGuod186zifKddnUXjjhvdWNJe0S0cIUg3DKI10zpZ4PGgoOwgP
 7oxx/iDyr/SkaXvBYvKZeHxVLsy/j5kzXqdJQpWyCKhpEH+Tal60DDYqWYA2/YVZ7t
 dypuvJWDqMj6WfQYUrGY2QGyyDH2le2F0fTPzYMHKB9htEfQvGRIPwm1jCXnKtNGHG
 Warp+wiqgmJSl+dC/+MKSaXxYlXf7FSJRUvriaIX5ak1zcszRB3DFwqCDheFYYT0er
 UFyFm7VDPWi3ix3SOzSzb48bmEpioq5rYb7ZDWYq+BUtij/hrDdU0LkfCCILPHnFif
 C2byCe1j0zVpw==
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.16-1 tag
From: pr-tracker-bot@kernel.org
In-Reply-To: <87v9167o32.fsf@mpe.ellerman.id.au>
References: <87v9167o32.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: Linux on PowerPC Developers Mail List
 <linuxppc-dev.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <87v9167o32.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git
 tags/powerpc-5.16-1
X-PR-Tracked-Commit-Id: c12ab8dbc492b992e1ea717db933cee568780c47
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5c0b0c676ac2d84f69568715af91e45b610fe17a
Message-Id: <163612849317.17201.16359583073056008031.pr-tracker-bot@kernel.org>
Date: Fri, 05 Nov 2021 16:08:13 +0000
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
Cc: lvivier@redhat.com, songkai01@inspur.com, aik@ozlabs.ru,
 kda@linux-powerpc.org, linux-kernel@vger.kernel.org, wanjiabing@vivo.com,
 cuibixuan@linux.alibaba.com, peterz@infradead.org, joel@jms.id.au,
 u.kleine-koenig@pengutronix.de, agust@denx.de, atrajeev@linux.vnet.ibm.cm,
 nathanl@linux.ibm.com, schnelle@linux.ibm.com, npiggin@gmail.com, clg@kaod.org,
 nixiaoming@huawei.com, hbathini@linux.ibm.com, dja@axtens.net,
 atrajeev@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 ndesaulniers@google.com, gustavoars@kernel.org, hegdevasant@linux.vnet.ibm.com,
 pbonzini@redhat.com, Linus Torvalds <torvalds@linux-foundation.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The pull request you sent on Sat, 06 Nov 2021 00:02:09 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.16-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5c0b0c676ac2d84f69568715af91e45b610fe17a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
