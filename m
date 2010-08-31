Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DAB8CB7104
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  1 Sep 2010 02:17:28 +1000 (EST)
Subject: Re: [PATCH] powerpc: mtmsrd not defined
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20100822184844.37c30d5e@lappy.seanm.ca>
Date: Tue, 31 Aug 2010 11:17:17 -0500
Message-Id: <D9007E15-F764-450D-9B20-6506F0051BA7@kernel.crashing.org>
References: <20100822180958.6305f5b1@lappy.seanm.ca>
	<1282516494.22370.440.camel@pasglop>
	<20100822184844.37c30d5e@lappy.seanm.ca>
To: Sean MacLennan <smaclennan@pikatech.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 22, 2010, at 5:48 PM, Sean MacLennan wrote:

> On Mon, 23 Aug 2010 08:34:54 +1000
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
>> I'd rather have a macro somewhere in ppc_asm.h (MTMSR ?) that does the
>> right thing. We might even already have one...
> 
> We do.... here is a new, improved patch.
> 
> Replace the BOOK3S_64 specific mtmsrd with the generic MTMSRD macro.
> 
> Signed-off-by: Sean MacLennan <smaclennan@pikatech.com>
> ---

Can we add proper CONFIG_PPC_FPU into this file.

- k
