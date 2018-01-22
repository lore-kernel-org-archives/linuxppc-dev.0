Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zPxqm0FmCzF0X7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jan 2018 14:34:12 +1100 (AEDT)
In-Reply-To: <20171117185859.2756-1-gpiccoli@linux.vnet.ibm.com>
To: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: paulus@samba.org, gpiccoli@linux.vnet.ibm.com
Subject: Re: [v3] powerpc/powernv: Add ppc_pci_reset_phbs parameter to issue a
 PHB reset
Message-Id: <3zPxqk6GsHz9sCZ@ozlabs.org>
Date: Mon, 22 Jan 2018 14:34:10 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-11-17 at 18:58:59 UTC, "Guilherme G. Piccoli" wrote:
> During a kdump kernel boot in PowerPC, we request a reset of the PHBs
> to the FW. It makes sense, since if we are booting a kdump kernel it
> means we had some trouble before and we cannot rely in the adapters'
> health; they could be in a bad state, hence the reset is needed.
> 
> But this reset is useful not only in kdump - there are situations,
> specially when debugging drivers, that we could break an adapter in
> a way it requires such reset. One can tell to just go ahead and
> reboot the machine, but happens that many times doing kexec is much
> faster, and so preferable than a full power cycle.
> 
> This patch adds the ppc_pci_reset_phbs parameter to perform such reset.
> 
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/45baee1416a0086dccaa8a94c70e67

cheers
