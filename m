Return-Path: <rashmica.g@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wHkkq69yLzDqBQ
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 May 2017 13:52:35 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id i63so6577011pgd.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 May 2017 20:52:35 -0700 (PDT)
Subject: Re: [PATCH 1/2] powerpc/powernv: Add config option for removal of
 memory
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, anton@samba.org,
 npiggin@gmail.com, bsingharora@gmail.com, oohall@gmail.com
References: <20170428054227.9176-1-rashmica.g@gmail.com>
 <9618346f-36ef-2943-f5c0-5be1e87b28f9@linux.vnet.ibm.com>
From: Rashmica Gupta <rashmica.g@gmail.com>
Message-ID: <7d3de1f8-a23c-67e9-46e4-6b6677682010@gmail.com>
Date: Wed, 3 May 2017 13:52:27 +1000
MIME-Version: 1.0
In-Reply-To: <9618346f-36ef-2943-f5c0-5be1e87b28f9@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 28/04/17 19:39, Anshuman Khandual wrote:
> On 04/28/2017 11:12 AM, Rashmica Gupta wrote:
>> Signed-off-by: Rashmica Gupta <rashmica.g@gmail.com>
> Please describe a bit about the function/feature you are trying
> to add with this new config option. The subject says " Add config
> option for removal of memory" but I guess its not related to
> memory hotplug but about hardware enabled tracing IIUC.

Correct!

> Hence
> it should have some amount of description.
>
>> ---
>>   arch/powerpc/platforms/powernv/Kconfig  | 4 ++++
>>   arch/powerpc/platforms/powernv/Makefile | 1 +
>>   2 files changed, 5 insertions(+)
>>
>> diff --git a/arch/powerpc/platforms/powernv/Kconfig b/arch/powerpc/platforms/powernv/Kconfig
>> index 6a6f4ef..1b8b3a8 100644
>> --- a/arch/powerpc/platforms/powernv/Kconfig
>> +++ b/arch/powerpc/platforms/powernv/Kconfig
>> @@ -30,3 +30,7 @@ config OPAL_PRD
>>   	help
>>   	  This enables the opal-prd driver, a facility to run processor
>>   	  recovery diagnostics on OpenPower machines
>> +
>> +config HARDWARE_TRACING
> This is too generic for platform specific feature and also it does
> not intend to fit into a generic HW tracing infrastructure. IMHO
> it should be named something like "PPC64_HARDWARE_TRACING" or
> something similar.
>
>> +	bool 'Enable removal of memory for hardware memory tracing'
> If this memory is going to be taken out of memblock like normal
> memory hotplug and eventually goes away from kernel control, then
> you need to be more specific about its usage.
>

All good points! Thanks for the review.
