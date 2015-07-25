Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8CB511A01E3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Jul 2015 11:00:21 +1000 (AEST)
Message-ID: <1437786020.19730.2.camel@ellerman.id.au>
Subject: Re: [RFC v4 03/25] m68k/atari: Move Atari-specific code out of
 drivers/char/nvram.c
From: Michael Ellerman <mpe@ellerman.id.au>
To: Finn Thain <fthain@telegraphics.com.au>
Cc: "Christian T. Steigies" <cts@debian.org>, Michael Schmitz
 <schmitzmic@gmail.com>, Linux/m68k <linux-m68k@vger.kernel.org>, Arnd
 Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux Kernel Development <linux-kernel@vger.kernel.org>, Andreas Schwab
 <schwab@linux-m68k.org>, Geert Uytterhoeven <geert@linux-m68k.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Sat, 25 Jul 2015 11:00:20 +1000
In-Reply-To: <alpine.LNX.2.00.1507251023410.10487@nippy.intranet>
References: <20150712102527.356151908@telegraphics.com.au>
 <20150712102528.107134628@telegraphics.com.au> <87d1zwc4dj.fsf@igel.home>
 <alpine.LNX.2.00.1507141804300.1622@nippy.intranet>
 <55AF1364.3080701@gmail.com>
 <alpine.LNX.2.00.1507221421100.4187@nippy.intranet>
 <20150723092114.GA10989@guido.earth.sol>
 <CAOmrzkL1rOV=9zu=sfpt4-oveR2j-_KVGYvCvCGWzj83oOihnw@mail.gmail.com>
 <20150724190749.GA7529@guido.earth.sol>
 <alpine.LNX.2.00.1507251023410.10487@nippy.intranet>
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

On Sat, 2015-07-25 at 10:35 +1000, Finn Thain wrote:
> On Fri, 24 Jul 2015, Christian T. Steigies wrote:
> > 3b5801864975cf23bcacb52f648e74cc  /dev/nvram
> > 3b5801864975cf23bcacb52f648e74cc  /tmp/nvram
> 
> Thanks for helping with this, Christian. I'll add your name in "Tested-by" 
> tags on the relevant patches. These are rudimentary tests but combined 
> with my own testing on m68k, ppc32 and x86, coverage is quite good. Some 
> testing on ppc64 is still lacking though.

*Blush*

I'll try and get to it next week promise!

cheers
