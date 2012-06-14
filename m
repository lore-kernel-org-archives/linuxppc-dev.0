Return-Path: <mikey@neuling.org>
Received: from localhost.localdomain (localhost [127.0.0.1])
 by ozlabs.org (Postfix) with ESMTP id 96D86B7008
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jun 2012 13:25:29 +1000 (EST)
From: Michael Neuling <mikey@neuling.org>
To: Jesse Larrew <jlarrew@linux.vnet.ibm.com>
Subject: Re: [PATCH 5/15] powerpc: convert to %r for all GPR usage
In-reply-to: <4FD274AF.8080700@linux.vnet.ibm.com>
References: <20120608113605.75BD5D43B26@localhost.localdomain>
 <4FD274AF.8080700@linux.vnet.ibm.com>
Date: Thu, 14 Jun 2012 13:25:28 +1000
Message-ID: <3125.1339644328@neuling.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Jesse Larrew <jlarrew@linux.vnet.ibm.com> wrote:
> On 06/08/2012 06:36 AM, Michael Neuling wrote:
> 
> 
> > -/* General Purpose Registers (GPRs) */
> > +/*
> > + * General Purpose Registers (GPRs)
> > + *
> > + * The lower case r0-r31 should be used in preference to the upper
> > + * case R0-R31 as they provide more error checking in the assembler.
> > + * Use R0-31 only when really nessesary.
> > + */
> > 
> > -#define	r0	0
> > -#define	r1	1
> > -#define	r2	2
> > -#define	r3	3
> > -#define	r4	4
> > -#define	r5	5
> > -#define	r6	6
> > -#define	r7	7
> > -#define	r8	8
> > -#define	r9	9
> > -#define	r10	10
> > -#define	r11	11
> > -#define	r12	12
> > -#define	r13	13
> > -#define	r14	14
> > -#define	r15	15
> > -#define	r16	16
> > -#define	r17	17
> > -#define	r18	18
> > -#define	r19	19
> > -#define	r20	20
> > -#define	r21	21
> > -#define	r22	22
> > -#define	r23	23
> > -#define	r24	24
> > -#define	r25	25
> > -#define	r26	26
> > -#define	r27	27
> > -#define	r28	28
> > -#define	r29	29
> > -#define	r30	30
> > -#define	r31	31
> > +#define	r0	%r0
> > +#define	r1	%r1
> > +#define	r2	%r2
> > +#define	r3	%r3
> > +#define	r4	%r4
> > +#define	r5	%r5
> > +#define	r6	%r6
> > +#define	r7	%r7
> > +#define	r8	%r8
> > +#define	r9	%r9
> > +#define	r10	%r10
> > +#define	r11	%r11
> > +#define	r12	%r12
> > +#define	r13	%r13
> > +#define	r14	%r14
> > +#define	r15	%r15
> > +#define	r16	%r16
> > +#define	r17	%r17
> > +#define	r18	%r18
> > +#define	r19	%r19
> > +#define	r20	%r20
> > +#define	r21	%r21
> > +#define	r22	%r22
> > +#define	r23	%r23
> > +#define	r24	%r24
> > +#define	r25	%r25
> > +#define	r26	%r26
> > +#define	r27	%r27
> > +#define	r28	%r28
> > +#define	r29	%r29
> > +#define	r30	%r30
> > +#define	r31	%r31
> > 
> >  #define	R0	0
> >  #define	R1	1
> 
> 
> I think your patch was truncated somehow.

How so?

Mikey
