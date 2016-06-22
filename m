Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rZZfw3KVlzDqRd
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jun 2016 05:39:36 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5MJd8m7092867
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jun 2016 15:39:34 -0400
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [125.16.236.7])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23q6qndsh1-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jun 2016 15:39:34 -0400
Received: from localhost
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Thu, 23 Jun 2016 01:09:31 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 610EBE0040
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jun 2016 01:13:12 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5MJdSg658130598
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jun 2016 01:09:28 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5MJdOoE028772
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jun 2016 01:09:27 +0530
Date: Thu, 23 Jun 2016 01:09:11 +0530
From: Shreyas B Prabhu <shreyas@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Anton Blanchard <anton@samba.org>, ego@linux.vnet.ibm.com,
 mpe@ellerman.id.au, mikey@neuling.org, Paul Mackerras <paulus@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: linuxppc-dev@lists.ozlabs.org
Subject: Re: cpuidle broken on mainline
References: <20160623011655.62c610bd@kryten>
In-Reply-To: <20160623011655.62c610bd@kryten>
Content-Type: text/plain; charset=windows-1252
Message-Id: <576AE95F.6050109@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On 06/22/2016 08:46 PM, Anton Blanchard wrote:
> Hi,
> 
> I was noticing some pretty big run to run variations on single threaded
> benchmarks, and I've isolated it cpuidle issues. If I look at
> the cpuidle tracepoint, I notice we only go into the snooze state.
> 
> Do we have any known bugs in cpuidle at the moment?
> 
I've posted a fix here-
https://lists.ozlabs.org/pipermail/linuxppc-dev/2016-June/144726.html

Thanks,
Shreyas
