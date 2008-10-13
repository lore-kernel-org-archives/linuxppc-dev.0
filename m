Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18674.42140.69339.584403@drongo.ozlabs.ibm.com>
Date: Mon, 13 Oct 2008 12:30:04 +1100
From: Paul Mackerras <paulus@samba.org>
To: mohan@in.ibm.com
Subject: Re: [PATCH] Support for relocatable kdump kernel
In-Reply-To: <20081012233420.GA6240@in.ibm.com>
References: <20081012233420.GA6240@in.ibm.com>
Cc: linuxppc-dev@ozlabs.org, kexec@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Mohan Kumar M writes:

> Support for relocatable kdump kernel

> @@ -1401,9 +1414,21 @@ _STATIC(__after_prom_start)
>  	beq	9f			/* have already put us at zero */
>  	li	r6,0x100		/* Start offset, the first 0x100 */
>  					/* bytes were copied earlier.	 */
> -#ifdef CONFIG_RELOCATABLE
> +
> +#ifdef CONFIG_CRASH_DUMP

What tree is this patch against?  No tree that I can find has a line
saying "#ifdef CONFIG_RELOCATABLE" at that point.  Or is there a
prerequisite patch that I haven't seen yet?

Paul.
