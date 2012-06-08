Return-Path: <jlarrew@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e31.co.us.ibm.com", Issuer "Equifax" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8EC49B6FAA
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Jun 2012 07:55:03 +1000 (EST)
Received: from /spool/local
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <jlarrew@linux.vnet.ibm.com>;
 Fri, 8 Jun 2012 15:55:01 -0600
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
 [9.17.195.226])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id E35C919D804F
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jun 2012 21:54:56 +0000 (WET)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q58LsvdC236364
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Jun 2012 15:54:57 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q58LsvmY018543
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Jun 2012 15:54:57 -0600
Received: from [9.41.47.120] (jlarrew-lappy.austin.ibm.com [9.41.47.120])
 by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
 q58Lst4B018474
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Jun 2012 15:54:56 -0600
Message-ID: <4FD274AF.8080700@linux.vnet.ibm.com>
Date: Fri, 08 Jun 2012 16:54:55 -0500
From: Jesse Larrew <jlarrew@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 5/15] powerpc: convert to %r for all GPR usage
References: <20120608113605.75BD5D43B26@localhost.localdomain>
In-Reply-To: <20120608113605.75BD5D43B26@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/08/2012 06:36 AM, Michael Neuling wrote:


> -/* General Purpose Registers (GPRs) */
> +/*
> + * General Purpose Registers (GPRs)
> + *
> + * The lower case r0-r31 should be used in preference to the upper
> + * case R0-R31 as they provide more error checking in the assembler.
> + * Use R0-31 only when really nessesary.
> + */
> 
> -#define	r0	0
> -#define	r1	1
> -#define	r2	2
> -#define	r3	3
> -#define	r4	4
> -#define	r5	5
> -#define	r6	6
> -#define	r7	7
> -#define	r8	8
> -#define	r9	9
> -#define	r10	10
> -#define	r11	11
> -#define	r12	12
> -#define	r13	13
> -#define	r14	14
> -#define	r15	15
> -#define	r16	16
> -#define	r17	17
> -#define	r18	18
> -#define	r19	19
> -#define	r20	20
> -#define	r21	21
> -#define	r22	22
> -#define	r23	23
> -#define	r24	24
> -#define	r25	25
> -#define	r26	26
> -#define	r27	27
> -#define	r28	28
> -#define	r29	29
> -#define	r30	30
> -#define	r31	31
> +#define	r0	%r0
> +#define	r1	%r1
> +#define	r2	%r2
> +#define	r3	%r3
> +#define	r4	%r4
> +#define	r5	%r5
> +#define	r6	%r6
> +#define	r7	%r7
> +#define	r8	%r8
> +#define	r9	%r9
> +#define	r10	%r10
> +#define	r11	%r11
> +#define	r12	%r12
> +#define	r13	%r13
> +#define	r14	%r14
> +#define	r15	%r15
> +#define	r16	%r16
> +#define	r17	%r17
> +#define	r18	%r18
> +#define	r19	%r19
> +#define	r20	%r20
> +#define	r21	%r21
> +#define	r22	%r22
> +#define	r23	%r23
> +#define	r24	%r24
> +#define	r25	%r25
> +#define	r26	%r26
> +#define	r27	%r27
> +#define	r28	%r28
> +#define	r29	%r29
> +#define	r30	%r30
> +#define	r31	%r31
> 
>  #define	R0	0
>  #define	R1	1


I think your patch was truncated somehow.

> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 



Jesse Larrew
Software Engineer, Linux on Power Kernel Team
IBM Linux Technology Center
Phone: (512) 973-2052 (T/L: 363-2052)
jlarrew@linux.vnet.ibm.com
