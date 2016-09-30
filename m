Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3slxwB6jy4zDvKw
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Oct 2016 02:38:42 +1000 (AEST)
Subject: Re: [PATCH 0/2] powerpc: stack protector (-fstack-protector) support
To: Denis Kirjanov <kda@linux-powerpc.org>
References: <cover.1475181427.git.christophe.leroy@c-s.fr>
 <CAOJe8K2bYSGe5ciY75eSbthkXNtQwJ2LBdgWcyqqo_jwhmoUsg@mail.gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>, Nicolas Pitre <nicolas.pitre@linaro.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <75290c3d-e2e8-52fc-043f-dcec645095f8@c-s.fr>
Date: Fri, 30 Sep 2016 18:38:30 +0200
MIME-Version: 1.0
In-Reply-To: <CAOJe8K2bYSGe5ciY75eSbthkXNtQwJ2LBdgWcyqqo_jwhmoUsg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 30/09/2016 à 18:26, Denis Kirjanov a écrit :
>
>
> On Friday, September 30, 2016, Christophe Leroy <christophe.leroy@c-s.fr
> <mailto:christophe.leroy@c-s.fr>> wrote:
>
>     Add HAVE_CC_STACKPROTECTOR to powerpc. This is copied from ARM.
>
>     Not tested on PPC64, compile ok with ppc64_
>
>
> Hi Christophe,
>
> are you going to test it on ppc64? If not, I can take it

Thanks Denis, you are welcome to test it.

I don't have any ppc64 target, I only have mpc8xx and mpc83xx which both 
are ppc32

Christophe

>
>
>
>     Christophe Leroy (2):
>       powerpc: initial stack protector (-fstack-protector) support
>       powerpc/32: stack protector: change the canary value per task
>
>      arch/powerpc/Kconfig                      |  1 +
>      arch/powerpc/include/asm/stackprotector.h | 38
>     +++++++++++++++++++++++++++++++
>      arch/powerpc/kernel/Makefile              |  5 ++++
>      arch/powerpc/kernel/asm-offsets.c         |  3 +++
>      arch/powerpc/kernel/entry_32.S            |  6 ++++-
>      arch/powerpc/kernel/process.c             |  6 +++++
>      6 files changed, 58 insertions(+), 1 deletion(-)
>      create mode 100644 arch/powerpc/include/asm/stackprotector.h
>
>     --
>     2.1.0
>
