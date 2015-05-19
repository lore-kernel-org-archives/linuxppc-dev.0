Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1C2011A0017
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2015 14:33:40 +1000 (AEST)
Message-ID: <1432010019.8339.4.camel@ellerman.id.au>
Subject: Re: [PATCH v4 4/9] hvc: Convert to using interrupts instead of opal
 events
From: Michael Ellerman <mpe@ellerman.id.au>
To: Alistair Popple <alistair@popple.id.au>
Date: Tue, 19 May 2015 14:33:39 +1000
In-Reply-To: <1431662804-16851-5-git-send-email-alistair@popple.id.au>
References: <1431662804-16851-1-git-send-email-alistair@popple.id.au>
 <1431662804-16851-5-git-send-email-alistair@popple.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-05-15 at 14:06 +1000, Alistair Popple wrote:
> Convert the opal hvc driver to use the new irqchip to register for
> opal events. As older firmware versions may not have device tree
> bindings for the interrupt parent we just use a hardcoded hwirq based
> on the event number.

This is still breaking the mambo skiboot test for me.

Nothing obvious on the console

cheers
