Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 284C2DDE08
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jun 2008 14:13:32 +1000 (EST)
Message-Id: <C780D687-D505-4A01-BED8-9866F4D0160A@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18521.37627.275223.34489@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [PATCH 5/9] powerpc: Introduce VSX thread_struct and CONFIG_VSX
Date: Wed, 18 Jun 2008 23:13:20 -0500
References: <20080618004734.0B72E70296@localhost.localdomain>
	<7B118E94-F308-4768-8ED6-BD66C5C3D3CA@kernel.crashing.org>
	<18521.37627.275223.34489@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Michael Neuling <mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 18, 2008, at 5:58 PM, Paul Mackerras wrote:

> Kumar Gala writes:
>
>> Is VSX mutually exclusive with altivec/fp?  is there a MSR bit for  
>> it?
>
> It's not exclusive, it's an extension of altivec/fp, and yes it has
> its own MSR bit to enable it.

what MSR bit does it use... I'm not seeing the code add or test a new  
MSR bit anywhere.

What exactly do you mean by its an extension of altivec/fp?  Are the  
instructions considered part of altivec/fp or is it just reusing the  
register storage like SPE?

- k
