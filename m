Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D3551DE076
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jan 2009 02:10:01 +1100 (EST)
Message-Id: <C37C3C8D-0DAA-4174-9A19-E2983CD32380@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Li Yang <leoli@freescale.com>
In-Reply-To: <3A45394FD742FA419B760BB8D398F9ED13DD10@zch01exm26.fsl.freescale.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH] powerpc/83xx: Make serial ports work on MPC8315E-RDB
	w/FSL U-Boots
Date: Mon, 12 Jan 2009 09:07:48 -0600
References: <20090111153013.GA31791@oksana.dev.rtsoft.ru>
	<3A45394FD742FA419B760BB8D398F9ED13DD10@zch01exm26.fsl.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 12, 2009, at 1:55 AM, Li Yang wrote:

>> -----Original Message-----
>> From: linuxppc-dev-bounces+leoli=freescale.com@ozlabs.org
>> [mailto:linuxppc-dev-bounces+leoli=freescale.com@ozlabs.org]
>> On Behalf Of Anton Vorontsov
>> Sent: Sunday, January 11, 2009 11:30 PM
>> To: Kumar Gala
>> Cc: linuxppc-dev@ozlabs.org
>> Subject: [PATCH] powerpc/83xx: Make serial ports work on
>> MPC8315E-RDB w/FSL U-Boots
>>
>> FSL U-Boots use /soc8315@e0000000 node to search and fixup
>> serial nodes' clock-frequency properties. Though in upstream
>> kernels we use new naming convention -- for IMMR address
>> space dts files specify /immr@e0000000 nodes.
>>
>> This makes FSL U-Boots fail to fixup the clock frequencies,
>> and that leads to serial ports misbehaviour. We can
>> workaround the issue by filling the clock frequency values manually.
>
> Freescale BSP is for customer who needs the out-of-box experience.   
> It's
> better tested, but doesn't update very frequently.  I would suggest  
> the
> customer to use the upstream u-boot, if they decide to use latest
> upstream kernel.
>
> - Leo

Agreed.  However I don't think there is any harm w/the patch as  
upstream u-boot will update the property.

- k
