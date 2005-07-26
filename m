Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 6E2FD67D4B
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 27 Jul 2005 00:26:44 +1000 (EST)
In-Reply-To: <42E643A4.1070303@varma-el.com>
References: <42E643A4.1070303@varma-el.com>
Mime-Version: 1.0 (Apple Message framework v733)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <C1A57464-9616-40AF-82E6-0616EEE9B69A@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Tue, 26 Jul 2005 09:26:37 -0500
To: "Andrey Volkov" <avolkov@varma-el.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: LITE5200 2.6.x kernel support
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I would assume he does now.  I only sent it out yesterday upon  
finding out that the boards did not boot.

- kumar

On Jul 26, 2005, at 9:07 AM, Andrey Volkov wrote:

> Kumar, thank you.
>
> Sylvain know about this patch?
>
> -- 
> Regards
> Andrey Volkov
>
> Kumar Gala wrote:
>
>>>> I am currently using 2.4.25 on the Lite5200 board, but I'd really
>>>> like to
>>>> switch to 2.6.x. The only 5200 specific support I need are the
>>>> integrated
>>>> uart and the PCI. I tried both 2.6.11 and 2.6.12 without luck: the
>>>> kernel
>>>> start, but then is stuck (seems into the init sequence). I use the
>>>> configuration
>>>> file from arch/ppc/configs/lite5200_defconfig. I cross-compiled the
>>>> kernel with gcc-3.4.1.
>>>>
>>>> I was wondering if somebody could give me some help, maybe by  
>>>> telling
>>>> be what I am doing wrong.
>>>>
>>>> Thanks,
>>>> Olivier
>>>>
>>>> BTW, I tried also 2.6.13-rc3, but I can't even compile for the
>>>> Lite5200,
>>>> there are some syntax error when compile the pci module...
>>>>
>>
>>
>> I think I've address the build issue and posted a patch to lkml for
>> it.  Look for
>>
>> http://www.ussg.iu.edu/hypermail/linux/kernel/0507.3/0365.html
>>
>> - kumar
>>
>>
>>
>
