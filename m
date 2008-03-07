Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 26353DDF73
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Mar 2008 02:00:42 +1100 (EST)
Message-Id: <77D7C44C-AB9F-4326-81DE-17BE6A74B421@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20080228185034.GA3897@loki.buserror.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH] fs_enet: Remove unused fields in the
	fs_mii_bb_platform_info structure.
Date: Fri, 7 Mar 2008 09:00:17 -0600
References: <200802151427.44321.laurentp@cse-semaphore.com>
	<200802281349.07501.laurentp@cse-semaphore.com>
	<20080228185034.GA3897@loki.buserror.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 28, 2008, at 12:50 PM, Scott Wood wrote:

> On Thu, Feb 28, 2008 at 01:49:01PM +0100, Laurent Pinchart wrote:
>> On Friday 15 February 2008 14:27, Laurent Pinchart wrote:
>>> The mdio_port, mdio_bit, mdc_port and mdc_bit fields in the
>>> fs_mii_bb_platform_info structure are left-overs from the move to  
>>> the Phy
>>> Abstraction Layer subsystem. They can be safely removed.
>>>
>>> Signed-off-by: Laurent Pinchart <laurentp@cse-semaphore.com>
>> [snip]
>>
>> Is there something wrong with the patch ?
>
> No, the patch looks OK.  However, note that non-PPC_CPM_NEW_BINDING  
> code
> should go away altogether soon.

also any such patch should normally go via netdev as its to a network  
driver.

- k
