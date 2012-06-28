Return-Path: <lethal@linux-sh.org>
Received: from linux-sh.org (linux-sh.org [111.68.239.195])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id AB8DDB6FA7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jun 2012 19:13:06 +1000 (EST)
Date: Thu, 28 Jun 2012 17:20:10 +0900
From: Paul Mundt <lethal@linux-sh.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Build regressions/improvements in v3.5-rc4
Message-ID: <20120628082009.GC21764@linux-sh.org>
References: <1340740795-19603-1-git-send-email-geert@linux-m68k.org>
 <CAMuHMdXY1DFNV+jTiJkT99TbX7ZL5eEiKcG0iqZkUa8T7YZG4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAMuHMdXY1DFNV+jTiJkT99TbX7ZL5eEiKcG0iqZkUa8T7YZG4g@mail.gmail.com>
Cc: the arch/x86 maintainers <x86@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 26, 2012 at 10:06:27PM +0200, Geert Uytterhoeven wrote:
> On Tue, Jun 26, 2012 at 9:59 PM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > JFYI, when comparing v3.5-rc4 to v3.5-rc3[3], the summaries are:
> > ??- build errors: +11/-219
> 
> 11 regressions:
>   + arch/sh/include/asm/fixmap.h: error: implicit declaration of
> function 'BUG_ON' [-Werror=implicit-function-declaration]:  => 133:2
>   + arch/sh/include/asm/thread_info.h: error: implicit declaration of
> function 'WARN_ON' [-Werror=implicit-function-declaration]:  => 172:2
>   + include/linux/huge_mm.h: error: implicit declaration of function
> 'BUG' [-Werror=implicit-function-declaration]:  => 185:2
> 
> shmin_defconfig, se7712_defconfig, se7721_defconfig, sh-allnoconfig
> 
I'm unable to reproduce any of these, is there some specific compiler
version or warning flag configuration I'm supposed to be using? I'm
building with 4.5.1 at the moment.
