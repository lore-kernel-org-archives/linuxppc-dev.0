Return-Path: <ravi.bangoria@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3st1cm0S9NzDrbk
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Oct 2016 00:46:31 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u9ADha0C049900
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Oct 2016 09:46:30 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2606y568s1-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Oct 2016 09:46:29 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ravi.bangoria@linux.vnet.ibm.com>;
 Mon, 10 Oct 2016 07:46:29 -0600
Subject: Re: [PATCH v7 6/6] perf annotate: cross arch annotate support fixes
 for ARM
To: Arnaldo Carvalho de Melo <acme@kernel.org>
References: <1474472876-2706-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
 <1474472876-2706-7-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
 <20161005113406.GV7143@kernel.org>
Cc: linux-kernel@vger.kernel.org, kim.phillips@arm.com,
 linuxppc-dev@lists.ozlabs.org, peterz@infradead.org, mingo@redhat.com,
 alexander.shishkin@linux.intel.com, treeze.taeung@gmail.com,
 naveen.n.rao@linux.vnet.ibm.com, markus@trippelsdorf.de,
 namhyung@kernel.org, pawel.moll@arm.com, chris.ryder@arm.com,
 jolsa@kernel.org, mhiramat@kernel.org,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Date: Mon, 10 Oct 2016 19:16:16 +0530
MIME-Version: 1.0
In-Reply-To: <20161005113406.GV7143@kernel.org>
Content-Type: text/plain; charset=windows-1252
Message-Id: <57FB9BA8.2050506@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Wednesday 05 October 2016 05:04 PM, Arnaldo Carvalho de Melo wrote:
> Em Wed, Sep 21, 2016 at 09:17:56PM +0530, Ravi Bangoria escreveu:
>> From: Kim Phillips <kim.phillips@arm.com>
>>
>> For ARM we remove the list that contains non-arm insns, and
>> instead add more maintainable branch instruction regex logic.
> This one looks ok and actually is in the direction of having facilities
> for all arches, should've come as infrastructure that then gets used by
> ARM and powerpc.

This was authored by Kim and I didn't wanted to change that so I kept it
at the end.

I'm sending a cleanup patch that applies on top of this series. That patch
moves most of arch specific stuff from util/annotate.c to
util/annotate/<arch>.c. Please review it.

Please pull this series if you are ok with that patch. Otherwise I'll respin
entire series.

Thanks
-Ravi
