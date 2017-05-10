Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wN4Mv3rzPzDqKm
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 May 2017 15:21:15 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Daniel Axtens <dja@axtens.net>, Anju T Sudhakar <anju@linux.vnet.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
Subject: Re: [PATCH v8 05/10] powerpc/perf: IMC pmu cpumask and cpuhotplug
 support
In-Reply-To: <87shkfqvx6.fsf@possimpible.ozlabs.ibm.com>
References: <1493907596-11425-1-git-send-email-anju@linux.vnet.ibm.com>
 <1493907596-11425-6-git-send-email-anju@linux.vnet.ibm.com>
 <87shkfqvx6.fsf@possimpible.ozlabs.ibm.com>
Date: Wed, 10 May 2017 15:21:15 +1000
Message-ID: <87lgq570dw.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Daniel Axtens <dja@axtens.net> writes:
>>  include/linux/cpuhotplug.h                     |   1 +
...
>> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
>> index 62d240e..51dff54 100644
>> --- a/include/linux/cpuhotplug.h
>> +++ b/include/linux/cpuhotplug.h
>> @@ -137,6 +137,7 @@ enum cpuhp_state {
>> 	CPUHP_AP_PERF_ARM_CCN_ONLINE,
>> 	CPUHP_AP_PERF_ARM_L2X0_ONLINE,
>> 	CPUHP_AP_PERF_ARM_QCOM_L2_ONLINE,
>> +	CPUHP_AP_PERF_POWERPC_NEST_ONLINE,
>> 	CPUHP_AP_WORKQUEUE_ONLINE,
>> 	CPUHP_AP_RCUTREE_ONLINE,
>> 	CPUHP_AP_ONLINE_DYN,

> Who owns this? get_maintainer.pl doesn't give me anything helpful
> here... Do we need an Ack from anyone?

Presumably Thomas Gleixner (who I added to Cc), though I don't know if
he wants to ack every change to it.

cheers
