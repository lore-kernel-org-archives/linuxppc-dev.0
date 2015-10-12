Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B06501A03A9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2015 22:17:19 +1100 (AEDT)
In-Reply-To: <1443692770-44944-2-git-send-email-andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linuxppc-dev@lists.ozlabs.org, Segher Boessenkool <segher@kernel.crashing.org>,
 Denis Kirjanov <kda@linux-powerpc.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [v3,1/5] powerpc/pseries: extract of_helpers module
Message-Id: <20151012111719.9D3A01402B7@ozlabs.org>
Date: Mon, 12 Oct 2015 22:17:19 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-01-10 at 09:46:06 UTC, Andy Shevchenko wrote:
> Extract a new module to share the code between other modules.
> 
> There is no functional change.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/948ad1acaf456b7213731cd9

cheers
