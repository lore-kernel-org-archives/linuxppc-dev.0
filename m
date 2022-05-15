Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3814DC43217
	for <linuxppc-dev@archiver.kernel.org>; Sun, 15 May 2022 10:31:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4L1JZZ5FGqz3dPT
	for <linuxppc-dev@archiver.kernel.org>; Sun, 15 May 2022 20:31:18 +1000 (AEST)
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4L1JZD5JNXz2xgN
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 May 2022 20:31:00 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4L1JZB3KJxz4xXS;
 Sun, 15 May 2022 20:30:58 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, llvm@lists.linux.dev
In-Reply-To: <20220406070038.3704604-1-aik@ozlabs.ru>
References: <20220406070038.3704604-1-aik@ozlabs.ru>
Subject: Re: [PATCH kernel v3] powerpc/boot: Stop using RELACOUNT
Message-Id: <165261051395.1047019.1825598688195889072.b4-ty@ellerman.id.au>
Date: Sun, 15 May 2022 20:28:33 +1000
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
Cc: Nathan Chancellor <nathan@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 Nick Desaulniers <ndesaulniers@google.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 6 Apr 2022 17:00:38 +1000, Alexey Kardashevskiy wrote:
> So far the RELACOUNT tag from the ELF header was containing the exact
> number of R_PPC_RELATIVE/R_PPC64_RELATIVE relocations. However the LLVM's
> recent change [1] make it equal-or-less than the actual number which
> makes it useless.
> 
> This replaces RELACOUNT in zImage loader with a pair of RELASZ and RELAENT.
> The vmlinux relocation code is fixed in commit d79976918852
> ("powerpc/64: Add UADDR64 relocation support").
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/boot: Stop using RELACOUNT
      https://git.kernel.org/powerpc/c/c14d31bae372e050b053f2511fb3f0f90c27e4f9

cheers
