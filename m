Return-Path: <clemens.koller@anagramm.de>
Received: from moutvdomng.kundenserver.de (moutvdom.kundenserver.de
	[212.227.126.249]) by ozlabs.org (Postfix) with ESMTP id 90FC167C44
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 16 Jul 2005 01:01:22 +1000 (EST)
Received: from [212.227.126.221] (helo=mrvdomng.kundenserver.de)
	by moutvdomng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 1DtRgm-0003A7-00
	for linuxppc-embedded@ozlabs.org; Fri, 15 Jul 2005 17:01:20 +0200
Received: from [84.154.81.76] (helo=[192.168.1.10])
	by mrvdomng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 1DtRgm-0003F8-00
	for linuxppc-embedded@ozlabs.org; Fri, 15 Jul 2005 17:01:20 +0200
Message-ID: <42D7CFC2.3020006@anagramm.de>
Date: Fri, 15 Jul 2005 17:01:22 +0200
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: MPC8540 DMA routines (channel 0 broken?)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

I am about to bring Jason McMullan's DMA routines up to linux-2.6
Currently I am in the process of getting the things started step
by step.

Until today I had a pretty hard time for some basic direct dma
transfers because it seems that dma channel 0 doesn't work at all
on my hardware (PPC8540PX833LB 2L71V MSIA QEAD0412).
The status register always stays 0x0 (means everything is happy and
okay) but it doesn't copy any data. I cannot even trigger a
programming error by a wrong configuration!
But when I let ch 1,2,3 do the work, everything
seems to work fine!
I havent found anything in the errata sheets or in the web.
Can a DMA machine crash that it stays completely unusable?
Have anybody seen similar things like that?

Some other questions:
I would also suggest to put my revised and almost
complete immap_85xx.h and the mpc85xx_dma module into the
current linux tree (Kumar?) to get things like that
started more easily.
Why is Jason's work not in the Kernel?

If you are fine with that, I can offer some patches.
But I first need to strip tons of the debug stuff from
the last two weeks. :-/

Best greets,

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
