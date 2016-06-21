Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rYTRQ0hFVzDq5c
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 10:40:50 +1000 (AEST)
In-Reply-To: <1463534212-4879-1-git-send-email-dja@axtens.net>
To: Daniel Axtens <dja@axtens.net>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Daniel Axtens <dja@axtens.net>
Subject: Re: [1/4] powerpc/sparse: make some things static
Message-Id: <3rYTRP41G8z9t0N@ozlabs.org>
Date: Tue, 21 Jun 2016 10:40:49 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-18-05 at 01:16:49 UTC, Daniel Axtens wrote:
> This is just a smattering of things picked up by sparse that should
> be made static.
> 
> Signed-off-by: Daniel Axtens <dja@axtens.net>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/34852ed5511ec5d07897f22d56

cheers
