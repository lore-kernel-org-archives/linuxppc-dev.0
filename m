Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40xPxK3lmyzDr30
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 May 2018 21:14:29 +1000 (AEST)
Subject: Re: Build Failure on linux-next on Power8 machine
To: vrbagal1 <vrbagal1@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: sfr@canb.auug.org.au
References: <d377489b3333eca0951510c19b7d8878@linux.vnet.ibm.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <5abede57-06bd-bb3c-385e-11a61a380027@c-s.fr>
Date: Thu, 31 May 2018 13:14:23 +0200
MIME-Version: 1.0
In-Reply-To: <d377489b3333eca0951510c19b7d8878@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 31/05/2018 à 12:38, vrbagal1 a écrit :
> Greetings!!!
> 
> 
> I am observing a build failure on linux-next kernel.
> 
> Machine: Power8
> Platform: PowerNV(Baremetal)
> Git Tree: 
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

Which defconfig do you use, or can you give your .config ?

Christophe


> 
> Below is the build error.
> 
> 14:20:48 make[1]: *** [kernel/umh.o] Error 1
> 14:20:48 make[1]: *** [kernel/fork.o] Error 1
> 14:20:48 In file included from ./arch/powerpc/include/asm/highmem.h:30:0,
> 14:20:48                  from ./include/linux/highmem.h:35,
> 14:20:48                  from ./include/linux/pagemap.h:11,
> 14:20:48                  from security/commoncap.c:19:
> 14:20:48 ./arch/powerpc/include/asm/fixmap.h:52:2: error: overflow in 
> enumeration values
> 14:20:48   FIX_KMAP_BEGIN, /* reserved pte's for temporary kernel 
> mappings */
> 14:20:48   ^
> 14:20:48 make[2]: *** [kernel/sched/swait.o] Error 1
> 14:20:48 make[1]: *** [mm/page_alloc.o] Error 1
> 14:20:48 make[1]: *** [kernel/sched] Error 2
> 14:20:48 make: *** [mm] Error 2
> 14:20:48 make[1]: *** [kernel/exit.o] Error 1
> 14:20:48 make[1]: *** [security/commoncap.o] Error 1
> 14:20:48 make[1]: *** [fs/kernfs] Error 2
> 14:20:48 make: *** [fs] Error 2
> 14:20:48 make: *** [arch/powerpc/kernel] Error 2
> 14:20:48 make: *** [security] Error 2
> 14:20:48 make: *** [kernel] Error 2
> 
> Cheers.
