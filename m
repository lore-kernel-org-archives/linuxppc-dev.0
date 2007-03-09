Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2DA54DDE9F
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Mar 2007 15:22:47 +1100 (EST)
In-Reply-To: <7EA18FDD2DC2154AA3BD6D2F22A62A0E5F6A16@zch01exm23.fsl.freescale.net>
References: <1173300525.23776.136.camel@ld0161-tx32>
	<7EA18FDD2DC2154AA3BD6D2F22A62A0E5F6A11@zch01exm23.fsl.freescale.net>
	<20303D6D-C19A-4BDB-B540-9994AC538642@kernel.crashing.org>
	<7EA18FDD2DC2154AA3BD6D2F22A62A0E5F6A16@zch01exm23.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <A74C51F0-4BAE-4B6D-BF16-E911BAC884DC@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Move 8641 PCI-Express to arch/powerpc/sysdev/fsl_pcie.c.
Date: Thu, 8 Mar 2007 22:21:50 -0600
To: Zang Roy-r61911 <tie-fei.zang@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 8, 2007, at 9:53 PM, Zang Roy-r61911 wrote:

>>
>> On Mar 8, 2007, at 9:32 PM, Zang Roy-r61911 wrote:
>>
>>>> This move sets the stage for the use of generic PCI
>> Express code in
>>>> 85xx and 86xx parts from FSL.  Subsequent patches for
>>>> 8548 and 8544 will be able to use this shared code.
>>>>
>>>> Signed-off-by: Jon Loeliger <jdl@freescale.com>
>>>> Acked-by: Andy Fleming <afleming@freescale.com>
>>>> ---
>>>>  arch/powerpc/Kconfig                               |    5 +++++
>>>>  arch/powerpc/platforms/86xx/Makefile               |    2 +-
>>>>  arch/powerpc/sysdev/Makefile                       |    1 +
>>>>  .../86xx/mpc86xx_pcie.c => sysdev/fsl_pcie.c}      |    2 --
>>>>  4 files changed, 7 insertions(+), 3 deletions(-)  rename
>>>> arch/powerpc/{platforms/86xx/mpc86xx_pcie.c => sysdev/fsl_pcie.c}
>>>> (100%)
>>>>
>>>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig index
>>>> 6dfbd52..f68de20 100644
>>>> --- a/arch/powerpc/Kconfig
>>>> +++ b/arch/powerpc/Kconfig
>>>> @@ -168,6 +168,7 @@ config PPC_86xx
>>>>  	bool "Freescale 86xx"
>>>>  	select 6xx
>>>>  	select FSL_SOC
>>>> +	select FSL_PCIE
>>>>  	select PPC_FPU
>>>>  	select ALTIVEC
>>>>  	help
>>>> @@ -1022,6 +1023,10 @@ config SBUS
>>>>  config FSL_SOC
>>>>  	bool
>>>>
>>>> +config FSL_PCIE
>>>> +	bool
>>>> +	depends on PPC_86xx
>>>> +
>>> How about 8548 with pcie?
>>
>> There isn't any in tree 85xx user of PCIe at this point.
> No!
> At lease my original serial patches include the pcie support for 8548.
> Roy

Which patches?  I'm not seeing any code for 8548. Can you point at  
something specific in the tree?

- k
