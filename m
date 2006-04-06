Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17460.39696.910677.444426@cargo.ozlabs.ibm.com>
Date: Thu, 6 Apr 2006 14:37:36 +1000
From: Paul Mackerras <paulus@samba.org>
To: Olaf Hering <olh@suse.de>
Subject: Re: [PATCH] Set cpu explicitly in kernel compiles
In-Reply-To: <20060402194044.GA866@suse.de>
References: <17016.29775.224816.691409@cargo.ozlabs.ibm.com>
	<20060402194044.GA866@suse.de>
Cc: linuxppc-dev@ozlabs.org, trini@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olaf Hering writes:

> --- linux-2.6.16-olh.orig/arch/powerpc/Makefile
> +++ linux-2.6.16-olh/arch/powerpc/Makefile
> @@ -107,6 +107,7 @@ endif
>  cpu-as-$(CONFIG_PPC64BRIDGE)	+= -Wa,-mppc64bridge
>  cpu-as-$(CONFIG_4xx)		+= -Wa,-m405
>  cpu-as-$(CONFIG_6xx)		+= -Wa,-maltivec
> +cpu-as-$(CONFIG_6xx)		+= -mcpu=powerpc

Is this really the right place for this?  The cpu-as- thing is really
for assembler options.

Paul.
