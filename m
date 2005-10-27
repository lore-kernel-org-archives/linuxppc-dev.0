Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17248.45467.698310.551177@cargo.ozlabs.ibm.com>
Date: Thu, 27 Oct 2005 20:53:15 +1000
From: Paul Mackerras <paulus@samba.org>
To: Kumar Gala <galak@freescale.com>
In-Reply-To: <Pine.LNX.4.61.0510260956110.6094@linen.am.freescale.net>
References: <Pine.LNX.4.61.0510260956110.6094@linen.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org, linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: Re: [PATCH] powerpc: only build idle_6xx for 6xx
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala writes:

> For the current time idle_6xx only applies to 6xx ppc32 CPUs

> +extra-$(CONFIG_6xx)		+= idle_6xx.o

> -obj-$(CONFIG_PPC32)		+= entry_32.o idle_6xx.o setup_32.o misc_32.o
> +obj-$(CONFIG_PPC32)		+= entry_32.o setup_32.o misc_32.o

Why does idle_6xx.o become an extra- rather than an obj- ?

Paul.
