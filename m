Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6598FDE323
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jun 2008 01:02:18 +1000 (EST)
Message-Id: <3BF4F03A-FD90-47BC-9F53-659848BE832E@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Liu Dave <DaveLiu@freescale.com>
In-Reply-To: <58A20A281BAF1047B4EAE68DE5C0BDC201011622@zch01exm21.fsl.freescale.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [PATCH 1/3] mpc83xx: Power Management support
Date: Thu, 26 Jun 2008 09:54:59 -0500
References: <20080625215051.GA11784@loki.buserror.net>
	<D70F79B4-BA5F-46D4-9D74-4CB2E375AF60@kernel.crashing.org>
	<58A20A281BAF1047B4EAE68DE5C0BDC201011622@zch01exm21.fsl.freescale.net>
Cc: Wood Scott <scottwood@freescale.com>,
	"linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 26, 2008, at 9:39 AM, Liu Dave wrote:

>>> Basic PM support for 83xx.  Standby is implemented as sleep.
>>> Suspend-to-RAM is implemented as "deep sleep" (with the processor
>>> turned off) on 831x.  PCI agent power management is supported.
>>>
>>> Device power management of SOC peripherals is not yet supported.
>>
>> (Not comments on this patch, but related)
>>
>> Do you know if anyone is looking at making sure DOZE/NAP work on
>> 83xx?  We clearly don't flush the L1 cache today in the 6xx code.
>
> I did the test on 837x, the NAP did *not* work, due to the cache
> coherence issue.
> You are right, currently no flush L1 in the 6xx code, maybe it  
> depend on
> the
> platform hardware capability.

Ben told me the pmac HW/chipsets did something here to ensure that the  
core never actually went into NAP (or something like that) so they  
didn't have to flush the caches.

- k
