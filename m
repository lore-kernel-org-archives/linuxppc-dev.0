Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E0DD81A05F8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Dec 2015 23:49:41 +1100 (AEDT)
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Petr Mladek <pmladek@suse.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Linux MIPS Mailing List <linux-mips@linux-mips.org>,
 Daniel Thompson <daniel.thompson@linaro.org>, Jiri Kosina <jkosina@suse.com>,
 Cris <linux-cris-kernel@axis.com>, linux-s390 <linux-s390@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 the arch/x86 maintainers <x86@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 "adi-buildroot-devel@lists.sourceforge.net"
 <adi-buildroot-devel@lists.sourceforge.net>, Ingo Molnar <mingo@redhat.com>,
 Linux-sh list <linux-sh@vger.kernel.org>,
 sparclinux <sparclinux@vger.kernel.org>,
 Russell King <rmk+kernel@arm.linux.org.uk>,
 Andrew Morton <akpm@linux-foundation.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3 4/4] printk/nmi: Increase the size of NMI buffer and
 make it configurable
Date: Fri, 11 Dec 2015 13:47:59 +0100
Message-ID: <10841284.ycX60MmRhF@wuerfel>
In-Reply-To: <20151211124159.GB3729@pathway.suse.cz>
References: <1449667265-17525-1-git-send-email-pmladek@suse.com>
 <CAMuHMdXVgr58YjoePGrRbMyMncQ27f85prL7G5SpeHeNxoYrXQ@mail.gmail.com>
 <20151211124159.GB3729@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Friday 11 December 2015 13:41:59 Petr Mladek wrote:
> diff --git a/init/Kconfig b/init/Kconfig
> index efcff25a112d..61cfd96a3c96 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -870,7 +870,7 @@ config NMI_LOG_BUF_SHIFT
>         int "Temporary per-CPU NMI log buffer size (12 => 4KB, 13 => 8KB)"
>         range 10 21
>         default 13
> -       depends on PRINTK && HAVE_NMI
> +       depends on PRINTK_NMI
>         help
>           Select the size of a per-CPU buffer where NMI messages are temporary
>           stored. They are copied to the main log buffer in a safe context
> 
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>

I found this on linux-next as well today and came to the same conclusion.

	Arnd
