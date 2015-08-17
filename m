Return-Path: <fthain@telegraphics.com.au>
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id BF40C1A2351
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2015 18:05:26 +1000 (AEST)
Date: Mon, 17 Aug 2015 18:04:59 +1000 (AEST)
From: Finn Thain <fthain@telegraphics.com.au>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
 linux-m68k <linux-m68k@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [RFC v5 00/26] Re-use nvram module
In-Reply-To: <CAMuHMdWUQsSG8cZmKX8tHMN1=87Og-xboAFzhP1vWyQF+A3_eg@mail.gmail.com>
Message-ID: <alpine.LNX.2.00.1508171756180.626@nippy.intranet>
References: <20150725074559.543547894@telegraphics.com.au>
 <CAMuHMdWUQsSG8cZmKX8tHMN1=87Og-xboAFzhP1vWyQF+A3_eg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Sun, 16 Aug 2015, Geert Uytterhoeven wrote:

> Hi Finn,
> 
> On Sat, Jul 25, 2015 at 9:45 AM, Finn Thain <fthain@telegraphics.com.au> 
> wrote:
> > The generic NVRAM module, drivers/char/generic_nvram, implements a 
> > /dev/nvram misc device. It is used only by 32-bit PowerPC platforms 
> > and isn't generic enough to be more widely used.
> 
> [...]
> 
> Thanks!
> 
> You can add my
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> to patches 03, 04, 11, 19, 23, 24, 25, 26.

Thanks for reviewing.

> 
> BTW, checkpatch reported a few newly-introduced whitespace errors in 
> patches 03, 05, 16, 24, and 25.

I will check again, but I'm sure those are all deliberate. I examined all 
the "errors" and "warnings" before submitting.

checkpatch doesn't really understand the difference between whitespace 
used for indentation of statements (according to scope) and whitespace 
used for alignment of terms or parameters (when line-wrapped). Any tool 
that fails to make that distinction can't be depended upon to correctly 
validate the elisp in Documentation/CodingStyle, for example.

-- 

> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
