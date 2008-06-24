Return-Path: <dhowells@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by ozlabs.org (Postfix) with ESMTP id 541CCDDEF1
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jun 2008 20:24:44 +1000 (EST)
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20080623174809.GE4756@cs181140183.pp.htv.fi>
References: <20080623174809.GE4756@cs181140183.pp.htv.fi>
To: Adrian Bunk <bunk@kernel.org>
Subject: Re: [2.6 patch] asm/ptrace.h userspace headers cleanup
Date: Tue, 24 Jun 2008 11:23:48 +0100
Message-ID: <8058.1214303028@redhat.com>
Sender: dhowells@redhat.com
Cc: chris@zankel.net, cooloney@kernel.org, ysato@users.sourceforge.jp,
	linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
	dev-etrax@axis.com, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	paulus@samba.org, Roland McGrath <roland@redhat.com>,
	gerg@uclinux.org, Andrew Morton <akpm@linux-foundation.org>,
	yasutake.koichi@jp.panasonic.com, rmk@arm.linux.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Adrian Bunk <bunk@kernel.org> wrote:

> This patch contains the following cleanups for the asm/ptrace.h 
> userspace headers:
> - include/asm-generic/Kbuild.asm already lists ptrace.h, remove
>   the superfluous listings in the Kbuild files of the following
>   architectures:
> ...
>   - frv
> ...
> - don't expose function prototypes and macros to userspace:
> ...
>   - mn10300

Acked-by: David Howells <dhowells@redhat.com> (FRV and MN10300)
