Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qk8fY0yb6zDqBt
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Apr 2016 22:35:17 +1000 (AEST)
In-Reply-To: <1455624365-4200-1-git-send-email-ruscur@russell.cc>
To: Russell Currey <ruscur@russell.cc>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: powerpc/eeh: rename EEH from "extended" to "enhanced" error
 handling
Message-Id: <3qk8fX4hX5z9ssM@ozlabs.org>
Date: Mon, 11 Apr 2016 22:35:16 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-16-02 at 12:06:05 UTC, Russell Currey wrote:
> IBM online documentation for EEH uses "extended error handling" and
> "enhanced error handling" to refer to the same thing, in different
> places.  The only place mentioning it as "enhanced error handling" in the
> kernel is the MAINTAINERS file, and it's "extended" in some documentation.
> 
> IBM originally defined EEH as "enhanced error handling", so standardise
> all mentions of EEH to use that term.
> 
> Signed-off-by: Russell Currey <ruscur@russell.cc>
> Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/8ee26530bb189909cca6f4b1f3

cheers
