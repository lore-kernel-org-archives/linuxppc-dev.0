Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EC4CC433F5
	for <linuxppc-dev@archiver.kernel.org>; Sun, 15 May 2022 10:36:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4L1JhS6rccz3fpv
	for <linuxppc-dev@archiver.kernel.org>; Sun, 15 May 2022 20:36:24 +1000 (AEST)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4L1JZT3F48z3cfv
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 May 2022 20:31:13 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4L1JZS74thz4xY4;
 Sun, 15 May 2022 20:31:12 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: mopsfelder@gmail.com, "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>
In-Reply-To: <cover.1648648712.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1648648712.git.naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 0/3] powerpc: Remove system call emulation
Message-Id: <165261051926.1047019.4518036835145159230.b4-ty@ellerman.id.au>
Date: Sun, 15 May 2022 20:28:39 +1000
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 30 Mar 2022 19:37:16 +0530, Naveen N. Rao wrote:
> Since v1, the main change is to use helpers to decode primary/extended
> opcode and the addition of macros for some of the used opcodes.
> 
> - Naveen
> 
> 
> 
> [...]

Applied to powerpc/next.

[1/3] powerpc: Sort and de-dup primary opcodes in ppc-opcode.h
      https://git.kernel.org/powerpc/c/f31c618373f2051a32e30002d8eacad7bbbd3885
[2/3] powerpc: Reject probes on instructions that can't be single stepped
      https://git.kernel.org/powerpc/c/54cdacd7d3b3c1a8dc10965f56c8b5eb8eda1a33
[3/3] powerpc/64: remove system call instruction emulation
      https://git.kernel.org/powerpc/c/a553476c44fb6bd3dc3a7e5efef8f130f0f34850

cheers
