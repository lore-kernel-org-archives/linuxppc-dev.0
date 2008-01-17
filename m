Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 8CAE3DDE30
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jan 2008 16:28:24 +1100 (EST)
Date: Wed, 16 Jan 2008 23:38:57 -0600
From: Olof Johansson <olof@lixom.net>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH 1/2] Make setjmp/longjmp code generic
Message-ID: <20080117053857.GA29035@lixom.net>
References: <1200545142.37022.89292279731.qpush@coopers>
	<20080117044542.2F6CD70006@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080117044542.2F6CD70006@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, RAISCH@de.ibm.com,
	Paul Mackerras <paulus@samba.org>, THEMANN@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

On Thu, Jan 17, 2008 at 03:45:42PM +1100, Michael Neuling wrote:

> Index: linux-2.6-ozlabs/include/asm-powerpc/setjmp.h
> ===================================================================
> --- /dev/null
> +++ linux-2.6-ozlabs/include/asm-powerpc/setjmp.h
> @@ -0,0 +1,18 @@
> +/*
> + * Copyright (C) 2007 Michael Neuling
> + *
> + *      This program is free software; you can redistribute it and/or
> + *      modify it under the terms of the GNU General Public License
> + *      as published by the Free Software Foundation; either version
> + *      2 of the License, or (at your option) any later version.
> + *
> + */
> +#ifndef _ASM_POWERPC_SETJMP_H
> +#define _ASM_POWERPC_SETJMP_H
> +
> +#define JMP_BUF_LEN    23
> +
> +extern long setjmp(long *);
> +extern void longjmp(long *, long);
> +
> +#endif /* _ASM_POWERPC_SETJMP_H */

Should the above be inside #ifdef __KERNEL__?


-Olof
