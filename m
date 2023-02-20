Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57F94C636D6
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Feb 2023 03:54:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PKpSb5tgSz3fbk
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Feb 2023 14:54:07 +1100 (AEDT)
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PKpPp4QfRz3c8W
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Feb 2023 14:51:42 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4PKpPp3KRqz4x8Z;
	Mon, 20 Feb 2023 14:51:42 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20230216112915.1681631-1-mpe@ellerman.id.au>
References: <20230216112915.1681631-1-mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc/nohash: Fix build with llvm-as
Message-Id: <167686496140.2406274.1067866703120290117.b4-ty@ellerman.id.au>
Date: Mon, 20 Feb 2023 14:49:21 +1100
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 16 Feb 2023 22:29:15 +1100, Michael Ellerman wrote:
> When using the LLVM integrated assembler (llvm-as), the book3e build
> fails with:
> 
>   arch/powerpc/mm/nohash/tlb_low_64e.S:354:2: error: invalid instruction
>    tlbilxva 0,%r15
>    ^
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/nohash: Fix build with llvm-as
      https://git.kernel.org/powerpc/c/a7caf3f181f160ae13ece0124e1c268d22263708

cheers
