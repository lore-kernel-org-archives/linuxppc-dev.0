Return-Path: <yorksun@freescale.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 049341A0762
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 May 2015 06:59:29 +1000 (AEST)
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0145.outbound.protection.outlook.com [207.46.100.145])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 34D6B140F96
 for <linuxppc-dev@ozlabs.org>; Sat, 30 May 2015 06:59:26 +1000 (AEST)
Message-ID: <5568BD61.7030103@freescale.com>
Date: Fri, 29 May 2015 12:26:25 -0700
From: York Sun <yorksun@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>, songwenbin
 <Wenbin.Song@freescale.com>
CC: <linuxppc-dev@ozlabs.org>, <Mingkai.hu@freescale.com>
Subject: Re: [v2,1/2] powerpc/mpc8xxx: Change EDAC for FSL SoC
References: <1430991698-29832-1-git-send-email-Wenbin.Song@freescale.com>
 <20150529004657.GA8866@home.buserror.net>
In-Reply-To: <20150529004657.GA8866@home.buserror.net>
Content-Type: text/plain; charset="windows-1252"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 05/28/2015 05:46 PM, Scott Wood wrote:
> On Thu, May 07, 2015 at 05:41:37PM +0800, songwenbin wrote:
>> From: York Sun <yorksun@freescale.com>
>>
>> Remove mpc83xx and mpc85xx as dependency.
>>
>> Signed-off-by: York Sun <yorksun@freescale.com>
>> Signed-off-by: songwenbin <wenbin.song@freescale.com>
>> ---
>>  drivers/edac/Kconfig | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> These patches need to be sent to the EDAC list and maintainer.
> 
>> diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
>> index cb59619..ad07d4f 100644
>> --- a/drivers/edac/Kconfig
>> +++ b/drivers/edac/Kconfig
>> @@ -262,10 +262,10 @@ config EDAC_SBRIDGE
>>  
>>  config EDAC_MPC85XX
>>  	tristate "Freescale MPC83xx / MPC85xx"
>> -	depends on EDAC_MM_EDAC && FSL_SOC && (PPC_83xx || PPC_85xx)
>> +	depends on EDAC_MM_EDAC && FSL_SOC
>>  	help
>>  	  Support for error detection and correction on the Freescale
>> -	  MPC8349, MPC8560, MPC8540, MPC8548
>> +	  MPC8349, MPC8560, MPC8540, MPC8548, T4240
> 
> Why T4240?  We're not really going to list every mpc85xx/QorIQ PPC chip
> here, are we?

T4240 was the one under debugging. It should be more generic since it removes
PPC_83xx and PPC_85xx.

Wenbin, do you mind update this patch?

York
