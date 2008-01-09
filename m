Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 2555ADDFF6
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 04:26:15 +1100 (EST)
Message-ID: <478503B6.3060402@pikatech.com>
Date: Wed, 09 Jan 2008 12:26:14 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
MIME-Version: 1.0
To: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH] Miscellaneous for Taco
References: <477F13C0.7040006@pikatech.com> <1199566583.7291.63.camel@pasglop>
	<4783C3E8.3090107@pikatech.com> <200801082023.11475.sr@denx.de>
In-Reply-To: <200801082023.11475.sr@denx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stefan Roese wrote:
> On Tuesday 08 January 2008, Sean MacLennan wrote:
>   
>> How about just 44x?
>>
>> Cheers,
>>     Sean
>>
>> diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
>> index 7580aa5..682deae 100644
>> --- a/drivers/usb/Kconfig
>> +++ b/drivers/usb/Kconfig
>> @@ -39,6 +39,7 @@ config USB_ARCH_HAS_OHCI
>>         # PPC:
>>         default y if STB03xxx
>>         default y if PPC_MPC52xx
>> +       default y if 44x
>>     
>
> No. Not all 44x have OHCI built in. Currently 440EP, 440EPx and 405EZ have it. 
> But since your patch only touches 440EP, you should just enable OHCI for 
> exactly this platform.
>
> Best regards,
> Stefan
>   
Signed-off-by: Sean MacLennan <smaclennan@pikatech.com>
---
diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
index 7580aa5..2660f30 100644
--- a/drivers/usb/Kconfig
+++ b/drivers/usb/Kconfig
@@ -39,6 +39,7 @@ config USB_ARCH_HAS_OHCI
        # PPC:
        default y if STB03xxx
        default y if PPC_MPC52xx
+       default y if 440EP
        # MIPS:
        default y if SOC_AU1X00
        # more:
