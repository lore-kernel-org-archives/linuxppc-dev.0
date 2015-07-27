Return-Path: <fthain@telegraphics.com.au>
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id B0F581A2D75
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2015 15:51:30 +1000 (AEST)
Date: Mon, 27 Jul 2015 15:51:07 +1000 (AEST)
From: Finn Thain <fthain@telegraphics.com.au>
To: Michael Schmitz <schmitzmic@gmail.com>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
 Linux/m68k <linux-m68k@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [RFC v4 03/25] m68k/atari: Move Atari-specific code out of
 drivers/char/nvram.c
In-Reply-To: <CAOmrzkLUfO02c+k31QD3J3pZZOR_BE6zFSwD2cHtyejCJ2Jgxg@mail.gmail.com>
Message-ID: <alpine.LNX.2.00.1507271523480.31622@nippy.intranet>
References: <20150712102527.356151908@telegraphics.com.au>
 <20150712102528.107134628@telegraphics.com.au> <87d1zwc4dj.fsf@igel.home>
 <alpine.LNX.2.00.1507141804300.1622@nippy.intranet>
 <55AF1364.3080701@gmail.com>
 <alpine.LNX.2.00.1507221421100.4187@nippy.intranet>
 <20150723092114.GA10989@guido.earth.sol>
 <CAOmrzkL1rOV=9zu=sfpt4-oveR2j-_KVGYvCvCGWzj83oOihnw@mail.gmail.com>
 <20150724190749.GA7529@guido.earth.sol> <55B2DD88.2090804@gmail.com>
 <alpine.LNX.2.00.1507251722580.25996@nippy.intranet> <55B43196.5@gmail.com>
 <alpine.LNX.2.00.1507261103550.21031@nippy.intranet>
 <CAOmrzkLUfO02c+k31QD3J3pZZOR_BE6zFSwD2cHtyejCJ2Jgxg@mail.gmail.com>
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


On Mon, 27 Jul 2015, Michael Schmitz wrote:

> Finn,
> 
> my bad - there is indeed a change in the /proc/driver/nvram output:
> 
> --- nvram-4.out    2015-07-24 12:32:44.000000000 +1200
> +++ nvram-4p2.out    2015-07-27 13:56:06.000000000 +1200
> @@ -7,7 +7,7 @@
>  Keyboard language: English (US)
>  Date format      : DD.MM.YY, 24h clock
>  Boot delay       : 32s
> -Video mode       : 4 colors, 40 columns, TV NTSC monitor
> +Video mode       : 256 colors, 80 columns, VGA PAL monitor
>                     no overscan, compat. mode off
>  00000000  00 00 00 00 00 00 00 00  11 2e 20 01 ff 00 00 3b  |.......... ....;|
>  00000010  84 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
> 
> 
> That video mode is indeed the one set in the NVRAM (by ARAnyM config,
> if running emulated)

All's well then.

Thanks.

Finn

> 
> Cheers,
> 
>   Michael
> 
