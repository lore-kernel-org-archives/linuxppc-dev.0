Return-Path: <clemens.koller@anagramm.de>
Received: from moutvdomng.kundenserver.de (moutvdom.kundenserver.de
	[212.227.126.249]) by ozlabs.org (Postfix) with ESMTP id 68A3A679E9
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  1 Jun 2005 02:18:02 +1000 (EST)
Message-ID: <429C8E23.2040208@anagramm.de>
Date: Tue, 31 May 2005 18:17:39 +0200
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: Kumar Gala <kumar.gala@freescale.com>
References: <429C8AC4.9000801@anagramm.de>
	<bb83727d8d949477f261e00351c091f2@freescale.com>
In-Reply-To: <bb83727d8d949477f261e00351c091f2@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Complete ccsr map for mpc8540 available?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello, Kumar!

 > > [...]
> Yes, that was my thinking.  You can grab just the lbc bits and put them 
> in immap_85xx.h and do the same ioremap thing we do for pci in 
> arch/ppc/syslib/ppc85xx_setup.c.

Yes, ioremap() and ioremap_nocache() works fine.
I just try to get the maximum speed out of the Local Bus Mapped dual port
SRAM in our FPGA.

>> I can release my stuff, if anybody is interested... no problem.
>> The LBC part is verified (some others are dummys and untested) and in
>> a /works for me/ state.
> 
> It sounds like this is custom to your board so I wouldn't bother 
> releasing it out unless it something you want to get into the standard 
> kernel tree.

Well, the immr is good for every mpc8540 and the other friends you know.
(more than me)

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
