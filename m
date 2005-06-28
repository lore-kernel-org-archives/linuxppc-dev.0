Return-Path: <clemens.koller@anagramm.de>
Received: from moutvdomng.kundenserver.de (moutvdom.kundenserver.de
	[212.227.126.249]) by ozlabs.org (Postfix) with ESMTP id 6D49267A45
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 29 Jun 2005 02:06:26 +1000 (EST)
Message-ID: <42C17579.5030500@anagramm.de>
Date: Tue, 28 Jun 2005 18:06:17 +0200
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: Kumar Gala <kumar.gala@freescale.com>
References: <87zmtavasj.fsf@nimrod.unx.ca>
	<A6920FBA-2DBF-4E09-9B8D-1612A4DA6AAD@freescale.com>
In-Reply-To: <A6920FBA-2DBF-4E09-9B8D-1612A4DA6AAD@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "<jbi130@yahoo.com>" <jbi130@yahoo.com>, linuxppc-embedded@ozlabs.org
Subject: Re: 2.6 support for MPC8541(e)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi!

I had to do the same for my MPC8540 board (Microsys PM854).
It's based on the MPC8540_ADS platform, too with
changes in PCI subsystem and Gigabit Ethernet (gianfar_phy).

Enable early serial and enjoy printk.
Try to find out, where it hangs.

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

Kumar Gala wrote:
> You probably need to port the platform code from 2.4 to 2.6 for this  
> board.  I'm guessing you are running into some PCI config issue with  
> interrupts and the such.
> 
> Take a look at arch/ppc/platforms/85xx/* for examples of boards that  
> support 85xx processors.
> 
> - kumar
> 
> On Jun 28, 2005, at 9:03 AM, <jbi130@yahoo.com> <jbi130@yahoo.com>  wrote:
> 
>> I've recently received a GDA PCI-G8400 evaluation board with an
>> MPC8541E.  It came with u-boot 1.1.2 and a 2.4.27 kernel.
>>
>> Our hopes are to get a 2.6 kernel running on this device so it is in
>> sync with out MPC8248 based boards.
>>
>> What is the status of the support for these chips?  When I enable
>> CONFIG_SERIAL_TEXT_DEBUG I'm able to get some output, it seems to die
>> when initializing openpic.  There also appears to be issues with the
>> serial console as I'm not getting printk output at all, and I think I
>> should be by the time start_kernel is entered.
>>
>> My current 2.6.12 builds use the MPC8540_ADS configs as a base.  The
>> 2.4 that was received with the board does as well.
>>
>> For now I'm not concerned with the 'E' part.  My main job is to
>> actually add support for the security engine, but I'd like to get 2.6
>> up and running first.  Yes, this is my first jump into machine
>> specific code..
>>
>> Thanks.
>>
>> _______________________________________________
>> Linuxppc-embedded mailing list
>> Linuxppc-embedded@ozlabs.org
>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>>
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
