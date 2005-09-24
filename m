Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17204.38908.767118.59625@cargo.ozlabs.ibm.com>
Date: Sat, 24 Sep 2005 10:04:12 +1000
From: Paul Mackerras <paulus@samba.org>
To: Kumar Gala <galak@freescale.com>
In-Reply-To: <Pine.LNX.4.61.0509231408170.3791@nylon.am.freescale.net>
References: <Pine.LNX.4.61.0509231408170.3791@nylon.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org, arnd@arndb.de,
	linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: Re: [PATCH] powerpc: merged asm/cputable.h
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala writes:

> +#ifdef __powerpc64__
> +extern struct cpu_spec		*cur_cpu_spec;
> +#else /* __powerpc64__ */
> +extern struct cpu_spec		*cur_cpu_spec[];
> +#endif /* __powerpc64__ */

I would like to see this unified - it makes no sense for them to be
different.  We are unlikely to support asymmetric multiprocessing any
time soon, so let's go with the single cur_cpu_spec pointer (a la
ppc64).

Paul.
