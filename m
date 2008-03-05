Return-Path: <asmirnov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id F421DDDFCB
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Mar 2008 01:36:45 +1100 (EST)
Message-ID: <47CEB1F7.7020803@ru.mvista.com>
Date: Wed, 05 Mar 2008 17:45:11 +0300
From: Alexandr Smirnov <asmirnov@ru.mvista.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 3/4] Emerson KSI8560 device tree
References: <20080304162322.GA19634@ru.mvista.com>
	<20080304163540.GD19634@ru.mvista.com>
	<20080304232940.GB8399@localhost.localdomain>
In-Reply-To: <20080304232940.GB8399@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi

David, could you please explain what do you mean by "old bindind"? I 
looked through ppc_dev listing,
documentation, and how it's done for other boards, but didn't find any 
difference with my code. Maybe
you're talking about future changes in ethernet driver registration?

Thanks,
Alexandr.

David Gibson wrote:
>> +			device_type = "network";
>> +			model = "TSEC";
>> +			compatible = "gianfar";
>>     
>
> This still looks like the old binding.
>   
