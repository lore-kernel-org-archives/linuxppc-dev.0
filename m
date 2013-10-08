Return-Path: <ralf@linux-mips.org>
Received: from git.linux-mips.org (marvin.linux-mips.org [78.24.191.183])
 by ozlabs.org (Postfix) with ESMTP id 5619A2C00AB
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Oct 2013 18:01:32 +1100 (EST)
Received: from localhost.localdomain ([127.0.0.1]:37660 "EHLO linux-mips.org"
 rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
 id S6868752Ab3JHHB34zpMP (ORCPT
 <rfc822;linuxppc-dev@lists.ozlabs.org>);
 Tue, 8 Oct 2013 09:01:29 +0200
Date: Tue, 8 Oct 2013 09:00:54 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Mark Salter <msalter@redhat.com>
Subject: Re: [PATCH v2 14/14] Kconfig cleanup (PARPORT_PC dependencies)
Message-ID: <20131008070054.GE1615@linux-mips.org>
References: <1381209030-351-1-git-send-email-msalter@redhat.com>
 <1381209030-351-15-git-send-email-msalter@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381209030-351-15-git-send-email-msalter@redhat.com>
Cc: linux-mips@linux-mips.org, linux-m68k@vger.kernel.org,
 linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,
 sparclinux@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>,
 Russell King <linux@arm.linux.org.uk>, Helge Deller <deller@gmx.de>,
 x86@kernel.org, "James E.J. Bottomley" <jejb@parisc-linux.org>,
 Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Fenghua Yu <fenghua.yu@intel.com>, microblaze-uclinux@itee.uq.edu.au,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Richard Henderson <rth@twiddle.net>, Michal Simek <monstr@monstr.eu>,
 Tony Luck <tony.luck@intel.com>, linux-parisc@vger.kernel.org,
 Vineet Gupta <vgupta@synopsys.com>, linux-kernel@vger.kernel.org,
 Paul Mundt <lethal@linux-sh.org>, linux-alpha@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Oct 08, 2013 at 01:10:30AM -0400, Mark Salter wrote:

> Remove messy dependencies from PARPORT_PC by having it depend on one
> Kconfig symbol (ARCH_MAY_HAVE_PC_PARPORT) and having architectures
> which need it, select ARCH_MAY_HAVE_PC_PARPORT in arch/*/Kconfig.
> New architectures are unlikely to need PARPORT_PC, so this avoids
> having an ever growing list of architectures to exclude. Those
> architectures which do select ARCH_MAY_HAVE_PC_PARPORT in this
> patch are the ones which have an asm/parport.h (or use the generic
> version).

Acked-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf
