Return-Path: <chandan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vhWpk5T9zzDqY4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Mar 2017 19:52:46 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2D8iB87002753
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Mar 2017 04:52:43 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0a-001b2d01.pphosted.com with ESMTP id 294b0m4n9h-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Mar 2017 04:52:43 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <chandan@linux.vnet.ibm.com>;
 Mon, 13 Mar 2017 18:52:41 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v2D8qUPQ45285444
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Mar 2017 19:52:38 +1100
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v2D8q6bv005143
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Mar 2017 19:52:06 +1100
From: Chandan Rajendra <chandan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
 Paul Mackerras <paulus@samba.org>
Subject: Re: syscall statx not implemented on powerpc
Date: Mon, 13 Mar 2017 14:21:47 +0530
In-Reply-To: <7dba3a5469d34ac3890a5eaa16822a75@svr-chch-ex1.atlnz.lc>
References: <7dba3a5469d34ac3890a5eaa16822a75@svr-chch-ex1.atlnz.lc>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <4396749.JbYdqAFZXV@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Monday, March 13, 2017 03:33:07 AM Chris Packham wrote:
> Hi,
> 
> I've just attempted to build a powerpc kernel from 4.11-rc2 using a 
> custom defconfig (available on request) and I'm hitting the following 
> error in the early stages of compilation.
> 
> <stdin>:1325:2: error: #warning syscall statx not implemented [-Werror=cpp]
> 
> Same thing seems to happen with mpc85xx_basic_defconfig.
> 
> I don't actually need this syscall so I'd be happy to turn something off 
> to get things building. I did a quick search and couldn't see anything 
> on linuxppc-dev but google keeps correcting "statx" to "stats" so I 
> could have missed it.
> 
> 

The upstream commit
(https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a528d35e8bfcc521d7cb70aaf03e1bd296c8493f)
that introduces the statx syscall provides a test program. I will wire-up the
syscall on ppc64, run that test program and post the patch if the test program
works well.

-- 
chandan
