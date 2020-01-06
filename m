Return-Path: <SRS0=nzsQ=23=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB213C33C8C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Jan 2020 23:43:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60D352072A
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Jan 2020 23:43:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60D352072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47sBsL2L5QzDqMx
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jan 2020 10:43:18 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47sBdp0r9GzDqGZ
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Jan 2020 10:33:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 47sBdn5hHgz9sRG; Tue,  7 Jan 2020 10:33:17 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: c3aae14e5d468d18dbb5d7c0c8c7e2968cc14aad
In-Reply-To: <20191209200338.12546-1-natechancellor@gmail.com>
To: Nathan Chancellor <natechancellor@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [PATCH] powerpc/44x: Adjust indentation in
 ibm4xx_denali_fixup_memsize
Message-Id: <47sBdn5hHgz9sRG@ozlabs.org>
Date: Tue,  7 Jan 2020 10:33:17 +1100 (AEDT)
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
Cc: clang-built-linux@googlegroups.com,
 Nathan Chancellor <natechancellor@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 2019-12-09 at 20:03:38 UTC, Nathan Chancellor wrote:
> Clang warns:
> 
> ../arch/powerpc/boot/4xx.c:231:3: warning: misleading indentation;
> statement is not part of the previous 'else' [-Wmisleading-indentation]
>         val = SDRAM0_READ(DDR0_42);
>         ^
> ../arch/powerpc/boot/4xx.c:227:2: note: previous statement is here
>         else
>         ^
> 
> This is because there is a space at the beginning of this line; remove
> it so that the indentation is consistent according to the Linux kernel
> coding style and clang no longer warns.
> 
> Fixes: d23f5099297c ("[POWERPC] 4xx: Adds decoding of 440SPE memory size to boot wrapper library")
> Link: https://github.com/ClangBuiltLinux/linux/issues/780
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/c3aae14e5d468d18dbb5d7c0c8c7e2968cc14aad

cheers
