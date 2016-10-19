Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3szVhS0YMdzDt37
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Oct 2016 22:53:44 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>, monstr@monstr.eu,
 ralf@linux-mips.org, tglx@linutronix.de, jason@lakedaemon.net,
 marc.zyngier@arm.com, alistair@popple.id.au, mporter@kernel.crashing.org
Cc: soren.brinkmann@xilinx.com, linux-kernel@vger.kernel.org,
 linux-mips@linux-mips.org, michal.simek@xilinx.com,
 linuxppc-dev@lists.ozlabs.org, paulus@samba.org, benh@kernel.crashing.org
Subject: Re: [Patch v5 06/12] powerpc/virtex: Use generic xilinx irqchip driver
In-Reply-To: <1476723176-39891-7-git-send-email-Zubair.Kakakhel@imgtec.com>
References: <1476723176-39891-1-git-send-email-Zubair.Kakakhel@imgtec.com>
 <1476723176-39891-7-git-send-email-Zubair.Kakakhel@imgtec.com>
Date: Wed, 19 Oct 2016 22:53:43 +1100
Message-ID: <87funs4ks8.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com> writes:

> The Xilinx interrupt controller driver is now available in drivers/irqchip.
> Switch to using that driver.
>
> Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
>
> ---
> V5 New patch
>
> Tested on virtex440-ml507 using qemu

I don't have one of these to test on, and the patch looks sane, so
that's good enough for me.

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers
