Return-Path: <fthain@telegraphics.com.au>
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id C270C1A0170
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Jul 2015 17:38:24 +1000 (AEST)
Date: Sat, 25 Jul 2015 17:38:01 +1000 (AEST)
From: Finn Thain <fthain@telegraphics.com.au>
To: Michael Ellerman <mpe@ellerman.id.au>
cc: "Christian T. Steigies" <cts@debian.org>,
 Michael Schmitz <schmitzmic@gmail.com>,
 Linux/m68k <linux-m68k@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux Kernel Development <linux-kernel@vger.kernel.org>,
 Andreas Schwab <schwab@linux-m68k.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [RFC v4 03/25] m68k/atari: Move Atari-specific code out of
 drivers/char/nvram.c
In-Reply-To: <1437786020.19730.2.camel@ellerman.id.au>
Message-ID: <alpine.LNX.2.00.1507251732330.25996@nippy.intranet>
References: <20150712102527.356151908@telegraphics.com.au>
 <20150712102528.107134628@telegraphics.com.au> <87d1zwc4dj.fsf@igel.home>
 <alpine.LNX.2.00.1507141804300.1622@nippy.intranet>
 <55AF1364.3080701@gmail.com>
 <alpine.LNX.2.00.1507221421100.4187@nippy.intranet>
 <20150723092114.GA10989@guido.earth.sol>
 <CAOmrzkL1rOV=9zu=sfpt4-oveR2j-_KVGYvCvCGWzj83oOihnw@mail.gmail.com>
 <20150724190749.GA7529@guido.earth.sol>
 <alpine.LNX.2.00.1507251023410.10487@nippy.intranet>
 <1437786020.19730.2.camel@ellerman.id.au>
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


On Sat, 25 Jul 2015, Michael Ellerman wrote:

> On Sat, 2015-07-25 at 10:35 +1000, Finn Thain wrote:
> > 
> > Thanks for helping with this, Christian. I'll add your name in 
> > "Tested-by" tags on the relevant patches. These are rudimentary tests 
> > but combined with my own testing on m68k, ppc32 and x86, coverage is 
> > quite good. Some testing on ppc64 is still lacking though.
> 
> *Blush*
> 
> I'll try and get to it next week promise!

That would be a great help. Unfortunately I don't have any ppc64 hardware. 
I wish ;-)

-- 
