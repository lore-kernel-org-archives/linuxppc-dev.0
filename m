Return-Path: <SRS0=qxeE=IM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D7CC433DB
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Mar 2021 20:02:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2AD764EC3
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Mar 2021 20:02:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2AD764EC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Dz9SN5pJcz3cP2
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Mar 2021 07:02:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=GZRNGqtb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=pr-tracker-bot@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=GZRNGqtb; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Dz9Rv3xfyz2yhd
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Mar 2021 07:01:47 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPS id E40DE64EB0;
 Sun, 14 Mar 2021 20:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1615752103;
 bh=qEY4KPv1FWfeCeJsaHspGiIahwMh3VNtau7jhcQ52fo=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=GZRNGqtbJ5EeJvjxSF4N2kmvCHxlOiojavtiUKwhLnIyOwNtVpf2r1XM1JxUm4vpQ
 YfAFSDuiSXr6EPMC9uvhnEfRTelHnC6EKN+qx4UhEWv8VwwbGJFqFqj3aXljKzeSML
 T0lQoOUBs+7uJAd2j0ZeuTgnl1HheSmmOMq+cs2tVStj1RRqtFaO7XAaq0wWkOWer+
 cqvRUeQYUhU4HNb4CAwZyNLXbz4m4kszSNxEOvnOUsg4hkvdgWzrg1IkTC63NmVB8J
 zIZJY1E/uk9cQTPEiDRTFZv97kpntWeu5tevMZ3UbpcVOp+NUi/CW+LfVF0E9Wyo/f
 DExtoSH5PdlcA==
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.12-3 tag
From: pr-tracker-bot@kernel.org
In-Reply-To: <87tupe3utv.fsf@mpe.ellerman.id.au>
References: <87tupe3utv.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: Linux on PowerPC Developers Mail List
 <linuxppc-dev.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <87tupe3utv.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git
 tags/powerpc-5.12-3
X-PR-Tracked-Commit-Id: 0b736881c8f1a6cd912f7a9162b9e097b28c1c30
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c3c7579f5e3b4826d32af0521e53d5d565ed5a73
Message-Id: <161575210377.6248.6875830079837121926.pr-tracker-bot@kernel.org>
Date: Sun, 14 Mar 2021 20:01:43 +0000
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
 linux-kernel@vger.kernel.org, npiggin@gmail.com,
 naveen.n.rao@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org, dja@axtens.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The pull request you sent on Sun, 14 Mar 2021 21:15:08 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.12-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c3c7579f5e3b4826d32af0521e53d5d565ed5a73

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
