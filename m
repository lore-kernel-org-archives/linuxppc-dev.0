Return-Path: <hpa@zytor.com>
Received: from mail.zytor.com (terminus.zytor.com [IPv6:2001:1868:205::10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4D1E32C007B
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Dec 2013 12:19:13 +1100 (EST)
Message-ID: <52ACA43F.2040402@zytor.com>
Date: Sat, 14 Dec 2013 10:32:31 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
To: Mark Salter <msalter@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/10] Kconfig: cleanup SERIO_I8042 dependencies
References: <1387040376-26906-1-git-send-email-msalter@redhat.com>
 <1387040376-26906-11-git-send-email-msalter@redhat.com>
In-Reply-To: <1387040376-26906-11-git-send-email-msalter@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Fenghua Yu <fenghua.yu@intel.com>, Tony Luck <tony.luck@intel.com>,
 Russell King <linux@arm.linux.org.uk>, linux-mips@linux-mips.org,
 linux-sh@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 x86@kernel.org, Ralf Baechle <ralf@linux-mips.org>,
 Ingo Molnar <mingo@redhat.com>, Paul Mundt <lethal@linux-sh.org>,
 Paul Mackerras <paulus@samba.org>, linux-alpha@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-ia64@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Guan Xuetao <gxt@mprc.pku.edu.cn>,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>,
 linux-arm-kernel@lists.infradead.org, Richard Henderson <rth@twiddle.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/14/2013 08:59 AM, Mark Salter wrote:
> Remove messy dependencies from SERIO_I8042 by having it depend on one
> Kconfig symbol (ARCH_MIGHT_HAVE_PC_SERIO) and having architectures
> which need it select ARCH_MIGHT_HAVE_PC_SERIO in arch/*/Kconfig.
> New architectures are unlikely to need SERIO_I8042, so this avoids
> having an ever growing list of architectures to exclude.
> 
> Signed-off-by: Mark Salter <msalter@redhat.com>
> CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> CC: Richard Henderson <rth@twiddle.net>
> CC: linux-alpha@vger.kernel.org
> CC: Russell King <linux@arm.linux.org.uk>
> CC: linux-arm-kernel@lists.infradead.org
> CC: Tony Luck <tony.luck@intel.com>
> CC: Fenghua Yu <fenghua.yu@intel.com>
> CC: linux-ia64@vger.kernel.org
> CC: Ralf Baechle <ralf@linux-mips.org>
> CC: linux-mips@linux-mips.org
> CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> CC: Paul Mackerras <paulus@samba.org>
> CC: linuxppc-dev@lists.ozlabs.org
> CC: Paul Mundt <lethal@linux-sh.org>
> CC: linux-sh@vger.kernel.org
> CC: "David S. Miller" <davem@davemloft.net>
> CC: sparclinux@vger.kernel.org
> CC: Guan Xuetao <gxt@mprc.pku.edu.cn>
> CC: Ingo Molnar <mingo@redhat.com>
> CC: Thomas Gleixner <tglx@linutronix.de>
> CC: "H. Peter Anvin" <hpa@zytor.com>
> CC: x86@kernel.org

Acked-by: H. Peter Anvin <hpa@linux.intel.com>
