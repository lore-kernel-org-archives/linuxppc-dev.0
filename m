Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rQndj26D4zDq5s
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jun 2016 13:26:33 +1000 (AEST)
In-Reply-To: <1465231718-2577-1-git-send-email-wsa@the-dreams.de>
To: Wolfram Sang <wsa@the-dreams.de>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: devicetree@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>,
 Mathieu Malaterre <malat@debian.org>, linux-kernel@vger.kernel.org,
 Andreas Schwab <schwab@linux-m68k.org>, Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: of: fix autoloading due to broken modalias with no 'compatible'
Message-Id: <3rQndj0N39z9snk@ozlabs.org>
Date: Fri, 10 Jun 2016 13:26:32 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-06-06 at 16:48:38 UTC, Wolfram Sang wrote:
> Because of an improper dereference, a stray 'C' character was output to
> the modalias when no 'compatible' was specified. This is the case for
> some old PowerMac drivers which only set the 'name' property. Fix it to
> let them match again.
> 
> Reported-by: Mathieu Malaterre <malat@debian.org>
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> Tested-by: Mathieu Malaterre <malat@debian.org>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Andreas Schwab <schwab@linux-m68k.org>
> Fixes: 6543becf26fff6 ("mod/file2alias: make modalias generation safe for cross compiling")

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/b3c0a4dab7e35a9b6d69c04156

cheers
