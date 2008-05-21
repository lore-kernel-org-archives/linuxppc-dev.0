Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 900C4DDF37
	for <linuxppc-dev@ozlabs.org>; Wed, 21 May 2008 13:11:17 +1000 (EST)
Message-Id: <BEDAF2CE-73A5-4FE4-848B-936B7D675131@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Andrew Liu <shengping.liu@windriver.com>
In-Reply-To: <48337D1C.2070108@windriver.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH] [POWERPC] Uniformly use memstart_addr variable as the
	start address of physical memory in powerpc branch
Date: Tue, 20 May 2008 22:11:10 -0500
References: <48337D1C.2070108@windriver.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 20, 2008, at 8:38 PM, Andrew Liu wrote:

> [POWERPC]: Uniformly use memstart_addr as the start address of RAM
>
> The variable: memstart_addr whose initial value is got from dts file
> is used as the start address of physical memory in PowerPC ARCH,
> although it is used in functions: mapin_ram(pgtable_32.c) and
> cam_mapin_ram(fsl_booke_mmu.c), however, in function: mmu_mapin_ram
> (ppc_mmu_32.c), use 0 as the start address of physical memory, so
> it is necessary to unify them: in mmu_mapin_ram, use memstart_addr
> as the start address of physical memory, instead of 0.
>
> Signed-off-by: Andrew Liu <shengping.liu@windriver.com>
> ---

Do you have a case where this is non-zero for ppc_mmu_32?  I left  
these alone because I wasn't aware of one (or if its reasonable).

- k
