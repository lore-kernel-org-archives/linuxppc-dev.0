Return-Path: <pbadari@us.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6883ADDE3A
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Mar 2008 14:06:15 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m2136CnE015974
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Feb 2008 22:06:12 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m2136CBv183812
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Feb 2008 20:06:12 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m2136Con008883
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Feb 2008 20:06:12 -0700
Message-ID: <47C8C823.9090700@us.ibm.com>
Date: Fri, 29 Feb 2008 19:06:11 -0800
From: Badari Pulavarty <pbadari@us.ibm.com>
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>
Subject: Re: [RFC] updating lmb.memory information for hot mem add/remove
References: <1204247002.7729.11.camel@concordia.ozlabs.ibm.com>
	<1204307816.10146.11.camel@dyn9047017100.beaverton.ibm.com>
	<1204333964.10146.18.camel@dyn9047017100.beaverton.ibm.com>
	<20080229.174434.216640668.davem@davemloft.net>
In-Reply-To: <20080229.174434.216640668.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: paulus@samba.org, anton@au1.ibm.com, ntl@pobox.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Miller wrote:
> From: Badari Pulavarty <pbadari@us.ibm.com>
> Date: Fri, 29 Feb 2008 17:12:44 -0800
>
>   
>> Here is what I cooked up and it seems to work fine.
>> It may be easier to review the code (against my earlier patches).
>>     
>
> BTW, the lmb code now lives under lib/ (sparc64 will be using it too)
> and has several bug fixes applied to it in Paulus's current upstream
> tree.
>   
Yes. I noticed that earlier. But it was easy for me to test against 
mainline/-mm.
I can easily update it against Paul's tree, if every one is okay with 
the changes
I am proposing.

Thanks,
Badari
