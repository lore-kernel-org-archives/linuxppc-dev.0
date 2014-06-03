Return-Path: <Chunhe.Lan@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0142.outbound.protection.outlook.com [207.46.163.142])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CDCAF1A0B89
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jun 2014 20:08:36 +1000 (EST)
Message-ID: <538D9F62.2070708@freescale.com>
Date: Tue, 3 Jun 2014 18:11:46 +0800
From: Chunhe Lan <b25806@freescale.com>
MIME-Version: 1.0
To: Tudor Laurentiu <b10716@freescale.com>
Subject: Re: [PATCH v2] powerpc/85xx: Add T4240RDB board support
References: <1401786611-30378-1-git-send-email-Chunhe.Lan@freescale.com>
 <538D9C79.20903@freescale.com>
In-Reply-To: <538D9C79.20903@freescale.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 Chunhe Lan <Chunhe.Lan@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/03/2014 05:59 PM, Tudor Laurentiu wrote:
> Hi Chunhe
>
> Comment inline ...
>
> On 06/03/2014 12:10 PM, Chunhe Lan wrote:
>
>
>>
>> diff --git a/arch/powerpc/platforms/85xx/corenet_generic.c 
>> b/arch/powerpc/platforms/85xx/corenet_generic.c
>> index 8e4b1e1..2f50526 100644
>> --- a/arch/powerpc/platforms/85xx/corenet_generic.c
>> +++ b/arch/powerpc/platforms/85xx/corenet_generic.c
>> @@ -119,6 +119,7 @@ static const char * const boards[] __initconst = {
>>       "fsl,P5020DS",
>>       "fsl,P5040DS",
>>       "fsl,T4240QDS",
>> +    "fsl,T4240RDB",
>
> T4240RDB is supported & tested under hypervisor so please also add the 
> hypervisor compatible in the "hv_boards" array below.
>
      I never use under hypervisor of T4240RDB. Thank you that you 
provide this information.
      I will add T4240RDB hv support.

Thanks,
-Chunhe
> ---
> Thanks & Best Regards, Laurentiu
