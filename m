Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B8B30DE88A
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 03:44:27 +1100 (EST)
Message-Id: <576C56F1-E948-4004-B5AE-F70FDE0D871C@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20081010180512.GA3554@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH] powerpc/83xx: add NAND support for the MPC8360E-RDK boards
Date: Mon, 13 Oct 2008 11:44:22 -0500
References: <20081010180512.GA3554@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 10, 2008, at 1:05 PM, Anton Vorontsov wrote:

> The StMicro NAND chip (512Mbit, 64MB) is connected to the local bus,
> the first local bus' user-programmable machine is configured by the
> firmware to work with NAND chips.
>
> QE GPIO pin is used to poll the NAND's Ready-Not-Busy signal.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> arch/powerpc/boot/dts/mpc836x_rdk.dts |   12 ++++++++++++
> 1 files changed, 12 insertions(+), 0 deletions(-)


applied.

- k
