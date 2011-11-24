Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C18EFB70B2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Nov 2011 07:42:01 +1100 (EST)
Message-ID: <1322167308.32635.6.camel@pasglop>
Subject: Re: [PATCH 01/16] pmac_zilog: fix unexpected irq
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Fri, 25 Nov 2011 07:41:48 +1100
In-Reply-To: <20111124145624.24438832@lxorguk.ukuu.org.uk>
References: <20111023141108.856998818@telegraphics.com.au>
 <20111023141115.208699274@telegraphics.com.au>
 <alpine.LNX.2.00.1111250133321.6314@nippy.intranet>
 <20111124145624.24438832@lxorguk.ukuu.org.uk>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org,
 Finn Thain <fthain@telegraphics.com.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2011-11-24 at 14:56 +0000, Alan Cox wrote:
> > This patch has been tested on a variety of m68k Macs but no
> PowerMacs.
> > 
> > I am re-sending this patch Cc linux-serial. It still needs a
> suitable ack 
> > so that Geert can push it through his tree.
> 
> Given the change should work for all hardware do we really need the
> ifdefs. Far better I would have thought to just change it so we don't
> have to maintain what is effectively two versions of the code between
> now
> and 2038.
> 
> So no ack from me yet - I'd like to understand the ifdef decision
> first.
> Otherwise it looks sensible.

Yes, agreed. Sorry, that one was one my to-do list for a while, I meant
to look into more details and test on a ppc or two here see if it breaks
anything, and never got to do it.

I'll try to give it a go before hell freezes over.

Cheers,
Ben.
