Return-Path: <SRS0=Q8z7=NZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47FA0C433EF
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Sep 2021 18:46:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A05A261051
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Sep 2021 18:46:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A05A261051
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4H1Rb80Bshz305f
	for <linuxppc-dev@archiver.kernel.org>; Sat,  4 Sep 2021 04:46:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Ak9c74eP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=pr-tracker-bot@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Ak9c74eP; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4H1RZQ2Jtkz2xs6
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 Sep 2021 04:45:50 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPS id E7137610C8;
 Fri,  3 Sep 2021 18:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1630694747;
 bh=AkCPQb2yqeTwUVd5Vl21Qi7MY/PJIAnM9KHXiVDXC54=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=Ak9c74ePIizyxae+UNefMGmwMsxeMutZAH30g0jH1enmW+4E+qq2wlcefgL8X3Ami
 CBWE769YThxz2K8fZrT31QQBt+QObP9UHIZmNvYk/C0I5w/BGJmjSsoe6eAfnl4nXO
 co0sM/rcmNads92xIAQmGtUg6zB4mnVwSqwnDXmtbDwYUZSMvMSE+QTfJ02xD+81yO
 mN4zJFRXJ1oPzOfFoWKC4XvDTjBRp2oXWy1m6Dr0iecL//mL/3yuyY+OjExs2bcStJ
 b0gnv4MfKhYrgPFGsxo1hjsYV3L6K4wQKL/eCkcP3rO0pJiGMtxtLFhaBKz6KvETTU
 Rc2BXCVc1rjaQ==
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.15-1 tag
From: pr-tracker-bot@kernel.org
In-Reply-To: <87pmtppypy.fsf@mpe.ellerman.id.au>
References: <87pmtppypy.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87pmtppypy.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git
 tags/powerpc-5.15-1
X-PR-Tracked-Commit-Id: a3314262eede9c909a0c797f16f25f941d12c78d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7cca308cfdc0725363ac5943dca9dcd49cc1d2d5
Message-Id: <163069474689.21432.8300147386919741619.pr-tracker-bot@kernel.org>
Date: Fri, 03 Sep 2021 18:45:46 +0000
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
Cc: ego@linux.vnet.ibm.com, srikar@linux.vnet.ibm.com, parth@linux.ibm.com,
 aik@ozlabs.ru, jniethe5@gmail.com, bigeasy@linutronix.de,
 psampat@linux.ibm.com, paul.gortmaker@windriver.com, leobras.c@gmail.com,
 wanjiabing@vivo.com, lkp@intel.com, maskray@google.com, linkmauve@linkmauve.fr,
 aneesh.kumar@linux.ibm.com, masahiroy@kernel.org, joel@jms.id.au,
 lukas.bulwahn@gmail.com, kjain@linux.ibm.com, npiggin@gmail.com,
 nathan@kernel.org, clg@kaod.org, Thomas Gleixner <tglx@linutronix.de>,
 ldufour@linux.ibm.com, hbathini@linux.ibm.com, oss@buserror.net,
 msuchanek@suse.de, fthain@linux-m68k.org, farosas@linux.ibm.com,
 sxwjean@gmail.com, Linus Torvalds <torvalds@linux-foundation.org>,
 rdunlap@infradead.org, linux-kernel@vger.kernel.org,
 Marc Zyngier <maz@kernel.org>, zhengyongjun3@huawei.com,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The pull request you sent on Fri, 03 Sep 2021 23:36:57 +1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.15-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7cca308cfdc0725363ac5943dca9dcd49cc1d2d5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
