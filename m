Return-Path: <abdhalee@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wJX0L3WnLzDqBJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 May 2017 20:52:02 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v44AnY8H017780
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 May 2017 06:51:57 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2a82vy82jb-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 May 2017 06:51:56 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <abdhalee@linux.vnet.ibm.com>;
 Thu, 4 May 2017 20:51:49 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v44ApdeE1769864
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 May 2017 20:51:47 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v44ApEKp003032
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 May 2017 20:51:14 +1000
Subject: Re: [linux-next][bisected 1945bc45] build brakes for PowerPC BE
 configuration on LPAR
From: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, sachinp
 <sachinp@linux.vnet.ibm.com>, Stephen Rothwell <sfr@canb.auug.org.au>, ego
 <ego@linux.vnet.ibm.com>, mahesh@linux.vnet.ibm.com, linux-kernel
 <linux-kernel@vger.kernel.org>, npiggin@gmail.com
Date: Thu, 04 May 2017 16:20:50 +0530
In-Reply-To: <8760hgzzh4.fsf@concordia.ellerman.id.au>
References: <1493889859.7355.17.camel@abdul.in.ibm.com>
 <8760hgzzh4.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1493895050.7355.22.camel@abdul.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-05-04 at 20:29 +1000, Michael Ellerman wrote:
> Abdul Haleem <abdhalee@linux.vnet.ibm.com> writes:
> 
> > Hi,
> >
> > linux-next build fails on BE config with next-20170424 onwards
> >
> > the patch https://lkml.org/lkml/2017/4/20/994  fixes a similar issue
> > with kvm guest build failure.
> >
> > arch/powerpc/kernel/exceptions-64s.S: Assembler messages:
> > arch/powerpc/kernel/exceptions-64s.S:395: Error: operand out of range
> > (0xffffffffffff8280 is not between 0x0000000000000000 and
> > 0x000000000000ffff)
> > make[1]: *** [arch/powerpc/kernel/head_64.o] Error 1
> 
> I couldn't reproduce that.
> 
> What toolchain are you using?

I have gcc-4.8.2-1 on Power 6 LPAR running Fedora 20.

Also recreating the same on Power 8 BE LPAR having gcc-4.8.5-11

> 
> cheers
> 


-- 
Regard's

Abdul Haleem
IBM Linux Technology Centre
