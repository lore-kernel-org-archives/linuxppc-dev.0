Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 1/2] Make setjmp/longjmp code generic 
In-reply-to: <20080117053857.GA29035@lixom.net> 
References: <1200545142.37022.89292279731.qpush@coopers>
	<20080117044542.2F6CD70006@localhost.localdomain>
	<20080117053857.GA29035@lixom.net>
Date: Thu, 17 Jan 2008 16:36:49 +1100
Message-ID: <15983.1200548209@neuling.org>
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



In message <20080117053857.GA29035@lixom.net> you wrote:
> Hi,
> 
> On Thu, Jan 17, 2008 at 03:45:42PM +1100, Michael Neuling wrote:
> 
> > Index: linux-2.6-ozlabs/include/asm-powerpc/setjmp.h
> > ===================================================================
> > --- /dev/null
> > +++ linux-2.6-ozlabs/include/asm-powerpc/setjmp.h
> > @@ -0,0 +1,18 @@
> > +/*
> > + * Copyright (C) 2007 Michael Neuling
                     ^^^^^^

> > + *
> > + *      This program is free software; you can redistribute it and/or
> > + *      modify it under the terms of the GNU General Public License
> > + *      as published by the Free Software Foundation; either version
> > + *      2 of the License, or (at your option) any later version.
> > + *
> > + */
> > +#ifndef _ASM_POWERPC_SETJMP_H
> > +#define _ASM_POWERPC_SETJMP_H
> > +
> > +#define JMP_BUF_LEN    23
> > +
> > +extern long setjmp(long *);
> > +extern void longjmp(long *, long);
> > +
> > +#endif /* _ASM_POWERPC_SETJMP_H */
> 
> Should the above be inside #ifdef __KERNEL__?

Yep... _and_ it's 2008 now!

I'll update.

Mikey
