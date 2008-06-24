Return-Path: <chris@zankel.net>
Received: from atlanta.zankel.net (atlanta.zankel.net [69.61.78.146])
	by ozlabs.org (Postfix) with ESMTP id ADC49DDDF9
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jun 2008 18:34:52 +1000 (EST)
Message-ID: <4860AF80.5060809@zankel.net>
Date: Tue, 24 Jun 2008 01:25:36 -0700
From: Chris Zankel <chris@zankel.net>
MIME-Version: 1.0
To: Adrian Bunk <bunk@kernel.org>
Subject: Re: [2.6 patch] asm/ptrace.h userspace headers cleanup
References: <20080623174809.GE4756@cs181140183.pp.htv.fi>
In-Reply-To: <20080623174809.GE4756@cs181140183.pp.htv.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linux-mips@linux-mips.org, dev-etrax@axis.com, ysato@users.sourceforge.jp,
	linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
	cooloney@kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, paulus@samba.org,
	Roland McGrath <roland@redhat.com>, gerg@uclinux.org,
	Andrew Morton <akpm@linux-foundation.org>,
	yasutake.koichi@jp.panasonic.com, rmk@arm.linux.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Adrian Bunk wrote:
> This patch contains the following cleanups for the asm/ptrace.h 
> userspace headers:
> - xtensa: cosmetical change to remove empty
>             #ifndef __ASSEMBLY__ #else #endif
>           from the userspace headers
> 
> Signed-off-by: Adrian Bunk <bunk@kernel.org>

The Xtensa part also looks ok.

Acked-by: Chris Zankel <chris@zankel.net>


Regards,
-Chris
