Return-Path: <James.Bottomley@HansenPartnership.com>
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com
 [66.63.167.143]) by ozlabs.org (Postfix) with ESMTP id AEDAB2C02AD
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Feb 2013 05:30:21 +1100 (EST)
Message-ID: <1360002617.2465.33.camel@dabdike>
Subject: Re: [PATCH RESEND 1/1] arch Kconfig: remove references to IRQ_PER_CPU
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: James Hogan <james.hogan@imgtec.com>
Date: Mon, 04 Feb 2013 10:30:17 -0800
In-Reply-To: <1359972583-17134-1-git-send-email-james.hogan@imgtec.com>
References: <1359972583-17134-1-git-send-email-james.hogan@imgtec.com>
Content-Type: text/plain; charset="ISO-8859-15"
Mime-Version: 1.0
Cc: linux-arch@vger.kernel.org, linux-mips@linux-mips.org,
 linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-hexagon@vger.kernel.org,
 Helge Deller <deller@gmx.de>, linux-kernel@vger.kernel.org,
 Fenghua Yu <fenghua.yu@intel.com>,
 "James E.J. Bottomley" <jejb@parisc-linux.org>,
 Paul Mundt <lethal@linux-sh.org>, Mike Frysinger <vapier@gentoo.org>,
 Ralf Baechle <ralf@linux-mips.org>, uclinux-dist-devel@blackfin.uclinux.org,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
 Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-02-04 at 10:09 +0000, James Hogan wrote:
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

For what it's worth ACK, but I don't really think you need it since the
patch is trivial and obviously correct.

> 
> Does anybody want to pick this patch up?

I see Thomas already has.  Thanks, by the way, for not doing this as one
patch per architecture ...

James
