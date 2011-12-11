Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 497B4B6F7E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Dec 2011 10:55:13 +1100 (EST)
Message-ID: <1323647703.19891.13.camel@pasglop>
Subject: Re: [PATCH 01/16 v3] pmac_zilog: fix unexpected irq
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Finn Thain <fthain@telegraphics.com.au>
Date: Mon, 12 Dec 2011 10:55:03 +1100
In-Reply-To: <1323647315.19891.10.camel@pasglop>
References: <20111023141108.856998818@telegraphics.com.au>
 <20111023141115.208699274@telegraphics.com.au>
 <alpine.LNX.2.00.1112070203310.14968@nippy.intranet>
 <alpine.LNX.2.00.1112071427280.28552@nippy.intranet>
 <1323318004.12793.21.camel@pasglop> <1323318638.12793.23.camel@pasglop>
 <alpine.LNX.2.00.1112082128330.2357@nippy.intranet>
 <1323647315.19891.10.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, linux-m68k@vger.kernel.org,
 Geert Uytterhoeven <geert@linux-m68k.org>, linux-serial@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2011-12-12 at 10:48 +1100, Benjamin Herrenschmidt wrote:
> Any chance you can test this patch ? I would not be surprised if it
> broke m68k since I had to do some of the changes in there "blind",
> so let me know... with this, I can again suspend/resume properly on
> a Pismo while using the internal modem among other things.

 ..../....

Forgot to commit a fix before sending, but it's a trivial one:

> -#ifdef DEBUG_HARD
> +#ifde DEBUG_HARD
>  	pmz_debug("irq, r3: %x\n", r3);
>  #endif

Remove that hunk :-)

Cheers,
Ben.
