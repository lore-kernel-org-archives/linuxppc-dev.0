Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B758DC77B60
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Apr 2023 12:14:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Q5yV20CSwz3fyk
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Apr 2023 22:14:34 +1000 (AEST)
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Q5yMV554kz3cj2
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Apr 2023 22:08:54 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Q5yMV3w4Bz4xFd;
	Wed, 26 Apr 2023 22:08:54 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>
In-Reply-To: <20230408021752.862660-1-npiggin@gmail.com>
References: <20230408021752.862660-1-npiggin@gmail.com>
Subject: Re: [PATCH 0/6] powerpc/64: Build with PC-Relative addressing
Message-Id: <168251050523.3973805.8709490224950030201.b4-ty@ellerman.id.au>
Date: Wed, 26 Apr 2023 22:01:45 +1000
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
Cc: Alan Modra <amodra@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, 08 Apr 2023 12:17:46 +1000, Nicholas Piggin wrote:
> This won't see a lot of real use until POWER10 is the oldest supported
> CPU for distros, but being as we're quite a unique user of toolchain I'd
> like to start ironing things out earlier rather than later. I'm making a
> list of observations here, https://github.com/linuxppc/issues/issues/455
> and will take them to toolchan developers after the kernel work is a bit
> further along.
> 
> [...]

Applied to powerpc/next.

[1/6] powerpc/64: Move initial base and TOC pointer calculation
      https://git.kernel.org/powerpc/c/4f18b9e6ca58440394e86a53bf1be0d8a1920bcd
[2/6] powerpc/64s: Run at the kernel virtual address earlier in boot
      https://git.kernel.org/powerpc/c/b270bebd34e36fb69363d65e24b00a9d148903e8
[3/6] powerpc/64: Add support to build with prefixed instructions
      https://git.kernel.org/powerpc/c/dc5dac748af9087e9240bd2ae6ae7db48d5360ae
[4/6] powerpc: add CFUNC assembly label annotation
      https://git.kernel.org/powerpc/c/4e991e3c16a350d1eeffc100ce3fb25292596d03
[5/6] powerpc/64: vmlinux support building with PCREL addresing
      https://git.kernel.org/powerpc/c/7e3a68be42e10f5fa5890e97afc0afd992355bc3
[6/6] powerpc/64: modules support building with PCREL addresing
      https://git.kernel.org/powerpc/c/77e69ee7ce0715c39b9a0cde68ff44fe467435ef

cheers
