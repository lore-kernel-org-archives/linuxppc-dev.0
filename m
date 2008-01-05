Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id F020FDDEB8
	for <linuxppc-dev@ozlabs.org>; Sun,  6 Jan 2008 05:22:19 +1100 (EST)
Message-ID: <477FCADA.2010706@pikatech.com>
Date: Sat, 05 Jan 2008 13:22:18 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
MIME-Version: 1.0
To: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH] Miscellaneous for Taco
References: <477F13C0.7040006@pikatech.com> <1199517865.7291.50.camel@pasglop>
	<200801051026.26870.sr@denx.de>
In-Reply-To: <200801051026.26870.sr@denx.de>
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
> On Saturday 05 January 2008, Benjamin Herrenschmidt wrote:
>   
>>> diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
>>> index 7580aa5..480580c 100644
>>> --- a/drivers/usb/Kconfig
>>> +++ b/drivers/usb/Kconfig
>>> @@ -39,6 +39,7 @@ config USB_ARCH_HAS_OHCI
>>>         # PPC:
>>>         default y if STB03xxx
>>>         default y if PPC_MPC52xx
>>> +       default y if TACO
>>>         # MIPS:
>>>         default y if SOC_AU1X00
>>>         # more:
>>>       
>> I think we should instead reference use the 440EP here,
>>     
>
> I vote for adding 440EP here.
>
> Best regards,
> Stefan
>   
Ok. I thought of that, but most 440EP boards have PCI set and don't need 
the special option. I was worried if I put 440EP someone down the road 
might remove it as "extraneous". We are probably the only 440EP board 
with no PCI ;)

Cheers,
    Sean
