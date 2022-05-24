Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBDEFC433F5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 May 2022 11:25:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4L6sLl49Gzz3gfl
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 May 2022 21:25:19 +1000 (AEST)
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4L6s7t6Hn6z3cff
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 May 2022 21:15:54 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4L6s7t5FBZz4yTK;
 Tue, 24 May 2022 21:15:54 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20220307182734.289289-1-npiggin@gmail.com>
References: <20220307182734.289289-1-npiggin@gmail.com>
Subject: Re: [PATCH 1/2] powerpc/64: Bump SIGSTKSZ and MINSIGSTKSZ
Message-Id: <165339052002.1718562.17542776315274726550.b4-ty@ellerman.id.au>
Date: Tue, 24 May 2022 21:08:40 +1000
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
Cc: Tulio Magno Quites Machado Filho <tuliom@linux.ibm.com>,
 Alan Modra <amodra@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 8 Mar 2022 04:27:33 +1000, Nicholas Piggin wrote:
> The sad tale of SIGSTKSZ and MINSIGSTKSZ is documented in glibc.git
> commit f7c399cff5bd ("PowerPC SIGSTKSZ"), which explains why glibc
> does not use the kernel defines for these constants. Since then in
> fact there has been a further expansion of the signal stack frame size
> on little-endian with linux commit 573ebfa6601f ("powerpc: Increase
> stack redzone for 64-bit userspace to 512 bytes"), which has caused
> it to exceed even the glibc defines.
> 
> [...]

Applied to powerpc/next.

[1/2] powerpc/64: Bump SIGSTKSZ and MINSIGSTKSZ
      https://git.kernel.org/powerpc/c/2f82ec19757f58549467db568c56e7dfff8af283
[2/2] powerpc/signal: Report minimum signal frame size to userspace via AT_MINSIGSTKSZ
      https://git.kernel.org/powerpc/c/2896b2dff49d0377e4372f470dcddbcb26f2be59

cheers
