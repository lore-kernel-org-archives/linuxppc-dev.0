Return-Path: <sudeep.holla@arm.com>
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 3tJrPH6jD6zDt0R
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2016 04:10:43 +1100 (AEDT)
Subject: Re: [PATCH 2/2] soc: fsl: fix section mismatch build warnings
To: Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org
References: <1479314367-9169-1-git-send-email-sudeep.holla@arm.com>
 <1479314367-9169-2-git-send-email-sudeep.holla@arm.com>
 <48395491.F1myL99mt3@wuerfel>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Scott Wood <oss@buserror.net>,
 Yangbo Lu <yangbo.lu@nxp.com>, linux-kernel@vger.kernel.org
From: Sudeep Holla <sudeep.holla@arm.com>
Message-ID: <359fecae-1bd0-76d2-2d26-b6f24cf15f4a@arm.com>
Date: Wed, 16 Nov 2016 17:10:32 +0000
MIME-Version: 1.0
In-Reply-To: <48395491.F1myL99mt3@wuerfel>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 16/11/16 17:07, Arnd Bergmann wrote:
> On Wednesday, November 16, 2016 4:39:27 PM CET Sudeep Holla wrote:
>> @@ -223,6 +222,7 @@ static struct platform_driver fsl_guts_driver = {
>>
>>  static int __init fsl_guts_init(void)
>>  {
>> +       machine = of_flat_dt_get_machine_name();
>>         return platform_driver_register(&fsl_guts_driver);
>>  }
>>  core_initcall(fsl_guts_init);
>
> I think we simply need to use the normal DT API rather than the of_flat_* one.
>

I thought so, yes that will be better. I will respin accordingly.

-- 
Regards,
Sudeep
