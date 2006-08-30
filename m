Return-Path: <dhowells@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by ozlabs.org (Postfix) with ESMTP id 970A367B6C
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Aug 2006 19:10:18 +1000 (EST)
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060828085244.GA13544@flint.arm.linux.org.uk> 
References: <20060828085244.GA13544@flint.arm.linux.org.uk> 
To: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [CFT:PATCH] Removing possible wrong asm/serial.h inclusions 
Date: Wed, 30 Aug 2006 10:09:54 +0100
Message-ID: <20539.1156928994@warthog.cambridge.redhat.com>
Sender: dhowells@redhat.com
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
	takata@linux-m32r.org, linux-kernel@vger.kernel.org,
	paulkf@microgate.com, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Russell King <rmk+lkml@arm.linux.org.uk> wrote:

> --- a/arch/frv/kernel/setup.c
> +++ b/arch/frv/kernel/setup.c
> @@ -31,7 +31,6 @@
>  #include <linux/serial_reg.h>
>  
>  #include <asm/setup.h>
> -#include <asm/serial.h>
>  #include <asm/irq.h>
>  #include <asm/sections.h>
>  #include <asm/pgalloc.h>

Acked-By: David Howells <dhowells@redhat.com>
