Return-Path: <michael@ellerman.id.au>
Message-ID: <1340781550.309.5.camel@concordia>
Subject: Re: Build regressions/improvements in v3.5-rc4
From: Michael Ellerman <michael@ellerman.id.au>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 27 Jun 2012 17:19:10 +1000
In-Reply-To: <CAMuHMdXY1DFNV+jTiJkT99TbX7ZL5eEiKcG0iqZkUa8T7YZG4g@mail.gmail.com>
References: <1340740795-19603-1-git-send-email-geert@linux-m68k.org>
 <CAMuHMdXY1DFNV+jTiJkT99TbX7ZL5eEiKcG0iqZkUa8T7YZG4g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
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

On Tue, 2012-06-26 at 22:06 +0200, Geert Uytterhoeven wrote:
> On Tue, Jun 26, 2012 at 9:59 PM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > JFYI, when comparing v3.5-rc4 to v3.5-rc3[3], the summaries are:
> >  - build errors: +11/-219

> powerpc-randconfig
> 
>   + include/asm-generic/pgtable.h: error: implicit declaration of function 'BUG' [-Werror=implicit-function-declaration]:  => 56:2
>   + include/asm-generic/pgtable.h: error: implicit declaration of function 'BUG':  => 56
>   + include/linux/thread_info.h: error: implicit declaration of function 'WARN_ON':  => 129

Fixed by 09682c1dd3820445a27d32dcbeee6a6eafff3dc9 AFAICS.

cheers
