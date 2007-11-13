Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1B428DDE24
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Nov 2007 19:13:47 +1100 (EST)
In-Reply-To: <20071113080631.GA17756@lixom.net>
References: <20071113163427.2ab3fdb0.sfr@canb.auug.org.au>
	<20071113163707.cfefe98a.sfr@canb.auug.org.au>
	<20071113080631.GA17756@lixom.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <38D1B0C2-0CCE-4449-995C-536F168B2FE9@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 2/2] [POWERPC] consolidate struct pci_controller
Date: Tue, 13 Nov 2007 02:13:34 -0600
To: Olof Johansson <olof@lixom.net>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Nov 13, 2007, at 2:06 AM, Olof Johansson wrote:

> On Tue, Nov 13, 2007 at 04:37:07PM +1100, Stephen Rothwell wrote:
>
>> This one clashes slightly with Benh's "Merge  
>> pci_process_bridge_OF_ranges()"
>> patch.
>
> Hi Stephen,
>
> For the small fields that use standard types, you should just be able
> to still define them for ppc32 and just not use them. Alternatively,
> if the 32-bit guys complain about wasted bytes of memory, bunch up the
> ppc64-only fields together for a single ifdef.

I doubt we'll complain too much for a struct that might have one or  
two instances at most.

But I think the ifdef's might be useful to people to see what code  
still needs to get merged between ppc32 & ppc64.

- k
