Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wJWVw5XkKzDqBJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 May 2017 20:30:00 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, ego <ego@linux.vnet.ibm.com>,
 sachinp <sachinp@linux.vnet.ibm.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, mahesh@linux.vnet.ibm.com,
 npiggin@gmail.com
Subject: Re: [linux-next][bisected 1945bc45] build brakes for PowerPC BE
 configuration on LPAR
In-Reply-To: <1493889859.7355.17.camel@abdul.in.ibm.com>
References: <1493889859.7355.17.camel@abdul.in.ibm.com>
Date: Thu, 04 May 2017 20:29:59 +1000
Message-ID: <8760hgzzh4.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Abdul Haleem <abdhalee@linux.vnet.ibm.com> writes:

> Hi,
>
> linux-next build fails on BE config with next-20170424 onwards
>
> the patch https://lkml.org/lkml/2017/4/20/994  fixes a similar issue
> with kvm guest build failure.
>
> arch/powerpc/kernel/exceptions-64s.S: Assembler messages:
> arch/powerpc/kernel/exceptions-64s.S:395: Error: operand out of range
> (0xffffffffffff8280 is not between 0x0000000000000000 and
> 0x000000000000ffff)
> make[1]: *** [arch/powerpc/kernel/head_64.o] Error 1

I couldn't reproduce that.

What toolchain are you using?

cheers
