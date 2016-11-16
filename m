Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tJdwk1SwGzDvmd
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2016 20:18:45 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAG9IVLR083370
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2016 04:18:43 -0500
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [125.16.236.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 26rbr1tqdc-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2016 04:18:42 -0500
Received: from localhost
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 16 Nov 2016 14:48:39 +0530
Received: from d28relay09.in.ibm.com (d28relay09.in.ibm.com [9.184.220.160])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 8145B394005E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2016 14:48:36 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay09.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uAG9IaVu13566144
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2016 14:48:36 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uAG9IWOw003717
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2016 14:48:36 +0530
Date: Wed, 16 Nov 2016 14:48:20 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: acme@kernel.org, Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, kim.phillips@arm.com,
 linuxppc-dev@lists.ozlabs.org, peterz@infradead.org, mingo@redhat.com,
 alexander.shishkin@linux.intel.com, treeze.taeung@gmail.com,
 markus@trippelsdorf.de, namhyung@kernel.org, pawel.moll@arm.com,
 chris.ryder@arm.com, jolsa@kernel.org, mhiramat@kernel.org
Subject: Re: [PATCH v7 0/6] perf annotate: Cross arch support + few fixes
References: <1474472876-2706-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1474472876-2706-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
Message-Id: <20161116091820.GB4019@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2016/09/21 09:17PM, Ravi Bangoria wrote:
> Currently Perf annotate support code navigation (branches and calls)
> only when run on the same architecture where perf.data was recorded.
> But, for example, record on powerpc server and annotate on client's
> x86 desktop is not supported.
> 
> This patchset adds supports for that.
> 
> Example:
> 
>   Record on powerpc:
>   $ ./perf record -a
> 
>   Report -> Annotate on x86:
>   $ ./perf report -i perf.data.powerpc --vmlinux vmlinux.powerpc

Hi Arnaldo,
Can you please take this in for v4.10? We'd very much like to use this 
for better code annotation and browsing. FWIW, I have tested this on 
powerpc.

Tested-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>


Thanks,
Naveen
