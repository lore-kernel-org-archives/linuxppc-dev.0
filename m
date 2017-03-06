Return-Path: <linux+linuxppc-dev=lists.ozlabs.org@armlinux.org.uk>
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk
 [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vcT8B21g9zDqFh
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Mar 2017 05:38:50 +1100 (AEDT)
Date: Mon, 6 Mar 2017 18:38:16 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: catalin.marinas@arm.com, will.deacon@arm.com, mingo@kernel.org,
 mpe@ellerman.id.au, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 mhiramat@kernel.org, ananth@linux.vnet.ibm.com
Subject: Re: [PATCH 2/3] arm: kprobes: remove kprobe_exceptions_notify
Message-ID: <20170306183815.GX21222@n2100.armlinux.org.uk>
References: <b0894e503195b13a5ed6319e897e673f376a748d.1486496890.git.naveen.n.rao@linux.vnet.ibm.com>
 <46a640f65b86650d3a7d64a577dd441838de1c20.1486496890.git.naveen.n.rao@linux.vnet.ibm.com>
 <20170306180720.GC7467@naverao1-tp.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170306180720.GC7467@naverao1-tp.localdomain>
Sender: Russell King - ARM Linux <linux@armlinux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Mar 06, 2017 at 11:37:20PM +0530, Naveen N. Rao wrote:
> On 2017/02/08 01:24AM, Naveen N Rao wrote:
> > ... as the weak variant will do.
> > 
> > Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> > ---
> >  arch/arm/probes/kprobes/core.c     | 10 ----------
> >  arch/arm64/kernel/probes/kprobes.c |  6 ------
> >  2 files changed, 16 deletions(-)
> 
> With the generic changes in this series now in -rc1, can you please pick 
> this up?

It would've been nice to have been in the To: or Cc: on this patch,
I suspect everyone on the ARM side ignored this series (I certainly
didn't notice it, and I suspect the ARM64 folk didn't notice it for
exactly the same reason.)

In any case, this patch needs to be split - ARM and ARM64 are
maintained separately (as stated in MAINTAINERS), and patches go via
different trees.  Please resubmit with the patch split between the
architectures and proper recipients in the headers.

Thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
