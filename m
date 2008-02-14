Return-Path: <becky.bruce@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9AE57DDF52
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Feb 2008 07:58:29 +1100 (EST)
In-Reply-To: <20080213.170938.34536425.davem@davemloft.net>
References: <20080213.170938.34536425.davem@davemloft.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <38133B3C-75A2-4465-9484-7BF8E7E85D1D@freescale.com>
From: Becky Bruce <becky.bruce@freescale.com>
Subject: Re: [PATCH 0/4]: Respun LMB patches.
Date: Thu, 14 Feb 2008 14:58:22 -0600
To: David Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 13, 2008, at 7:09 PM, David Miller wrote:

>
> I've taken into consideration the various feedback, and
> ported the bug fix and other LMB patches posted recently
> in an effort to keep the patch churn by others down wrt.
> my moving of these files.
>
> 1) Use HAVE_LMB as suggested by Sam.
>
> 2) Fix potential build errors wrt. asm/prom.h dependencies.
>
>    My algorithm was:
>
>    a) If the file only included asm/lmb.h I added an include
>       of both linux/lmb.c and asm/prom.h
>
>    b) If the file already includes asm/prom.h, I merely
>       changed the asm/lmb.h to linux/lmb.h
>
>    Header include mimimizations can be done as followon patches.
>
> 3) Integrate Kumar Gala's initial region fix.
>
> 4) Integrate Becky Bruce's large physical addressing change,
>    but using u64 instead of phys_addr_t.
>
> It's all at:
>
> 	master.kernel.org:/pub/scm/linux/kernel/git/davem/lmb-2.6.git
>
> like before.


Thanks for picking up the patches from Kumar and myself and fitting  
them into your series - this is much appreciated.  FYI, I applied the  
entire patch series to my local tree and test-booted both mpc8641 and  
mpc8568mds and both build and boot cleanly. I also built pasemi and  
ebony, those build cleanly as well.

Cheers,
Becky
