Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5765BDDDCA
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Mar 2007 14:50:04 +1100 (EST)
In-Reply-To: <989B956029373F45A0B8AF02970818902DB0EA@zch01exm26.fsl.freescale.net>
References: <989B956029373F45A0B8AF02970818902DB0EA@zch01exm26.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <88E3290D-D9C8-48F0-9D47-D2235D5F092E@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH][POWERPC] QE: Make QUICC Engine support a
	configurableoption
Date: Wed, 14 Mar 2007 22:49:08 -0500
To: Li Yang-r58472 <LeoLi@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Phillips Kim-R1AAHA <Kim.Phillips@freescale.com>,
	Tabi Timur-B04825 <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 14, 2007, at 10:02 PM, Li Yang-r58472 wrote:

>> -----Original Message-----
>> From: linuxppc-dev-bounces+leoli=freescale.com@ozlabs.org
>> [mailto:linuxppc-dev-bounces+leoli=freescale.com@ozlabs.org] On  
>> Behalf
> Of Timur
>> Tabi
>> Sent: Thursday, March 15, 2007 3:36 AM
>> To: Phillips Kim-R1AAHA
>> Cc: linuxppc-dev@ozlabs.org
>> Subject: Re: [PATCH][POWERPC] QE: Make QUICC Engine support a
> configurableoption
>>
>> Kim Phillips wrote:
>>> On Wed, 14 Mar 2007 13:15:05 -0500 (CDT)
>>> Kumar Gala <galak@kernel.crashing.org> wrote:
>>>
>>>>  arch/powerpc/Kconfig                |    8 --------
>>>>  arch/powerpc/platforms/83xx/Kconfig |   12 ++++++++++--
>>>>  2 files changed, 10 insertions(+), 10 deletions(-)
>>>
>>> What about 85xx QE support?
>>
>> Kumar and I talked about it.  85xx support will be added when QE  
>> works
> on 85xx.
>> However,
>> the patch still needs changes.  To allow each CPU family to have its
> own QE option,
>> we'll
>> need to define something like QUICC_ENGINE_83xx and  
>> QUICC_ENGINE_85xx,
> and then
>> have
>> something like this:
>>
>> config QUICC_ENGINE
>> 	bool
>> 	default y if QUICC_ENGINE_83xx || QUICC_ENGINE_85xx
>
> I don't think we need these new options.  If there are differences
> between the two SOC versions, presumably not too many, we can address
> them in device tree.  It's better to leave the QUICC_ENGINE option at
> arch/powerpc/Kconfig level, IMHO.


The issue isn't dealing with differences between 83xx/85xx.  Its  
allowing the choice for only those two subarchs.

- k
