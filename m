Return-Path: <yanok@emcraft.com>
Received: from ocean.emcraft.com (ocean.emcraft.com [213.221.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4AE5DDDE04
	for <linuxppc-dev@ozlabs.org>; Mon,  1 Sep 2008 17:32:36 +1000 (EST)
Message-ID: <48BB9A6E.2000502@emcraft.com>
Date: Mon, 01 Sep 2008 11:31:58 +0400
From: Ilya Yanok <yanok@emcraft.com>
MIME-Version: 1.0
To: benh@kernel.crashing.org
Subject: Re: [PATCH] ppc4xx_pci: necessary fixes for 4GB RAM size
References: <1219391015-6317-1-git-send-email-yanok@emcraft.com>	
	<20080828092820.2cacaba7@zod.rchland.ibm.com>
	<1220228340.13162.401.camel@pasglop>
In-Reply-To: <1220228340.13162.401.camel@pasglop>
Content-Type: text/plain; charset=KOI8-R
Cc: linuxppc-dev@ozlabs.org, sr@denx.de, wd@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
>>> 1. total_memory should be phys_addr_t not unsigned long
>>> 2. is_power_of_2() works with u32 so I just inlined (size & (size-1)) != 0
>>> instead.
>>> Also this patch fixes default initialization: res->end should be 0x7fffffff
>>> not 0x80000000.
>>>
>>> Signed-off-by: Ilya Yanok <yanok@emcraft.com>
>>>       
>> Ben, any comments here?  Looks right to me.
>>     
>
> Just one minor comment... The patch should do what I failed to do
> before, which is to move total_memory declaration to a header :-)
>   

Hm... looks like we already have this declaration in
arch/powerpc/mm/mmu_decl.h... I'll send modified patch soon.

Regards, Ilya.
