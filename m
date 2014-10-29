Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CBE0F1A0198
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Oct 2014 16:06:05 +1100 (AEDT)
In-Reply-To: <20141028121900.0f3bccc7@marrow.netinsight.se>
To: Simon Kagstrom <simon.kagstrom@netinsight.net>,
 <linuxppc-dev@lists.ozlabs.org>, <grant.likely@linaro.org>,
 <geert@linux-m68k.org>, <scottwood@freescale.com>
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [v3] PowerPC: boot: Parse chosen/cmdline-timeout parameter
Message-Id: <20141029050605.A9F7D14008E@ozlabs.org>
Date: Wed, 29 Oct 2014 16:06:05 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-28-10 at 11:19:00 UTC, Simon Kagstrom wrote:
> A 5 second timeout during boot might be too long, so make it
> configurable. Run the loop at least once to let the user stop the boot
> by holding a key pressed. If the timeout is set to 0, don't wait for
> input, which can be used as a workaround if the boot hangs on random
> data coming in on the serial port.
> 
> Signed-off-by: Simon Kagstrom <simon.kagstrom@netinsight.net>
> ---
> 
> I googled for it, and can't find v2 applied anywhere. I've made an
> improvement to the patch: If the timeout is 0, don't wait for input. We
> have a board where the serial port gives garbage when it's not
> connected - this board would then hang in the bootloader.
> 
> If someone (Michael Ellerman?) has already applied it somewhere, I can
> send a separate patch for that particular change.

No I haven't applied it yet. I will put it in next in the next week or so for
3.19, you don't need to do anything.

cheers
