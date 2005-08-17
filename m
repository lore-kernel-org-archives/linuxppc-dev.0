Return-Path: <clemens.koller@anagramm.de>
Received: from moutvdomng.kundenserver.de (moutvdom.kundenserver.de
	[212.227.126.249]) by ozlabs.org (Postfix) with ESMTP id C3F9667FCB
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Aug 2005 21:04:29 +1000 (EST)
Message-ID: <430319BB.2020801@anagramm.de>
Date: Wed, 17 Aug 2005 13:04:27 +0200
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: Andrey Volkov <avolkov@varma-el.com>
References: <20050816194825.A62AC353AB5@atlas.denx.de>
	<43030D41.3000508@varma-el.com>
In-Reply-To: <43030D41.3000508@varma-el.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [F]Framebuffer driver using SM501 hardware.
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi, Andrey!

It would be great to have our code collected somewhere in a public
cvs/git archive.
There are also some patches to add (accelerated) SM501 support to 
the latest X somewhere in atmosphere:

https://bugs.freedesktop.org/attachment.cgi?id=1775

I will be able to help you with some hacking/testing with the
SM501 on PCI on ppc/MPC8540 in the future.

Greets,

Clemens Koller
_______________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Str. 45/1
81379 Muenchen
Germany

http://www.anagramm.de
Phone: +49-89-741518-50
Fax: +49-89-741518-19



Andrey Volkov wrote:
> I (now :)) working on it too.
> 
> Unfortunately, due to terrible SM docos/examples,
> I rewrite/write some parts from scratch :(
> (mainly based on Applied Data Systems drivers for PXA).
> Currently my driver(s) in prerelease stage. It provide:
> 
> - PCI/bus infra.
> - CRT or LCD fb (dual head in progress,
>   I hope, on next week it will be done).
> - hwd cursor
> - hwd accel (bitblit/fill rect/color expand)
> - I2C/DDC (software, due to silicon bug in SM501)
> - CI (Command List Interpreter) partially supported
>   (problems in PCI mode: when it work as master with
>    MPC5200, some data are lost, needed investigation).
> 
> Todo:
> - 16 bpp colormap (needed reverse endian support in fbcon/fbmem)
> - Alpha (have not ideas how to use it in fb/X)
> - Video (same as above)
> - Platform driver (it will not too hard to write it,
>   but all boards, which I have, are PCI based)
> - USB host (in progress)
> - USB slave
> - Full CI support.
> - UART/SPI/AC97....
> 
> To whom it is interesting, I could send my current code
> (not too little). And, if smb will wish fix/expand...,
> I could (temporally) create cvs on sf.net.
> 
> Wolfgang Denk wrote:
> 
>>In message <43022F05.3050409@anagramm.de> you wrote:
>>
>>
>>>I was working with the SM501 framebuffer for a while on
>>>linux-2.6.
>>
>>
>>...and we did in the context of our 2.4 kernel.
>>
>>
>>
>>>There is a color-mapping issue left (RGB is swapped on powerpc)
>>>and it needs lots of code cleanup or a complete rewrite.
>>
>>
>>I think we fixed some of these problems, and I have a couple of other
>>patches sitting in my queue. Anybody interested can (1) have  a  look
>>at our tree and (2) mail me.
>>
>>Best regards,
>>
>>Wolfgang Denk
> 
> ----------------
> 
>>In message <BPEMKMADCCCPHPEDDKOOMEHFCFAA.surendra.yadav@softdel.com> you wrote:
>>
>>
>>>>I am writing framebuffer driver using SM501. This graphics driver chip can
>>
>>
>>Why are you re-inventing the wheel?
> 
> Because I (for ex.) don't use nor QT, nor X :) and I use 2.6 kernel.
> Also I need USB/AC97... support.
> 
