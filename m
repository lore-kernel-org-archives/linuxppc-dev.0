Return-Path: <james4765@cwazy.co.uk>
Received: from out004.verizon.net (out004pub.verizon.net [206.46.170.142])
	by ozlabs.org (Postfix) with ESMTP id 3AE402BF10
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Jan 2005 14:02:14 +1100 (EST)
Message-ID: <41DB5476.9040103@cwazy.co.uk>
Date: Tue, 04 Jan 2005 21:44:06 -0500
From: Jim Nelson <james4765@cwazy.co.uk>
MIME-Version: 1.0
To: Brian Gerst <bgerst@didntduck.org>
References: <20050104214048.21749.85722.89116@localhost.localdomain>
	<41DB4E99.3060200@didntduck.org>
In-Reply-To: <41DB4E99.3060200@didntduck.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] ppc: remove cli()/sti() from arch/ppc/*
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Brian Gerst wrote:

> James Nelson wrote:
>
>> This series of patches is to remove the last cli()/sti() function 
>> calls in arch/ppc.
>>
>> These are the only instances in active code that grep could find.
>
>
> Are you sure none of these need real spinlocks instead of just 
> disabling interrupts?
>
> -- 
>                 Brian Gerst
>
These are for single-processor systems, mostly evaluation boards and 
embedded processors.  I coudn't find any reference to multiprocessor 
setups for the processors in question after a peruse of the code or a 
quick google on the boards in question.

Jim
