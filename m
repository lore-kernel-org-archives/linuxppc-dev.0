Return-Path: <Chunhe.Lan@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0185.outbound.protection.outlook.com [207.46.163.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 442A61A0849
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jun 2014 18:54:47 +1000 (EST)
Message-ID: <538D8E15.5070506@freescale.com>
Date: Tue, 3 Jun 2014 16:57:57 +0800
From: Chunhe Lan <b25806@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] powerpc/85xx: Add T4240RDB board support
References: <1401264681-30058-1-git-send-email-Chunhe.Lan@freescale.com>
 <1401485104.6603.221.camel@snotra.buserror.net>
In-Reply-To: <1401485104.6603.221.camel@snotra.buserror.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org, Chunhe Lan <Chunhe.Lan@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/31/2014 05:25 AM, Scott Wood wrote:
> On Wed, 2014-05-28 at 16:11 +0800, Chunhe Lan wrote:
>> diff --git a/arch/powerpc/platforms/85xx/corenet_generic.c b/arch/powerpc/platforms/85xx/corenet_generic.c
>> index 8e4b1e1..2f50526 100644
>> --- a/arch/powerpc/platforms/85xx/corenet_generic.c
>> +++ b/arch/powerpc/platforms/85xx/corenet_generic.c
>> @@ -119,6 +119,7 @@ static const char * const boards[] __initconst = {
>>   	"fsl,P5020DS",
>>   	"fsl,P5040DS",
>>   	"fsl,T4240QDS",
>> +	"fsl,T4240RDB",
>>   	"fsl,B4860QDS",
>>   	"fsl,B4420QDS",
>>   	"fsl,B4220QDS",
> What about hv_boards?
     Does not have hv boards. So does not support hv.

Thanks,
-Chunhe
>
> -Scott
>
>
