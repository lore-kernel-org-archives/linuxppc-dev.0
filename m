Return-Path: <SRS0=PWqZ=KD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E0CCC433B4
	for <linuxppc-dev@archiver.kernel.org>; Sat,  8 May 2021 16:10:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E51B61260
	for <linuxppc-dev@archiver.kernel.org>; Sat,  8 May 2021 16:10:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E51B61260
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Fcsjc2k0Xz308G
	for <linuxppc-dev@archiver.kernel.org>; Sun,  9 May 2021 02:10:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=iSgIC9lX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=pr-tracker-bot@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=iSgIC9lX; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Fcshz0zFlz2yYQ
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  9 May 2021 02:09:54 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPS id ECF3061448;
 Sat,  8 May 2021 16:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620490192;
 bh=3O5IDpKDY83jcoMzg8ba634383UgeT4Y+6bHxHaUleM=;
 h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
 b=iSgIC9lXV8hwX1YtZq0SKTCx9a8bTA9kexWQtuMTo6XZM/KCMrtjlQFDqsIekjtV4
 dR+E1cGB6R5FpWfM46g7zzEf/91QXzwRDe+e2vYeviJM8QQNlD3eRXTc0XDH472d38
 K0Wj2L/RSUvwM7ZX9/jW6ecJ6qStDHlKLCNLskjmiBVwbN3Zhw0vLkmnp0m7XoQBmx
 JxwmnRjTz/rp1hW3sz5wg3U5QrqsUIhUPn+2H3BFV32YhtEEbUcShB/dfVc0Mxt+E7
 anD1nb/KBTPWVtF0wxMEjSi20JdB2lX7i2AuXgHru3bu/ORCpsyNkgiDkbOOWav7fW
 sqe1ZezVkUolw==
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.13-2 tag
From: pr-tracker-bot@kernel.org
In-Reply-To: <87y2cpxrir.fsf@mpe.ellerman.id.au>
References: <87y2cpxrir.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87y2cpxrir.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git
 tags/powerpc-5.13-2
X-PR-Tracked-Commit-Id: f96271cefe6dfd1cb04195b76f4a33e185cd7f92
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ab159ac569fddf812c0a217d6dbffaa5d93ef88f
Message-Id: <162049019193.24889.5964565284286637928.pr-tracker-bot@kernel.org>
Date: Sat, 08 May 2021 16:09:51 +0000
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
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>, npiggin@gmail.com,
 Paolo Bonzini <pbonzini@redhat.com>, sourabhjain@linux.ibm.com,
 linuxppc-dev@lists.ozlabs.org, hch@lst.de, sandipan@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The pull request you sent on Sat, 08 May 2021 23:51:40 +1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.13-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ab159ac569fddf812c0a217d6dbffaa5d93ef88f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
