Return-Path: <jiang.liu@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by lists.ozlabs.org (Postfix) with ESMTP id 0AC691A0244
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Dec 2014 18:57:03 +1100 (AEDT)
Message-ID: <5499204B.4040808@linux.intel.com>
Date: Tue, 23 Dec 2014 15:56:59 +0800
From: Jiang Liu <jiang.liu@linux.intel.com>
MIME-Version: 1.0
To: Tudor Laurentiu <b10716@freescale.com>,
 Thomas Gleixner <tglx@linutronix.de>, Scott Wood <scottwood@freescale.com>
Subject: Ask help about killing irqchip.irq_print_chip on PPC platforms
References: <54991DE5.5090805@linux.intel.com>
In-Reply-To: <54991DE5.5090805@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@lists.ozlabs.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Scott and Tudor,
	Sorry, resend and Ccing the list.
	We are trying to clean up some irqchip interfaces, and
irqchip.irq_print_chip is a candidate for removal. After some
changes on x86 side, arch/powerpc/sysdev/fsl_msi.c may be the
last user of irqchip.irq_print_chip. So could you please help
to advice on whether we could kill irqchip.irq_print_chip
by using "fsl-msi" instead of "fsl-msi-%d" for irqchip name?
Will it break any userspace interfaces?
Thanks!
Gerry
