Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 94C9BDE26D
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Aug 2008 02:36:03 +1000 (EST)
Message-Id: <819647DB-0404-4B45-B844-66C4E9793014@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <fa686aa40808010930s286381c7ub354b9b98a40c07d@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCH] powerpc: Remove use of CONFIG_PPC_MERGE
Date: Fri, 1 Aug 2008 11:35:58 -0500
References: <Pine.LNX.4.64.0808011050370.2074@blarg.am.freescale.net>
	<fa686aa40808010930s286381c7ub354b9b98a40c07d@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 1, 2008, at 11:30 AM, Grant Likely wrote:

> On Fri, Aug 1, 2008 at 9:50 AM, Kumar Gala  
> <galak@kernel.crashing.org> wrote:
>> Now that arch/ppc is gone we don't need CONFIG_PPC_MERGE anymore
>> remove the dead code associated with !CONFIG_PPC_MERGE out of arch/ 
>> powerpc
>> and include/asm-powerpc.
>>
>> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
>
> You need to remove references to it from drivers also

Old your horses (or should I say kilt).. patches are coming :)

- k
