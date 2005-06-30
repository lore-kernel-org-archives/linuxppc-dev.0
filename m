Return-Path: <clemens.koller@anagramm.de>
Received: from moutvdomng.kundenserver.de (moutvdom.kundenserver.de
	[212.227.126.249]) by ozlabs.org (Postfix) with ESMTP id B6EC767B59
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Jul 2005 01:12:19 +1000 (EST)
Received: from [212.227.126.221] (helo=mrvdomng.kundenserver.de)
	by moutvdomng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 1Do0i9-0001mK-00
	for linuxppc-embedded@ozlabs.org; Thu, 30 Jun 2005 17:12:17 +0200
Received: from [84.154.107.47] (helo=[192.168.1.10])
	by mrvdomng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 1Do0i8-00021Z-00
	for linuxppc-embedded@ozlabs.org; Thu, 30 Jun 2005 17:12:17 +0200
Message-ID: <42C40BD0.8040408@anagramm.de>
Date: Thu, 30 Jun 2005 17:12:16 +0200
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: MPC85xx DMA support for Kernel 2.6?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello!

I am planning to use DMA/burst access for copying large chunks of data
(100MBytes) from the Local Bus (UPM accessed SRAM) to System Memory (DDR)
as fast as possible (200MBytes/s). (As you can guess, that's a framegrabber).

As far as I have seen, the DMA engines of the MPC85xx (fsl-dma) are not
supported in the classical way (dma_request(), free_dma()) in the kernel 2.6.x.
The memory allocators in arch/ppc/dma-mapping.c seem to be usable,
but there is no valuable dma support yet (true?).

I can program the DMA Controllers in my MPC8540 on my own to achieve what I want
but it would be great to get/produce/stick with as much cross-platform reusable
code as possible.

Is there any ongoing work to put DMA support for the mpc85xx and similar
devices into the kernel? Is there any ongoing work in this area
or is somebody working with the fsl-dma and can publish some code and
share some ideas?

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
