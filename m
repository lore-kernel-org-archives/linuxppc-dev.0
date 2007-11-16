Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BB52EDDE36
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Nov 2007 08:35:50 +1100 (EST)
Message-Id: <82E3B600-771F-45ED-BF75-C1BC7C5057F7@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: benh@kernel.crashing.org
In-Reply-To: <1195247189.28865.174.camel@pasglop>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [POWERPC] [RFC] Fix 8xx tlbie definition
Date: Fri, 16 Nov 2007 15:29:30 -0600
References: <20071116112822.37a238c0@weaponx>
	<1195247189.28865.174.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Nov 16, 2007, at 3:06 PM, Benjamin Herrenschmidt wrote:

>
> On Fri, 2007-11-16 at 11:28 -0600, Josh Boyer wrote:
>> Git commit e701d269aa28996f3502780951fe1b12d5d66b49 introduced an  
>> incorrect
>> definition for _tlbie on PowerPC 8xx platforms.  Only the address  
>> should be
>> passed to the function.  This patch corrects the definition of  
>> _tlbie and the
>> related tlb flushing functions for 8xx.
>>
>> Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
>
> That conflicts with the patch I posted to fix it differently (I kept  
> the
> additional argument).
>
> Which one do we take ?

Let's make _tlbia/_tlbie consistent on all archs.

- k
