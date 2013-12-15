Return-Path: <dmitry.torokhov@gmail.com>
Received: from mail-pa0-x22c.google.com (mail-pa0-x22c.google.com
 [IPv6:2607:f8b0:400e:c03::22c])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 827222C009A
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Dec 2013 21:37:07 +1100 (EST)
Received: by mail-pa0-f44.google.com with SMTP id fa1so1759908pad.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Dec 2013 02:37:03 -0800 (PST)
Date: Sun, 15 Dec 2013 02:36:57 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 10/10] Kconfig: cleanup SERIO_I8042 dependencies
Message-ID: <20131215103657.GB20197@core.coreip.homeip.net>
References: <1387040376-26906-1-git-send-email-msalter@redhat.com>
 <1387040376-26906-11-git-send-email-msalter@redhat.com>
 <52ACA43F.2040402@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <52ACA43F.2040402@zytor.com>
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
 linux-sh@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 sparclinux@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>,
 Russell King <linux@arm.linux.org.uk>, x86@kernel.org,
 Ingo Molnar <mingo@redhat.com>, Mark Salter <msalter@redhat.com>,
 Fenghua Yu <fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org, Richard Henderson <rth@twiddle.net>,
 Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
 Ralf Baechle <ralf@linux-mips.org>, Paul Mundt <lethal@linux-sh.org>,
 linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Dec 14, 2013 at 10:32:31AM -0800, H. Peter Anvin wrote:
> On 12/14/2013 08:59 AM, Mark Salter wrote:
> > Remove messy dependencies from SERIO_I8042 by having it depend on one
> > Kconfig symbol (ARCH_MIGHT_HAVE_PC_SERIO) and having architectures
> > which need it select ARCH_MIGHT_HAVE_PC_SERIO in arch/*/Kconfig.
> > New architectures are unlikely to need SERIO_I8042, so this avoids
> > having an ever growing list of architectures to exclude.
> > 
> > Signed-off-by: Mark Salter <msalter@redhat.com>
> > CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > CC: Richard Henderson <rth@twiddle.net>
> > CC: linux-alpha@vger.kernel.org
> > CC: Russell King <linux@arm.linux.org.uk>
> > CC: linux-arm-kernel@lists.infradead.org
> > CC: Tony Luck <tony.luck@intel.com>
> > CC: Fenghua Yu <fenghua.yu@intel.com>
> > CC: linux-ia64@vger.kernel.org
> > CC: Ralf Baechle <ralf@linux-mips.org>
> > CC: linux-mips@linux-mips.org
> > CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > CC: Paul Mackerras <paulus@samba.org>
> > CC: linuxppc-dev@lists.ozlabs.org
> > CC: Paul Mundt <lethal@linux-sh.org>
> > CC: linux-sh@vger.kernel.org
> > CC: "David S. Miller" <davem@davemloft.net>
> > CC: sparclinux@vger.kernel.org
> > CC: Guan Xuetao <gxt@mprc.pku.edu.cn>
> > CC: Ingo Molnar <mingo@redhat.com>
> > CC: Thomas Gleixner <tglx@linutronix.de>
> > CC: "H. Peter Anvin" <hpa@zytor.com>
> > CC: x86@kernel.org
> 
> Acked-by: H. Peter Anvin <hpa@linux.intel.com>

How are we going to merge this? In bulk through input tree or peacemeal
through all arches first?

-- 
Dmitry
