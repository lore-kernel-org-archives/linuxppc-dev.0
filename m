Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 61B2EDE217
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Feb 2007 04:26:41 +1100 (EST)
Message-ID: <45CCAECB.7030207@freescale.com>
Date: Fri, 09 Feb 2007 11:26:35 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Dan Malek <dan@embeddedalley.com>
Subject: Re: [PATCH 1/4] ucc_geth: Change private immrbar_virt_to_phys to
	generic iopa
References: <989B956029373F45A0B8AF02970818900D4401@zch01exm26.fsl.freescale.net>
	<17A046C6-5FD3-46D5-AB96-EAEDF22FA829@kernel.crashing.org>
	<45CB270C.5090603@freescale.com>
	<6BD63E47-4738-4116-8A85-983D4FDCFBB9@embeddedalley.com>
In-Reply-To: <6BD63E47-4738-4116-8A85-983D4FDCFBB9@embeddedalley.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: netdev@vger.kernel.org, linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dan Malek wrote:
> 
> On Feb 8, 2007, at 8:35 AM, Timur Tabi wrote:
> 
>> That's what the original code did, kinda.  It called virt_to_phys() if
>> it is main memory, and it called immrbar_virt_to_phys() if it is MURAM.
>>   immrbar_virt_to_phys() did pointer math to extract the physical 
>> address.
> 
> You've got to be kidding.  You created yet another function
> to determine the physical address from a virtual one! LOL!
> Plus, you need logic in the code to first determine which
> one to call?  Everyone is OK with this?

The whole point behind the patch that we posted a couple days ago is to get rid 
of this function.  The patch replaced it with a call to iopa(), but Kumar nack'd 
that.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
