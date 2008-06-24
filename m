Return-Path: <jespern@axis.com>
Received: from miranda.se.axis.com (miranda.se.axis.com [193.13.178.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 17803DDF06
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jun 2008 18:40:55 +1000 (EST)
Date: Tue, 24 Jun 2008 10:15:39 +0200
From: Jesper Nilsson <jesper.nilsson@axis.com>
To: Adrian Bunk <bunk@kernel.org>
Subject: Re: [2.6 patch] asm/ptrace.h userspace headers cleanup
Message-ID: <20080624081539.GE5064@axis.com>
References: <20080623174809.GE4756@cs181140183.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080623174809.GE4756@cs181140183.pp.htv.fi>
Cc: "chris@zankel.net" <chris@zankel.net>, dev-etrax <dev-etrax@axis.com>,
	"ysato@users.sourceforge.jp" <ysato@users.sourceforge.jp>,
	"linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
	"linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
	"cooloney@kernel.org" <cooloney@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	"paulus@samba.org" <paulus@samba.org>, Roland McGrath <roland@redhat.com>,
	"gerg@uclinux.org" <gerg@uclinux.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"yasutake.koichi@jp.panasonic.com" <yasutake.koichi@jp.panasonic.com>,
	"rmk@arm.linux.org.uk" <rmk@arm.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

On Mon, Jun 23, 2008 at 07:48:09PM +0200, Adrian Bunk wrote:
> This patch contains the following cleanups for the asm/ptrace.h
> userspace headers:
> - include/asm-generic/Kbuild.asm already lists ptrace.h, remove
>   the superfluous listings in the Kbuild files of the following
>   architectures:
>   - cris
>   - frv
>   - powerpc
>   - x86
> - don't expose function prototypes and macros to userspace:
>   - arm
>   - blackfin
>   - cris
>   - mn10300
>   - parisc
> - remove #ifdef CONFIG_'s around #define's:
>   - blackfin
>   - m68knommu
> - sh: AFAIK __SH5__ should work in both kernel and userspace,
>       no need to leak CONFIG_SUPERH64 to userspace
> - xtensa: cosmetical change to remove empty
>             #ifndef __ASSEMBLY__ #else #endif
>           from the userspace headers
> 
> Signed-off-by: Adrian Bunk <bunk@kernel.org>

The CRIS parts look ok.

Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson@axis.com
