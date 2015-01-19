Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 667DD1A0D07
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jan 2015 17:26:55 +1100 (AEDT)
Message-ID: <1421648814.3787.10.camel@ellerman.id.au>
Subject: Re: [PATCH 1/4] CXL: Use image state defaults for reloading FPGA
From: Michael Ellerman <mpe@ellerman.id.au>
To: Ian Munsie <imunsie@au1.ibm.com>
Date: Mon, 19 Jan 2015 17:26:54 +1100
In-Reply-To: <1421643145-sup-9090@delenn.ozlabs.ibm.com>
References: <1421437687-12835-1-git-send-email-grimm@linux.vnet.ibm.com>
 <1421643145-sup-9090@delenn.ozlabs.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Ryan Grimm <grimm@linux.vnet.ibm.com>, mikey <mikey@neuling.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-01-19 at 16:03 +1100, Ian Munsie wrote:
> Acked-by: Ian Munsie <imunsie@au1.ibm.com>
> 
> Looks like you forgot your Signed-off-by line - mpe, do you want Ryan to
> resend the whole patch (maybe with the below explanation included), or
> just reply with a Signed-off-by?

Just resend the series please.

> This would also be good to CC: Stable, as these new defaults mean that
> the card will be fully reset when sapphire PERSTs them on reboot,
> whereas before it was left up to the default value of this register in
> each card, and could lead to a card getting into a bad state requiring a
> full power cycle to recover. The symptoms we saw was the tlbia / slbia
> we do on boot timing out and the driver init aborting.

OK.

I've decided I'm going to handle stable patches differently for the next cycle,
we've been sending too many and then sending fixups and reverts.

So please just note that you'd like it to be considered for stable, under the
--- line, and I'll add it to my list and if it's still good to go in a few
weeks then I'll send it to stable.

cheers
