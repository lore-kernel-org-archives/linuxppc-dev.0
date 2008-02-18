Return-Path: <clemens.koller@anagramm.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id 40726DDE26
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 19 Feb 2008 10:51:03 +1100 (EST)
Message-ID: <47BA19E4.9010609@anagramm.de>
Date: Tue, 19 Feb 2008 00:51:00 +0100
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: mahendra varman <mahendravarman15@gmail.com>
Subject: Re: reg Philips ISP 1562 usb controller support in linux2.6.23.11
References: <4ac2955e0802140528i69fece47xa6d751200c5616f9@mail.gmail.com>	
	<47B471D2.3090906@anagramm.de>
	<4ac2955e0802180845m3287e30bi42f57b0a2522983f@mail.gmail.com>
In-Reply-To: <4ac2955e0802180845m3287e30bi42f57b0a2522983f@mail.gmail.com>
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

Hi, Magendra!

- please don't top-post!
- and please keep the list on CC:

mahendra varman schrieb:
> Sir,
> I have enabled the necessary configs for ISP1562
> 
> The IRQ number is 39 and while probing the driver correctly assigns the 
> IRQ number
> 
> but if i insert a device in usb port iam getting error as
> 
> Unlink after no-IRQ?  "
>             "Controller is probably using the wrong IRQ"
> 
> Although the interrupt number assignment is correct why it gives the 
> above message ?

Well, that seems odd. What kind of cpu / platform / hardware are you using?
Please send the output of `lspci -vv` and `cat /proc/cpuinfo`
If you have the ISP1562 attached to PCI, I guess the interrupt assignments
are wrong or the IRQ line is broken.

Regards,

Clemens
