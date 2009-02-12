Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5D574DDDEE
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Feb 2009 06:21:30 +1100 (EST)
Message-Id: <4B32B56D-9BCC-4ABA-A2AD-BCACFB30D18F@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1234311976-22026-1-git-send-email-galak@kernel.crashing.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH v2] powerpc/fsl-booke: Add new ISA 2.06 page sizes and MAS
	defines
Date: Thu, 12 Feb 2009 13:21:24 -0600
References: <1234311976-22026-1-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 10, 2009, at 6:26 PM, Kumar Gala wrote:

> The Power ISA 2.06 added power of two page sizes to the embedded MMU
> architecture.  Its done it such a way to be code compatiable with the
> existing HW.  Made the minor code changes to support both power of two
> and power of four page sizes.  Also added some new MAS bits and macros
> that are defined as part of the 2.06 ISA.
>
> Note, its still invalid to try and use a page size that isn't  
> supported
> by cpu.
>
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
> * Fixed MAS6_ISIZE macro
>
> arch/powerpc/include/asm/mmu-fsl-booke.h |   54 +++++++++++++++++++ 
> +----------

Do you want to rename asm/mmu-fsl-booke.h => mmu-booke.h (per ISA 2.06  
changes)?

- k
