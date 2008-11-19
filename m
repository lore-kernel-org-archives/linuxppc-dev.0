Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18723.38125.245930.196074@cargo.ozlabs.ibm.com>
Date: Wed, 19 Nov 2008 15:24:13 +1100
From: Paul Mackerras <paulus@samba.org>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] powerpc: allow configuring max stack dump depth
In-Reply-To: <1225534317.3560.8.camel@johannes.berg>
References: <1225534317.3560.8.camel@johannes.berg>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Johannes Berg writes:

> On my screen, when something crashes, I only have space for maybe
> 16 functions of the stack trace before the information above it
> scrolls off the screen. It's easy to hack the kernel to print out
> only that much, but it's harder to remember to do it. This patch
> introduces a config option for it so that I can keep the setting
> in my config.

Could you make it depend on DEBUG_KERNEL or ADVANCED or something?

> +	help
> +	  This option allows you to set the stack depth that the kernel
> +	  prints out in case your display is too small.

The "in case" is a little ambiguous here.  I suggest:

+	  This option allows you to set the maximum depth that the kernel
+	  prints in stack traces.  This can be useful if your display
+	  is too small.

Paul.
