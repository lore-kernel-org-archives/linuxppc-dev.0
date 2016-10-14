Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sw89H3HQXzDsyY
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Oct 2016 11:48:35 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] powerpc: make _ASM_NOKPROBE_SYMBOL a noop when KPROBES
 not defined
In-Reply-To: <20161013020714.5629-1-npiggin@gmail.com>
References: <20161013020714.5629-1-npiggin@gmail.com>
Date: Fri, 14 Oct 2016 11:48:35 +1100
Message-ID: <87wphbdacc.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nicholas Piggin <npiggin@gmail.com> writes:
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
> The linker orphan sections error patch caught this

You mean with the orphan sections patch applied this breaks the build
when KPROBES=n right?

cheers
