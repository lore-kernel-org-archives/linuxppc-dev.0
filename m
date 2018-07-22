Return-Path: <fthain@telegraphics.com.au>
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 41YNPP3NNBzDqm6
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 Jul 2018 21:56:08 +1000 (AEST)
Date: Sun, 22 Jul 2018 21:56:07 +1000 (AEST)
From: Finn Thain <fthain@telegraphics.com.au>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Arnd Bergmann <arnd@arndb.de>, Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Joshua Thompson <funaho@jurai.org>,
 Mathieu Malaterre <malat@debian.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Greg Ungerer <gerg@linux-m68k.org>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 y2038 Mailman List <y2038@lists.linaro.org>, Meelis Roos <mroos@linux.ee>,
 Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH 2/3] [v2] m68k: mac: use time64_t in RTC handling
In-Reply-To: <alpine.LNX.2.21.1807182333150.41@nippy.intranet>
Message-ID: <alpine.LNX.2.21.1807222145330.56@nippy.intranet>
References: <20180619140229.3615110-1-arnd@arndb.de>
 <20180619140229.3615110-2-arnd@arndb.de>
 <CAMuHMdXHUwbD4ZBuQz-xYQO=QdYdPS=j=oLWBet6B7PrGEkT9Q@mail.gmail.com>
 <alpine.LNX.2.21.1807182201560.41@nippy.intranet>
 <CAK8P3a0OBVu-o6kFCS=gV83EcH9ba9QYGZBBhB9D8cJrf=8akA@mail.gmail.com>
 <alpine.LNX.2.21.1807182333150.41@nippy.intranet>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 18 Jul 2018, I wrote:

> On Wed, 18 Jul 2018, Arnd Bergmann wrote:
> 
> > I'd suggest we do it like below to make it consistent with the rest 
> > again, using the 1904..2040 range of dates and no warning for invalid 
> > dates.
> > 
> > If you agree, I'll send that as a proper patch.
> > 
> 
> Geert may instead wish to fixup or revert the patch he has committed 
> already...

Geert, how do you want to handle this?

Do you want a fixup patch or a v3 patch with the WARN_ON and the other two 
issues addressed?

I'm willing to send either one if Arnd is okay with that. I'd really like 
to resolve this before the merge window opens, since my PMU patch series 
is affected.

-- 
