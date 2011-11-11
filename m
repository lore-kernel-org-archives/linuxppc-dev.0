Return-Path: <lethal@linux-sh.org>
Received: from linux-sh.org (linux-sh.org [111.68.239.195])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 057E2B6F90
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Nov 2011 13:27:20 +1100 (EST)
Date: Fri, 11 Nov 2011 11:02:20 +0900
From: Paul Mundt <lethal@linux-sh.org>
To: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 4/5] treewide: Convert uses of ATTRIB_NORETURN to
 __noreturn
Message-ID: <20111111020220.GA29807@linux-sh.org>
References: <cover.1320917551.git.joe@perches.com>
 <abb1d8b542872ef3bfd695e85d3b8a0fd70645b9.1320917558.git.joe@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <abb1d8b542872ef3bfd695e85d3b8a0fd70645b9.1320917558.git.joe@perches.com>
Cc: Andrew Morton <akpm@google.com>, Fenghua Yu <fenghua.yu@intel.com>,
 linux-m68k@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
 linux-ia64@vger.kernel.org, linux-mips@linux-mips.org,
 linux-sh@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
 linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
 David Howells <dhowells@redhat.com>, linux-am33-list@redhat.com,
 Geert Uytterhoeven <geert@linux-m68k.org>, Chris Metcalf <cmetcalf@tilera.com>,
 linux390@de.ibm.com, Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Paul Mackerras <paulus@samba.org>, linux-s390@vger.kernel.org,
 Koichi Yasutake <yasutake.koichi@jp.panasonic.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 10, 2011 at 01:41:45AM -0800, Joe Perches wrote:
> Use the more commonly used __noreturn instead of ATTRIB_NORETURN.
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  arch/ia64/kernel/machine_kexec.c       |    2 +-
>  arch/m68k/amiga/config.c               |    2 +-
>  arch/mips/include/asm/ptrace.h         |    2 +-
>  arch/mips/kernel/traps.c               |    2 +-
>  arch/mn10300/include/asm/exceptions.h  |    2 +-
>  arch/powerpc/kernel/machine_kexec_32.c |    2 +-
>  arch/powerpc/kernel/machine_kexec_64.c |    2 +-
>  arch/s390/include/asm/processor.h      |    2 +-
>  arch/sh/kernel/process_32.c            |    2 +-
>  arch/sh/kernel/process_64.c            |    2 +-
>  arch/tile/kernel/machine_kexec.c       |    2 +-
>  include/linux/kernel.h                 |    6 +++---
>  12 files changed, 14 insertions(+), 14 deletions(-)
> 
For the SH bits:

Signed-off-by: Paul Mundt <lethal@linux-sh.org>
