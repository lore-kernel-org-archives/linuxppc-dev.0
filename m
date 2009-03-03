Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: powerpc allnoconfig 
In-reply-to: <20090302171948.d1e2aa00.akpm@linux-foundation.org> 
References: <20090302171948.d1e2aa00.akpm@linux-foundation.org>
Date: Tue, 03 Mar 2009 13:31:10 +1100
Message-ID: <12051.1236047470@neuling.org>
Sender: mikey@neuling.org
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> make mrproper
> make allnoconfig
> make vmlinux
> 
> gives:
> 
> scripts/kconfig/conf -s arch/powerpc/Kconfig
>   CHK     include/linux/version.h
>   UPD     include/linux/version.h
>   CHK     include/linux/utsrelease.h
>   UPD     include/linux/utsrelease.h
>   SYMLINK include/asm -> include/asm-powerpc
>   HOSTCC  scripts/ihex2fw
>   HOSTCC  scripts/kallsyms
>   HOSTCC  scripts/conmakehash
>   CC      scripts/mod/empty.o
>   HOSTCC  scripts/mod/mk_elfconfig
> scripts/mod/empty.c:1: error: -m64 requires a PowerPC64 cpu
> make[2]: *** [scripts/mod/empty.o] Error 1
> make[2]: *** Waiting for unfinished jobs....
> make[1]: *** [scripts/mod] Error 2
> make[1]: *** Waiting for unfinished jobs....
> make: *** [scripts] Error 2

I can't replicate this with Linus' latest tree with gcc 4.3 or 4.0.

What's your tool chain?  Does it compile 32 or 64bit by default?

Mikey
