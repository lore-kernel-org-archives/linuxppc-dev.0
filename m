Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8241DC433EF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 May 2022 11:16:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4L6s835v35z3cjC
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 May 2022 21:16:03 +1000 (AEST)
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4L6s7P1vx8z2yh9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 May 2022 21:15:29 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4L6s7L641vz4xZ5;
 Tue, 24 May 2022 21:15:26 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: tyreld@linux.ibm.com, Haowen Bai <baihaowen@meizu.com>
In-Reply-To: <1652232476-9696-1-git-send-email-baihaowen@meizu.com>
References: <08d9470c-20db-52b8-7015-84f0ed29ad0c@linux.ibm.com>
 <1652232476-9696-1-git-send-email-baihaowen@meizu.com>
Subject: Re: [PATCH V2] powerpc/eeh: Drop redundant spinlock initialization
Message-Id: <165339058873.1718562.5563457249542011872.b4-ty@ellerman.id.au>
Date: Tue, 24 May 2022 21:09:48 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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
Cc: linux-kernel@vger.kernel.org, oohall@gmail.com, paulus@samba.org,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 11 May 2022 09:27:56 +0800, Haowen Bai wrote:
> slot_errbuf_lock has declared and initialized by DEFINE_SPINLOCK,
> so we don't need to spin_lock_init again, drop it.
> 
> 

Applied to powerpc/next.

[1/1] powerpc/eeh: Drop redundant spinlock initialization
      https://git.kernel.org/powerpc/c/3def164a5cedad9117859dd4610cae2cc59cb6d2

cheers
