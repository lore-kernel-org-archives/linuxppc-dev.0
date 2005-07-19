Return-Path: <clemens.koller@anagramm.de>
Received: from moutvdomng.kundenserver.de (moutvdom.kundenserver.de
	[212.227.126.249]) by ozlabs.org (Postfix) with ESMTP id 64AC767C39
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 19 Jul 2005 23:40:09 +1000 (EST)
Message-ID: <42DD02B5.4090604@anagramm.de>
Date: Tue, 19 Jul 2005 15:40:05 +0200
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: Kumar Gala <kumar.gala@freescale.com>
References: <42DCCF89.8040803@anagramm.de>
	<B6B4D7F0-2E8B-4779-95C5-6F8993C6D6A9@freescale.com>
In-Reply-To: <B6B4D7F0-2E8B-4779-95C5-6F8993C6D6A9@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: ppcembed Mailing List <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] ppc32: Register definition for MPC85xx
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello, Kumar,

> This isn't going to get into the kernel tree.  I'm against putting  full 
> register definitions in like this because they are too difficult  to 
> maintain properly.  We currently have some 14 different 85xx  devices 
> today and the number is only going to grow larger.

Okay, no problem.

I experienced that it is definitely difficult to maintain if there are lot of
changes/patches which can corrupt the whole set if only one register
is misaligned. Once a set it's completed for a device, it could be nailed down
to a specific device by specifying a filename like immap_mpc8540.h

And... it doesn't necessarily stay within the kernel tree... maybe Freescale
can put out those files on their website for reference?

Best greets,

Clemens Koller

Kumar Gala wrote:
> Clemens,
> 
> This isn't going to get into the kernel tree.  I'm against putting  full 
> register definitions in like this because they are too difficult  to 
> maintain properly.  We currently have some 14 different 85xx  devices 
> today and the number is only going to grow larger.
> 
> If and when you need something specific in the immap_85xx please  
> provide it as a patch along with the driver that you want in.  For  
> certain devices like PCI, LBC, etc I've got no issue adding info into  
> immap_85xx.  However, for devices like DUART, I2C, TSEC, etc I'm  
> completely against the idea of having their register definitions in  
> immap_85xx.
> 
> - kumar
> 
> On Jul 19, 2005, at 5:01 AM, Clemens Koller wrote:
> 
>> Hello!
>>
>> I suggest to put the register definitions into the Kernel _before_
>> more driver writers start using their own / different maps.
>>
>> Greets,
>>
>> Clemens Koller
>>
>> ---
>> Almost complete and verified register map for the MPC85xx.
>> Based on sources from Jason McMullan and the MPC8540 Reference Manual.
>>
>> Signed-off-by: Clemens Koller <clemens.koller@anagramm.de>
>>
>>
>> <immap_85xx-register-update.patch>
>> <ATT1082226.txt>
>>
> 
> 
