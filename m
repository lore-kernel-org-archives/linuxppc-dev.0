Return-Path: <R58495@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe001.messaging.microsoft.com [207.46.163.24])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 509142C011F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Oct 2013 11:39:32 +1100 (EST)
Message-ID: <526F03BB.7010506@freescale.com>
Date: Mon, 28 Oct 2013 17:39:23 -0700
From: York Sun <yorksun@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [5/7] powerpc/corenet64_smp_defconfig: Enable most SPI splash
References: <1378482199-10581-5-git-send-email-yorksun@freescale.com>
 <20131029002834.GA8680@home.buserror.net>
In-Reply-To: <20131029002834.GA8680@home.buserror.net>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/28/2013 05:28 PM, Scott Wood wrote:
> On Fri, Sep 06, 2013 at 08:43:17AM -0700, York Sun wrote:
>> Enable CONFIG_MTD_M25P80 for corenet64_smp_defconfig. Verified on
>> P5040DS.
>>
>> Signed-off-by: York Sun <yorksun@freescale.com>
>> Reviewed-by: Wood Scott-B07421 <scottwood@freescale.com>
>> Reviewed-by: Fleming Andrew-AFLEMING <AFLEMING@freescale.com>
>> Tested-by: Fleming Andrew-AFLEMING <AFLEMING@freescale.com>
>>
>> ---
>> arch/powerpc/configs/corenet64_smp_defconfig |    1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/powerpc/configs/corenet64_smp_defconfig b/arch/powerpc/configs/corenet64_smp_defconfig
>> index 6c8b020..1ec6f0c 100644
>> --- a/arch/powerpc/configs/corenet64_smp_defconfig
>> +++ b/arch/powerpc/configs/corenet64_smp_defconfig
>> @@ -66,6 +66,7 @@ CONFIG_MTD_CMDLINE_PARTS=y
>>  CONFIG_MTD_CHAR=y
>>  CONFIG_MTD_BLKDEVS=y
>>  CONFIG_MTD_BLOCK=y
>> +CONFIG_MTD_M25P80=y
>>  CONFIG_FTL=y
>>  CONFIG_MTD_CFI=y
>>  CONFIG_MTD_GEN_PROBE=y
> 
> This has already been enabled in corenet64_smp_config since
> commit 478a4829d815865b919c1fa20f0f33543a2291fb, over a year ago.
> 

Oh. Thanks. Please drop it then.

York
