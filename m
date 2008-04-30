Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4088ADDF3C
	for <linuxppc-dev@ozlabs.org>; Thu,  1 May 2008 07:49:32 +1000 (EST)
Message-Id: <6B69C9AE-ABEE-4E2A-8B6B-554B2008B97F@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: benh@kernel.crashing.org
In-Reply-To: <1209591811.18023.234.camel@pasglop>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH] [POWERPC] Set lower flag bits in regs->trap to indicate
	debug level exception
Date: Wed, 30 Apr 2008 16:49:21 -0500
References: <Pine.LNX.4.64.0804300544370.7714@blarg.am.freescale.net>
	<1209591811.18023.234.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 30, 2008, at 4:43 PM, Benjamin Herrenschmidt wrote:
>
> On Wed, 2008-04-30 at 05:44 -0500, Kumar Gala wrote:
>> We use the low bits of regs->trap as flag bits.  We already indicate
>> critical and machine check level exceptions via this mechanism.   
>> Extend it
>> to indicate debug level exceptions.
>>
>> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
>
> Ack.

that was the easy one :)

- k
