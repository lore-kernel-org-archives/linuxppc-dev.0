Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vShcT5mbszDq60
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 13:47:53 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1M2heiw066675
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 21:47:51 -0500
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28rsq9b5vj-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 21:47:51 -0500
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Wed, 22 Feb 2017 12:47:47 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 793F82CE8046
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 13:47:45 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1M2lbrY32899322
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 13:47:45 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1M2lDCh004433
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 13:47:13 +1100
Subject: Re: PowerPC build fail
To: "Tobin C. Harding" <me@tobin.cc>, linuxppc-dev@lists.ozlabs.org
References: <20170222012252.GD6131@eros>
Cc: Paul Mackerras <paulus@samba.org>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Wed, 22 Feb 2017 13:46:48 +1100
MIME-Version: 1.0
In-Reply-To: <20170222012252.GD6131@eros>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <481747d2-dd6a-bf27-3d75-3071306a4ddc@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 22/02/17 12:22, Tobin C. Harding wrote:
> The current (2bfe01e) torvalds git tree fails to build on powerpc64. Build machine
> is virtualized.
>
> - Build error
> arch/powerpc/kernel/time.c: In function ‘running_clock’:
> arch/powerpc/kernel/time.c:712:25: error: implicit declaration of function ‘cputime_to_nsecs’
>    return local_clock() - cputime_to_nsecs(kcpustat_this_cpu->cpustat[CPUTIME_STEAL]);

Already reported, see 
https://lists.ozlabs.org/pipermail/linuxppc-dev/2017-February/154433.html

See patch at http://patchwork.ozlabs.org/patch/730616/


Andrew

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
