Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xNChK10JqzDr99
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Aug 2017 11:51:11 +1000 (AEST)
Message-ID: <1501722008.2664.19.camel@kernel.crashing.org>
Subject: Re: [PATCH 03/24] powerpc/6xx: Handle DABR match before calling
 do_page_fault
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com
Date: Thu, 03 Aug 2017 11:00:08 +1000
In-Reply-To: <87k22lqz9d.fsf@concordia.ellerman.id.au>
References: <20170719044946.22030-1-benh@kernel.crashing.org>
 <20170719044946.22030-3-benh@kernel.crashing.org>
 <87k22lqz9d.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-08-03 at 10:19 +1000, Michael Ellerman wrote:
>   arch/powerpc/kernel/entry_32.S:(.text+0x7ac): undefined reference to `do_break'
> 
> For now I've just wrapped the asm above in:
> 
> +#if !(defined(CONFIG_4xx) || defined(CONFIG_BOOKE) || defined(CONFIG_PPC_8xx))
> 
> But would be happy if there was something less gross.

#ifdef CONFIG_6xx...

Cheers,
Ben.
