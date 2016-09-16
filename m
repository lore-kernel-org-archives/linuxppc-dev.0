Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sb1Pw10hNzDsZM
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 13:45:08 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] powerpc: do not use kprobe section to exempt exception
 handlers
In-Reply-To: <20160915142944.9322-1-npiggin@gmail.com>
References: <20160915142944.9322-1-npiggin@gmail.com>
Date: Fri, 16 Sep 2016 13:45:05 +1000
Message-ID: <874m5go6da.fsf@concordia.ellerman.id.au>
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

> Use the blacklist macros instead. This allows the linker to move
> exception handler functions close to callers and avoids trampolines in
> larger kernels.

Nice, that's been on my todo list for eva.

Can you do the asm ones too? See _KPROBE() in misc_32/64.S.

cheers
