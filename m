Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F070DC433EF
	for <linuxppc-dev@archiver.kernel.org>; Sat, 12 Mar 2022 10:33:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KFzft53FMz3dqD
	for <linuxppc-dev@archiver.kernel.org>; Sat, 12 Mar 2022 21:33:42 +1100 (AEDT)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KFzbd1sZfz30D6
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Mar 2022 21:30:53 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4KFzbc6mYwz4xj6;
 Sat, 12 Mar 2022 21:30:52 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20220304061222.2478720-1-mpe@ellerman.id.au>
References: <20220304061222.2478720-1-mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc/64e: Tie PPC_BOOK3E_64 to PPC_FSL_BOOK3E
Message-Id: <164708098452.827774.5678930089897480897.b4-ty@ellerman.id.au>
Date: Sat, 12 Mar 2022 21:29:44 +1100
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
Cc: oss@buserror.net, naveen.n.rao@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 4 Mar 2022 17:12:22 +1100, Michael Ellerman wrote:
> Since the IBM A2 CPU support was removed, see commit
> fb5a515704d7 ("powerpc: Remove platforms/wsp and associated pieces"),
> the only 64-bit Book3E CPUs we support are Freescale (NXP) ones.
> 
> However our Kconfig still allows configurating a kernel that has 64-bit
> Book3E support, but no Freescale CPU support enabled. Such a kernel
> would never boot, it doesn't know about any CPUs.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/64e: Tie PPC_BOOK3E_64 to PPC_FSL_BOOK3E
      https://git.kernel.org/powerpc/c/1a76e520ee1831a81dabf8a9a58c6453f700026e

cheers
