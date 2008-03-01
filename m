Return-Path: <pbadari@us.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7E2BFDDF0D
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Mar 2008 14:01:39 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m2131alo005203
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Feb 2008 22:01:36 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m2131aoI218344
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Feb 2008 20:01:36 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m2131aEU000457
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Feb 2008 20:01:36 -0700
Message-ID: <47C8C70F.70204@us.ibm.com>
Date: Fri, 29 Feb 2008 19:01:35 -0800
From: Badari Pulavarty <pbadari@us.ibm.com>
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 3/3] ppc64-specific memory notifier support
References: <1204217028.28696.10.camel@dyn9047017100.beaverton.ibm.com>
	<1204217166.28696.15.camel@dyn9047017100.beaverton.ibm.com>
	<1204243875.7729.3.camel@concordia.ozlabs.ibm.com>
	<20080229003906.GP16241@localdomain>
	<1204247002.7729.11.camel@concordia.ozlabs.ibm.com>
	<1204307236.10146.1.camel@dyn9047017100.beaverton.ibm.com>
	<20080301135123.262bfdb0.sfr@canb.auug.org.au>
In-Reply-To: <20080301135123.262bfdb0.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Nathan Lynch <ntl@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stephen Rothwell wrote:
> On Fri, 29 Feb 2008 09:47:16 -0800 Badari Pulavarty <pbadari@us.ibm.com> wrote:
>   
>> Here is the latest for review. (just to make sure I didn't miss
>> anything).
>>     
>
> Sorry I didn't review the previous ones ... just a small thing.
>
>   
>> +	type = of_get_property(np, "device_type", NULL);
>>     
>
> To use the of_ accessors, you need to include linux/of.h (currently
> asm/prom.h include linux/of.h, but that may not always be true).  In
> fact, I think you don't even need asm/prom.h.
>
>   
Yes. linux/of.h is enough. Thank you for pointing it out.

Thanks,
Badari
