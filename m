Return-Path: <msalter@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 924212C0090
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Dec 2013 02:51:23 +1100 (EST)
Message-ID: <1387122626.1979.136.camel@deneb.redhat.com>
Subject: Re: [PATCH 10/10] Kconfig: cleanup SERIO_I8042 dependencies
From: Mark Salter <msalter@redhat.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Sun, 15 Dec 2013 10:50:26 -0500
In-Reply-To: <20131215103657.GB20197@core.coreip.homeip.net>
References: <1387040376-26906-1-git-send-email-msalter@redhat.com>
 <1387040376-26906-11-git-send-email-msalter@redhat.com>
 <52ACA43F.2040402@zytor.com>
 <20131215103657.GB20197@core.coreip.homeip.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
 linux-sh@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, Russell King <linux@arm.linux.org.uk>,
 x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
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

On Sun, 2013-12-15 at 02:36 -0800, Dmitry Torokhov wrote:
> On Sat, Dec 14, 2013 at 10:32:31AM -0800, H. Peter Anvin wrote:
> > On 12/14/2013 08:59 AM, Mark Salter wrote:
> > > Remove messy dependencies from SERIO_I8042 by having it depend on one
> > > Kconfig symbol (ARCH_MIGHT_HAVE_PC_SERIO) and having architectures
> > > which need it select ARCH_MIGHT_HAVE_PC_SERIO in arch/*/Kconfig.
> > > New architectures are unlikely to need SERIO_I8042, so this avoids
> > > having an ever growing list of architectures to exclude.

> How are we going to merge this? In bulk through input tree or peacemeal
> through all arches first?
> 

They should all go together to eliminate the chance of bisect breakage.
Either the input tree or maybe akpm tree.
