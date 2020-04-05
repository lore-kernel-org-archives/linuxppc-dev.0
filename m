Return-Path: <SRS0=yY75=5V=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F06D2C2BA15
	for <linuxppc-dev@archiver.kernel.org>; Sun,  5 Apr 2020 19:47:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 642D920644
	for <linuxppc-dev@archiver.kernel.org>; Sun,  5 Apr 2020 19:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ml+3NwIU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 642D920644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48wPN11ZZ4zDqy6
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Apr 2020 05:47:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=pr-tracker-bot@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=default header.b=Ml+3NwIU; dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48wPKN3qHMzDqkG
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Apr 2020 05:45:28 +1000 (AEST)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.7-1 tag
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1586115925;
 bh=e44hDYLZOYgsYqnXJ4aIm3FbFOGtihWFg62GvfSUyZA=;
 h=From:In-Reply-To:References:Date:To:Cc:From;
 b=Ml+3NwIU0cSTYMXhnP+28/Kg4Bk2Meytx4uu+oez04Qk2V3TCPG4HY84Q/ipljPXP
 w3xWP65Ufrl4Yh+LYjQEpIJHti+PbAYYgXnnRo2NPAh1D/s8X7wqZajJ0lepyrmzWO
 eA9BOYHqcgjgzgDXnMt8GDhWeJm8LxfxIDj82c1c=
From: pr-tracker-bot@kernel.org
In-Reply-To: <87h7xyrt5d.fsf@mpe.ellerman.id.au>
References: <87h7xyrt5d.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87h7xyrt5d.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git
 tags/powerpc-5.7-1
X-PR-Tracked-Commit-Id: c17eb4dca5a353a9dbbb8ad6934fe57af7165e91
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d38c07afc356ddebaa3ed8ecb3f553340e05c969
Message-Id: <158611592587.11305.6103996892992065943.pr-tracker-bot@kernel.org>
Date: Sun, 05 Apr 2020 19:45:25 +0000
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
Cc: tyreld@linux.ibm.com, shilpa.bhat@linux.vnet.ibm.com,
 gustavold@linux.ibm.com, aik@ozlabs.ru, ndesaulniers@google.com,
 psampat@linux.ibm.com, bala24@linux.ibm.com, grant.likely@arm.com,
 oohall@gmail.com, afzal.mohd.ma@gmail.com, srikar@linux.vnet.ibm.com,
 sfr@canb.auug.org.au, joe.lawrence@redhat.com, maskray@google.com,
 ilie.halip@gmail.com, aneesh.kumar@linux.ibm.com, yuehaibing@huawei.com,
 rppt@linux.ibm.com, chenzhou10@huawei.com, ganeshgr@linux.ibm.com,
 dougmill@linux.vnet.ibm.com, kjain@linux.ibm.com, leonardo@linux.ibm.com,
 naveen.n.rao@linux.vnet.ibm.com, agust@denx.de, laurentiu.tudor@nxp.com,
 nathanl@linux.ibm.com, arnd@arndb.de, alistair@popple.id.au,
 linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com, oss@buserror.net,
 olof@lixom.net, maddy@linux.ibm.com, christophe.jaillet@wanadoo.fr,
 clg@kaod.org, courbet@google.com, vaibhav@linux.ibm.com, bhelgaas@google.com,
 natechancellor@gmail.com, dja@axtens.net, farosas@linux.ibm.com,
 gregkh@linuxfoundation.org, lpechacek@suse.cz, linux-kernel@vger.kernel.org,
 sourabhjain@linux.ibm.com, joe@perches.com, po-hsu.lin@canonical.com,
 Linus Torvalds <torvalds@linux-foundation.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The pull request you sent on Sun, 05 Apr 2020 22:53:02 +1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.7-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d38c07afc356ddebaa3ed8ecb3f553340e05c969

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
