Return-Path: <SRS0=TJyh=PE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E83EC43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Dec 2018 22:07:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D39C021909
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Dec 2018 22:07:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fP9k8+CO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D39C021909
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43QkV85nvTzDqGY
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Dec 2018 09:07:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fP9k8+CO";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=pr-tracker-bot@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="fP9k8+CO"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43QkR80jCGzDqGF
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Dec 2018 09:05:08 +1100 (AEDT)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-4.21-1 tag
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1545948305;
 bh=EiXq9HRxGheLmnVgq800w7Ch5vj/wTswhR4kNBhUUyk=;
 h=From:In-Reply-To:References:Date:To:Cc:From;
 b=fP9k8+COUNpEbwtzPaX35YihI2pBfladLdD8RAJrEb+GPcQ+y+V+7yG5rI0+V9WSb
 DPOYZA7XGvAIrkhQQZTlQqLgq4EHHnlSX4586jo0Bn5U82a3dwYu18/QDKATws4pQD
 EJU/0ZHQRgiT23vpHTqQEOuT8fAdN+NKeVxklXMk=
From: pr-tracker-bot@kernel.org
In-Reply-To: <87o997xju9.fsf@concordia.ellerman.id.au>
References: <87o997xju9.fsf@concordia.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87o997xju9.fsf@concordia.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git
 tags/powerpc-4.21-1
X-PR-Tracked-Commit-Id: 12526b0d6c580df860b31e59d68e5696e16c6e5b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8d6973327ee84c2f40dd9efd8928d4a1186c96e2
Message-Id: <20181227220505.24636.75727.pr-tracker-bot@pdx-korg-gitolite-1.ci.codeaurora.org>
Date: Thu, 27 Dec 2018 22:05:05 +0000
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
Cc: alexandre.belloni@bootlin.com, darren@stevens-zone.net,
 geert+renesas@glider.be, aik@ozlabs.ru, linuxram@us.ibm.com,
 viresh.kumar@linaro.org, ldv@altlinux.org, maddy@linux.vnet.ibm.com,
 oohall@gmail.com, leitao@debian.org, hch@lst.de, robh@kernel.org,
 sabyasachi.linux@gmail.com, aneesh.kumar@linux.ibm.com, yuehaibing@huawei.com,
 elfring@users.sourceforge.net, diana.craciun@nxp.com, tiny.windzz@gmail.com,
 firoz.khan@linaro.org, joel@jms.id.au, mahesh@linux.vnet.ibm.com,
 ravi.bangoria@linux.ibm.com, arnd@arndb.de, sfr@canb.auug.org.au,
 alistair@popple.id.au, groug@kaod.org, oss@buserror.net,
 alex.williamson@redhat.com, dja@axtens.net, andy.tang@nxp.com,
 malat@debian.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 sboyd@kernel.org, andrew.donnellan@au1.ibm.com, fbarrat@linux.ibm.com,
 sathnaga@linux.vnet.ibm.com, Linus Torvalds <torvalds@linux-foundation.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The pull request you sent on Thu, 27 Dec 2018 22:58:06 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-4.21-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8d6973327ee84c2f40dd9efd8928d4a1186c96e2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
