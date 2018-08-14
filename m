Return-Path: <ravi.bangoria@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41qXgf5VLRzF15Q
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Aug 2018 22:57:33 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w7EAeaL2075970
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Aug 2018 06:41:43 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2kuvdujj24-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Aug 2018 06:41:43 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ravi.bangoria@linux.ibm.com>;
 Tue, 14 Aug 2018 11:41:10 +0100
Subject: Re: [PATCH] powerpc/perf: Update perf_regs structure to include SIER
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, mpe@ellerman.id.au,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, Jiri Olsa <jolsa@redhat.com>,
 Namhyung Kim <namhyung@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Anju T Sudhakar <anju@linux.vnet.ibm.com>,
 Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <1531218587-20742-1-git-send-email-maddy@linux.vnet.ibm.com>
 <6284589d-d8ef-da3d-c220-b6d5abf8c50e@linux.vnet.ibm.com>
From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Date: Tue, 14 Aug 2018 16:11:04 +0530
MIME-Version: 1.0
In-Reply-To: <6284589d-d8ef-da3d-c220-b6d5abf8c50e@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <ee325fd3-20d0-9465-982d-932964db2abb@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 08/14/2018 03:46 PM, Madhavan Srinivasan wrote:
> Hi arnaldo,
> 
> Any comments or ack for this patch.

Tested-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

Thanks,
Ravi
