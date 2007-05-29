Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 0A927DE062
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 May 2007 00:39:30 +1000 (EST)
Message-ID: <465C3B7E.1000209@ru.mvista.com>
Date: Tue, 29 May 2007 18:41:02 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Pradyumna Sampath <pradyumna.sampath@gmail.com>
Subject: Re: [PATCH] Powerpc compiler error fix for 2.6.21-rt8
References: <f87351060705282124q6d6b1562ic1dd4da4b8a62886@mail.gmail.com>
In-Reply-To: <f87351060705282124q6d6b1562ic1dd4da4b8a62886@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linux-rt-users@vger.kernel.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello.

Pradyumna Sampath wrote:

> Attached is a small patch to fix compile time errors which is broken
> in 2.6.21-rt8 for powerpc.

    NAK. It's been deleted on purpose (not used anymore), and I've already 
sent a patch to kill the leftover reference.

> ------------------------------------------------------------------------
> 
> diff -ur latest/linux-2.6.21/arch/powerpc/kernel/time.c linux-2.6.21/arch/powerpc/kernel/time.c
> --- latest/linux-2.6.21/arch/powerpc/kernel/time.c	2007-05-29 09:58:12.000000000 +0530
> +++ linux-2.6.21/arch/powerpc/kernel/time.c	2007-05-29 08:58:56.000000000 +0530
> @@ -95,6 +95,8 @@
>  #define SCALE_XSEC(xsec, max)	mulhwu((xsec) << 12, max)
>  #endif
>  
> +unsigned long cpu_khz;  /* Detected as we calibrate the TSC */
> +EXPORT_SYMBOL(cpu_khz);
>  unsigned long tb_ticks_per_jiffy;
>  unsigned long tb_ticks_per_usec = 100; /* sane default */
>  EXPORT_SYMBOL(tb_ticks_per_usec);
> Only in linux-2.6.21/arch/powerpc/kernel: vmlinux.lds
> Only in linux-2.6.21/scripts/kconfig: mconf

    Please cut off such garbage from yoour patches...

WBR, Sergei
