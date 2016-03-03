Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BDEE01A0342
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Mar 2016 21:58:54 +1100 (AEDT)
In-Reply-To: <1456727395-27386-1-git-send-email-sjitindarsingh@gmail.com>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Subject: Re: selftests/powerpc: Remove -flto from common CFLAGS
Message-Id: <20160303105854.831CB140C48@ozlabs.org>
Date: Thu,  3 Mar 2016 21:58:54 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-29-02 at 06:29:55 UTC, Suraj Jitindar Singh wrote:
> LTO can cause GCC to inline some functions which have attributes set. The
> act of inlining the functions can lead to GCC forgetting about the
> attributes which leads to incorrect tests.
> Notable example being: __attribute__((__target__("no-vsx")))
> LTO can also interact strangely with custom assembly functions and cause
> tests to intermittently fail.
...
> 
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> Reviewed-by: Cyril Bur <cyrilbur@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/a4cf0a2e1d3b98cac5fd5ba928

cheers
