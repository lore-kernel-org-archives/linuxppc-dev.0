Return-Path: <SRS0=3D1i=7S=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ABACC433E0
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Jun 2020 20:42:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94F06206E6
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Jun 2020 20:42:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bi8xAE5I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94F06206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49dvhY4Bs8zDr1F
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Jun 2020 06:42:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=pr-tracker-bot@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=default header.b=Bi8xAE5I; dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49dvfV2ygGzDr0y
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Jun 2020 06:40:18 +1000 (AEST)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.8-1 tag
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1591389616;
 bh=3Mr3q/0wKvLsvO1QHM9nx2Hrpfoq4xQhK3q76mTUVok=;
 h=From:In-Reply-To:References:Date:To:Cc:From;
 b=Bi8xAE5IzIiQV/FBsgxmJX+kCVJQ3J2kgNnKE5g5IOhCUFvCXiMzXDycesR++AdWb
 Yn2KelsQboGkYltrzpQwUgbDepeSEg9Jco/kU/nOQXM3GCnBb3HzIcqyUpMlw/AVDV
 qMYMYPqaqvIaycMqSiOGm+6tJOP4PmxtpUEAzajk=
From: pr-tracker-bot@kernel.org
In-Reply-To: <87eeqth3hi.fsf@mpe.ellerman.id.au>
References: <87eeqth3hi.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87eeqth3hi.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git
 tags/powerpc-5.8-1
X-PR-Tracked-Commit-Id: 1395375c592770fe5158a592944aaeed67fa94ff
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7ae77150d94d3b535c7b85e6b3647113095e79bf
Message-Id: <159138961612.17917.10938644618812483205.pr-tracker-bot@kernel.org>
Date: Fri, 05 Jun 2020 20:40:16 +0000
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
Cc: ego@linux.vnet.ibm.com, emmanuel.nicolet@gmail.com, chenzhou10@huawei.com,
 jniethe5@gmail.com, linuxram@us.ibm.com, kernelfans@gmail.com,
 linux-kernel@vger.kernel.org, st5pub@yandex.ru, oohall@gmail.com,
 huhai@tj.kylinos.cn, elfring@users.sourceforge.net, rzinsly@linux.ibm.com,
 leobras.c@gmail.com, mikey@neuling.org, herbert@gondor.apana.org.au,
 aneesh.kumar@linux.ibm.com, haren@linux.ibm.com, michal.simek@xilinx.com,
 mahesh@linux.ibm.com, tiwai@suse.de, kjain@linux.ibm.com,
 leonardo@linux.ibm.com, naveen.n.rao@linux.vnet.ibm.com,
 ravi.bangoria@linux.ibm.com, ajd@linux.ibm.com, arnd@arndb.de,
 sfr@canb.auug.org.au, alistair@popple.id.au, npiggin@gmail.com,
 wangxiongfeng2@huawei.com, cai@lca.pw, clg@kaod.org, natechancellor@gmail.com,
 hbathini@linux.ibm.com, christophe.leroy@c-s.fr, geoff@infradead.org,
 linuxppc-dev@lists.ozlabs.org, dmitry.torokhov@gmail.com,
 gustavoars@kernel.org, wsa@kernel.org, sbobroff@linux.ibm.com,
 fbarrat@linux.ibm.com, christophe.jaillet@wanadoo.fr,
 akpm@linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The pull request you sent on Sat, 06 Jun 2020 02:38:49 +1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.8-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7ae77150d94d3b535c7b85e6b3647113095e79bf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
