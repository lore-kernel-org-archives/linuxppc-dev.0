Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6D05FDE737
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Apr 2008 01:58:50 +1000 (EST)
Message-Id: <0597EDA4-D948-42A5-890B-34F8585BC2DF@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20080411144620.GA2534@loki.buserror.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH] CPM: Always use new binding.
Date: Fri, 11 Apr 2008 10:58:13 -0500
References: <20080410204502.GB20197@loki.buserror.net>
	<E26DEDA5-96A7-40C1-A06A-5D8503453715@kernel.crashing.org>
	<20080411144620.GA2534@loki.buserror.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 11, 2008, at 9:46 AM, Scott Wood wrote:
> On Thu, Apr 10, 2008 at 06:44:24PM -0500, Kumar Gala wrote:
>>
>> On Apr 10, 2008, at 3:45 PM, Scott Wood wrote:
>>> The kconfig entry can go away once arch/ppc and references to the
>>> config in
>>> drivers are removed.
>>
>> just to be clear.  arch/powerpc will always just use the new  
>> binding and
>> arch/ppc uses the old (or has the option)?
>
> Yes, CONFIG_PPC_NEW_BINDING is effectively an alias for  
> CONFIG_PPC_MERGE
> after this patch (but I figure there's no point changing the drivers  
> to use
> the latter, just to make another change in a couple months when arch/ 
> ppc
> dies).

Ok (just wanted to make sure I was clear) and agreed on not wanting to  
change the drivers.

- k
