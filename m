Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rYTRR1ywdzDq5c
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 10:40:51 +1000 (AEST)
In-Reply-To: <1463534212-4879-2-git-send-email-dja@axtens.net>
To: Daniel Axtens <dja@axtens.net>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Daniel Axtens <dja@axtens.net>
Subject: Re: [2/4] powerpc: Introduce asm-prototypes.h
Message-Id: <3rYTRQ29j7z9t0V@ozlabs.org>
Date: Tue, 21 Jun 2016 10:40:50 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-18-05 at 01:16:50 UTC, Daniel Axtens wrote:
> Sparse picked up a number of functions that are implemented in C and
> then only referred to in asm code.
> 
> This introduces asm-prototypes.h, which provides a place for
> prototypes of these functions.
> 
> This silences some sparse warnings.
> 
> Signed-off-by: Daniel Axtens <dja@axtens.net>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/42f5b4cacd783faf05e3ff8bf8

cheers
