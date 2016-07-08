Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rmGtF1LFJzDqlj
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Jul 2016 00:23:01 +1000 (AEST)
In-Reply-To: <1467782335-18758-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, <linuxppc-dev@ozlabs.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: selftests/powerpc: Use "Delta" rather than "Error" in normal
 output
Message-Id: <3rmGtD2ql4z9t10@ozlabs.org>
Date: Sat,  9 Jul 2016 00:23:00 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-06-07 at 05:18:55 UTC, Michael Ellerman wrote:
> Use "Delta" to refer to the difference between measurements, rather than
> "Error", so scripts that look for "Error" aren't confused into thinking
> there was a failure.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/bc5c0a0d7fa94777acb9e88571

cheers
