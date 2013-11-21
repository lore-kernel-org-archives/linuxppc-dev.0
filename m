Return-Path: <thomas.petazzoni@free-electrons.com>
Received: from mail.free-electrons.com (top.free-electrons.com [176.31.233.9])
 by ozlabs.org (Postfix) with ESMTP id 24BDB2C0094
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Nov 2013 06:17:20 +1100 (EST)
Date: Thu, 21 Nov 2013 20:08:04 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 24/34] PCI: use weak functions for MSI arch-specific
 functions
Message-ID: <20131121200804.617d6ae6@skate>
In-Reply-To: <20131121173933.GT10382@linux-mips.org>
References: <1384915853-31006-1-git-send-email-r65037@freescale.com>
 <1384915853-31006-24-git-send-email-r65037@freescale.com>
 <20131121173933.GT10382@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Richard Zhu <r65037@freescale.com>, linux-s390@vger.kernel.org,
 linux-ia64@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
 Russell King <linux@arm.linux.org.uk>, Jason Cooper <jason@lakedaemon.net>,
 Fenghua Yu <fenghua.yu@intel.com>, linux-mips@linux-mips.org, x86@kernel.org,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Chris Metcalf <cmetcalf@tilera.com>, sparclinux@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>,
 linux390@de.ibm.com, Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear Ralf Baechle,

On Thu, 21 Nov 2013 18:39:33 +0100, Ralf Baechle wrote:
> On Wed, Nov 20, 2013 at 10:50:43AM +0800, Richard Zhu wrote:
> 
> Looking good,
> 
> Acked-by: Ralf Baechle <ralf@linux-mips.org>

I think this patch was mistakenly sent by Richard Zhu. It is already
part of mainline since 3.12:
http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/pci/msi.c?id=4287d824f265451cd10f6d20266b27a207a6cdd7.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
