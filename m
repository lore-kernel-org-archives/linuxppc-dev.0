Return-Path: <ralf@linux-mips.org>
Received: from git.linux-mips.org (marvin.linux-mips.org [78.24.191.183])
 by ozlabs.org (Postfix) with ESMTP id 96CEF2C00A6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Dec 2013 03:24:23 +1100 (EST)
Received: from localhost.localdomain ([127.0.0.1]:59003 "EHLO linux-mips.org"
 rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
 id S6867261Ab3LPQYS7XBUE (ORCPT
 <rfc822;linuxppc-dev@lists.ozlabs.org>);
 Mon, 16 Dec 2013 17:24:18 +0100
Date: Mon, 16 Dec 2013 17:23:47 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Mark Salter <msalter@redhat.com>
Subject: Re: [PATCH 10/10] Kconfig: cleanup SERIO_I8042 dependencies
Message-ID: <20131216162346.GA19285@linux-mips.org>
References: <1387040376-26906-1-git-send-email-msalter@redhat.com>
 <1387040376-26906-11-git-send-email-msalter@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1387040376-26906-11-git-send-email-msalter@redhat.com>
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
 linux-sh@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, Russell King <linux@arm.linux.org.uk>,
 x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
 Fenghua Yu <fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org, Richard Henderson <rth@twiddle.net>,
 Tony Luck <tony.luck@intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 linux-kernel@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>,
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

On Sat, Dec 14, 2013 at 11:59:36AM -0500, Mark Salter wrote:

> -	depends on !PARISC && (!ARM || FOOTBRIDGE_HOST) && \
> -		   (!SUPERH || SH_CAYMAN) && !M68K && !BLACKFIN && !S390 && \
> -		   !ARC
> +	depends on ARCH_MIGHT_HAVE_PC_SERIO

Most dependencies on an architecture's kconfig symbol outside arch/
should probably be treated as a bug.

Acked-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf
