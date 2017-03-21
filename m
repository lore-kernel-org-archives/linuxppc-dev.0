Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vnW3g5ZBSzDqc2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 22:36:15 +1100 (AEDT)
In-Reply-To: <1488790186-4828-1-git-send-email-me@tobin.cc>
To: "Tobin C. Harding" <me@tobin.cc>, Ingo Molnar <mingo@redhat.com>,
 Steven Rostedt <rostedt@goodmis.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, "Tobin C. Harding" <me@tobin.cc>
Subject: Re: powerpc/ftrace: add ftrace.h, fix sparse warning
Message-Id: <3vnW3g4MrZz9s8C@ozlabs.org>
Date: Tue, 21 Mar 2017 22:36:15 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-03-06 at 08:49:46 UTC, "Tobin C. Harding" wrote:
> Sparse emits warning: symbol 'prepare_ftrace_return' was not
> declared. Should it be static? prepare_ftrace_return() is called
> from assembler and should not be static. Adding a header file
> declaring the function will fix the sparse warning while adding
> documentation to the call.
> 
> Add header file ftrace.h with single function declaration. Protect
> declaration with preprocessor guard so it may be included in
> assembly. Include new header in all files that call
> prepare_ftrace_return() and in ftrace.c where function is defined.
> 
> Signed-off-by: Tobin C. Harding <me@tobin.cc>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/b3a7864c6feb0fb30bc2cd37265707

cheers
