Return-Path: <marc.zyngier@arm.com>
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 3tNMnW6JJMzDsxY
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 21:55:27 +1100 (AEDT)
Subject: Re: [Patch v7 0/7] microblaze/PowerPC: Move irq-xilinx to irqchip
To: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>, monstr@monstr.eu,
 tglx@linutronix.de, jason@lakedaemon.net
References: <20161114121351.10924-1-Zubair.Kakakhel@imgtec.com>
Cc: linux-kernel@vger.kernel.org, michal.simek@xilinx.com,
 linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
From: Marc Zyngier <marc.zyngier@arm.com>
Message-ID: <981aad31-906e-090a-de4e-1b601db3703c@arm.com>
Date: Tue, 22 Nov 2016 10:55:21 +0000
MIME-Version: 1.0
In-Reply-To: <20161114121351.10924-1-Zubair.Kakakhel@imgtec.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 14/11/16 12:13, Zubair Lutfullah Kakakhel wrote:
> Hi,
> 
> This patch series moves the Xilinx interrupt controller driver out
> of arch/microblaze to drivers/irqchip and then cleans it up a bit.
> And then removes another implementation of the driver in arch/powerpc.
> 
> This effort results in one common driver usable by mips,microblaze
> and powerpc.
> 
> Compile tested on microblaze-el.
> Tested using qemu-system-ppc using virtix440-ml507
> Tested on MIPSfpga platform.
> 
> Based on v4.9-rc5

I've queued this for 4.10 with Michal's Acks and TBs.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
