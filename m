Return-Path: <clemens.koller@anagramm.de>
Received: from moutvdomng.kundenserver.de (moutvdom.kundenserver.de
	[212.227.126.249]) by ozlabs.org (Postfix) with ESMTP id 3703A67C27
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  4 Jul 2005 19:03:39 +1000 (EST)
Message-ID: <42C8FB65.1030309@anagramm.de>
Date: Mon, 04 Jul 2005 11:03:33 +0200
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: Dan Malek <dan@embeddededge.com>
References: <42C40BD0.8040408@anagramm.de><658739DB-540F-4AFC-80DC-BBF0C2AD70F4@freescale.com><42C4162E.4030602@anagramm.de><427c70958bb995dad4fbad2e6ff121bc@embeddededge.com><42C4F50D.3050405@anagramm.de>
	<d946affc11510f7116710026d2a8d1f3@embeddededge.com>
	<004001c57e47$5cae9410$0301a8c0@chuck2>
	<d67d2bddad7bf2be742b8d53768482bf@embeddededge.com>
In-Reply-To: <d67d2bddad7bf2be742b8d53768482bf@embeddededge.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MPC85xx DMA support for Kernel 2.6?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi, Dan and Mark!

Dan Malek wrote:
> On Jul 1, 2005, at 10:15 AM, Mark Chambers wrote:
> 
>> Is the SRAM being cached?  I don't think the CPU will generate bursts
>> unless it's cached, right?
> 
> I don't really remember :-)  I know the 8xx will not burst if the line 
> isn't
> cached, and I know the 7xxx will.  I thought the 82xx and 85xx would
> also burst if you had sufficient sequential operations queued.  On
> 83/85xx you have to further qualify the discussion based upon the DDR2
> or the local bus interface :-)  The CPM and DMA will burst on all
> buses for 8xx/82xx/83xx/85xx if the memory controller is configured
> to do so.

Thanks, for your comments! I'll have a look at it during the
next days and let you know about my mileage :-)

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
