Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8FAFEDE3B9
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Aug 2008 23:47:35 +1000 (EST)
Message-Id: <44E87CD5-FBF7-45D8-8700-6BD0CE4B41AC@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <20080806134128.GA9533@secretlab.ca>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: hang w/ppc6xx_defconfig related to 'simple-bus' compatible
Date: Wed, 6 Aug 2008 08:47:29 -0500
References: <F2163BC0-08A2-4C17-AAE7-C37BD0CA66EA@kernel.crashing.org>
	<20080806134128.GA9533@secretlab.ca>
Cc: ppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 6, 2008, at 8:41 AM, Grant Likely wrote:

> On Tue, Aug 05, 2008 at 08:21:31AM -0500, Kumar Gala wrote:
>> I'm trying to get the ppc6xx_defconfig booting on any 8641 (74xx/ 
>> e600)
>> system.  If I remove the 'simple-bus' compatible from the soc node in
>> the .dts it works.  Otherwise it hangs at but and looks to be  
>> crashed in
>> the serial driver due to accessing memory at 0.
>>
>> I've tried the same .dts (w/'simple-bus') using the
>> mpc8641_hpcn_defconfig and things work.
>
> The Xilinx folks hit something similar.

did they have a fix?

>  ns16550 nodes get matched if
> the parent claims simple-bus.  If extra stuff needs to be done to use
> that port, then bad things happen.

"extra stuff".. not sure what you mean.  I'm guessing you me other  
config for the port to work.  In my case that isn't the situation.

- k
