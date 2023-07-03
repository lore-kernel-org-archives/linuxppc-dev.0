Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C778DEB64DD
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Jul 2023 05:56:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QvZtp1jXmz3c5Z
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Jul 2023 15:56:50 +1000 (AEST)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QvZp25jjCz30ft
	for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Jul 2023 15:52:42 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4QvZp24J8xz4wxq;
	Mon,  3 Jul 2023 15:52:42 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>
In-Reply-To: <20230606132447.315714-1-npiggin@gmail.com>
References: <20230606132447.315714-1-npiggin@gmail.com>
Subject: Re: [PATCH v3 0/6] powerpc: merge _switch in 32/64
Message-Id: <168836201885.50010.14207705804777232521.b4-ty@ellerman.id.au>
Date: Mon, 03 Jul 2023 15:26:58 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 06 Jun 2023 23:24:41 +1000, Nicholas Piggin wrote:
> Since v2:
> - Add PPC_CREATE_STACK_FRAME() to abstract prologue differences.
> - Build fix.
> - Makefile tidy [Christophe]
> - Fix a missing SOB.
> 
> Since v1:
> - Don't re-order 32-bit prologue.
> - Improve Kconfig conditional includes.
> - Break out code changes into their own patches before merging,
>   so merge patch leaves generated code unchanged.
> - Change prom_entry.S to prom_entry_64.S.
> 
> [...]

Applied to powerpc/next.

[1/6] powerpc/64s: move stack SLB pinning out of line from _switch
      https://git.kernel.org/powerpc/c/d6b87c3eb6b2e0b34ba747df549e08768b019fe9
[2/6] powerpc/64: Rearrange 64-bit _switch to prepare for 32/64 merge
      https://git.kernel.org/powerpc/c/0eb8088b5a7524f96cadfb27083f5bdd819d9d52
[3/6] powerpc/32: Remove sync from _switch
      https://git.kernel.org/powerpc/c/fc8562c9b69af9533c39903b1601c378742189b0
[4/6] powerpc/32: Rearrange _switch to prepare for 32/64 merge
      https://git.kernel.org/powerpc/c/6958ad05d5789a303afe4fa4495df43993d9b7cb
[5/6] powerpc: merge 32-bit and 64-bit _switch implementation
      https://git.kernel.org/powerpc/c/afc6386815a88d067d9f567dcc6266800286f626
[6/6] powerpc/64: Rename entry_64.S to prom_entry_64.S
      https://git.kernel.org/powerpc/c/27be2456332dcd69907f086cda327ad923b222cf

cheers
