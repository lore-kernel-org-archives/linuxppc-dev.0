Return-Path: <clemens.koller@anagramm.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 64AA7DDEB8
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 20 Feb 2008 03:53:59 +1100 (EST)
Message-ID: <47BB09A2.7060901@anagramm.de>
Date: Tue, 19 Feb 2008 17:53:54 +0100
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: mahendra varman <mahendravarman15@gmail.com>
Subject: Re: reg Philips ISP 1562 usb controller support in linux2.6.23.11
References: <4ac2955e0802140528i69fece47xa6d751200c5616f9@mail.gmail.com>	
	<47B471D2.3090906@anagramm.de>	
	<4ac2955e0802180845m3287e30bi42f57b0a2522983f@mail.gmail.com>	
	<47BA19E4.9010609@anagramm.de>
	<4ac2955e0802190807s5a19cdfeo6788fc5874424847@mail.gmail.com>
In-Reply-To: <4ac2955e0802190807s5a19cdfeo6788fc5874424847@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello, Magendra!

mahendra varman schrieb:
> Iam using a powerpc processor (7448)
> cat proc/cpu info is
> processor       : 0
> cpu             : 7448
> revision        : 2.2 (pvr 8004 0202)
> bogomips        : 995.32
> vendor          : Cornet India Ltd
> machine         : CTP7448
> PB freq         : 133Mhz
> SDC freq        : 0Mhz
> 
> Sir, Today I noticed that when ever i insert a mp3usb stick it is giving 
> Unlink after no-IRQ?  "
> "Controller is probably using the wrong IRQ"

Try booting the kernel with "irqpoll". Example:

 > linux noapic pci=irqroute pci=noacpi acpi=off irqpoll

Check if that helps.

> but if i insert an  usbflash stick(without mp3)  It is enumerating and i 
> can able to mount the usb and read the content
> 
> I wonder why iam getting unlink after no IRQ for some devices and for 
> others iam not getting that

Well, I just don't know.
What kernel architecture do you use? ppc or powerpc?
In case you use the former (which is deprecated),
you might want to try the latter.

> Please clear my query sir

(-: Please follow my advices:

1. DO NOT remove the mailing list from CC: (and the chance anybody is
    able to help you!)
2. post the output of lspci -vv.

Next step is: contact the guys in the linux-usb mailing list.

Regards,

Clemens
