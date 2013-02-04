Return-Path: <lethal@linux-sh.org>
Received: from linux-sh.org (linux-sh.org [111.68.239.195])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id CE64B2C02AD
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Feb 2013 23:12:26 +1100 (EST)
Date: Mon, 4 Feb 2013 20:30:44 +0900
From: Paul Mundt <lethal@linux-sh.org>
To: James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH RESEND 1/1] arch Kconfig: remove references to IRQ_PER_CPU
Message-ID: <20130204113043.GB12216@linux-sh.org>
References: <1359972583-17134-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1359972583-17134-1-git-send-email-james.hogan@imgtec.com>
Cc: linux-arch@vger.kernel.org, linux-mips@linux-mips.org,
 linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-hexagon@vger.kernel.org,
 Helge Deller <deller@gmx.de>, linux-kernel@vger.kernel.org,
 Fenghua Yu <fenghua.yu@intel.com>,
 "James E.J. Bottomley" <jejb@parisc-linux.org>,
 Mike Frysinger <vapier@gentoo.org>, Ralf Baechle <ralf@linux-mips.org>,
 uclinux-dist-devel@blackfin.uclinux.org, Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 04, 2013 at 10:09:43AM +0000, James Hogan wrote:
> The IRQ_PER_CPU Kconfig symbol was removed in the following commit:
> 
> Commit 6a58fb3bad099076f36f0f30f44507bc3275cdb6 ("genirq: Remove
> CONFIG_IRQ_PER_CPU") merged in v2.6.39-rc1.
> 
> But IRQ_PER_CPU wasn't removed from any of the architecture Kconfig
> files where it was defined or selected. It's completely unused so remove
> the remaining references.
> 
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Mike Frysinger <vapier@gentoo.org>
> Cc: Fenghua Yu <fenghua.yu@intel.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: "James E.J. Bottomley" <jejb@parisc-linux.org>
> Cc: Helge Deller <deller@gmx.de>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Paul Mundt <lethal@linux-sh.org>
> Acked-by: Tony Luck <tony.luck@intel.com>
> Acked-by: Richard Kuo <rkuo@codeaurora.org>

Acked-by: Paul Mundt <lethal@linux-sh.org>
