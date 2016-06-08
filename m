Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rPm685ZjwzDqFm
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jun 2016 21:14:08 +1000 (AEST)
Message-ID: <1465384442.13854.2.camel@ellerman.id.au>
Subject: Re: [PATCH] of: fix autoloading due to broken modalias with no
 'compatible'
From: Michael Ellerman <mpe@ellerman.id.au>
To: Wolfram Sang <wsa@the-dreams.de>, linuxppc-dev@lists.ozlabs.org
Cc: devicetree@vger.kernel.org, Mathieu Malaterre <malat@debian.org>,
 linux-kernel@vger.kernel.org, Andreas Schwab <schwab@linux-m68k.org>,
 Philipp Zabel <p.zabel@pengutronix.de>
Date: Wed, 08 Jun 2016 21:14:02 +1000
In-Reply-To: <1465231718-2577-1-git-send-email-wsa@the-dreams.de>
References: <1465231718-2577-1-git-send-email-wsa@the-dreams.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-06-06 at 18:48 +0200, Wolfram Sang wrote:
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
> ---
> 
> I think it makes sense if this goes in via ppc (with stable tag added).
> D'accord?

Sure, I've grabbed it.

I added:

    Cc: stable@vger.kernel.org # v3.9+

cheers
