Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id D20F91007F3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jun 2012 08:10:52 +1000 (EST)
Message-ID: <1340748634.3732.27.camel@pasglop>
Subject: Re: [PATCH v6 1/5] powerpc/85xx: implement hardware timebase sync
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Zhao Chenhui <chenhui.zhao@freescale.com>
Date: Wed, 27 Jun 2012 08:10:34 +1000
In-Reply-To: <1340706359-9455-1-git-send-email-chenhui.zhao@freescale.com>
References: <1340706359-9455-1-git-send-email-chenhui.zhao@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2012-06-26 at 18:25 +0800, Zhao Chenhui wrote:
> Do hardware timebase sync. Firstly, stop all timebases, and transfer
> the timebase value of the boot core to the other core. Finally,
> start all timebases.
> 
> Only apply to dual-core chips, such as MPC8572, P2020, etc.
> 
> Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
> Changes for v6:
>  * added 85xx_TB_SYNC
>  * added isync() after set_tb()
>  * removed extra entries from mpc85xx_smp_guts_ids

What's that CONFIG option for ?

Cheers,
Ben.
