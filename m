Return-Path: <ravi.bangoria@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wpkxy0MztzDq98
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jun 2017 12:35:49 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5G2Y1ZQ106256
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jun 2017 22:35:47 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2b42v374db-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jun 2017 22:35:46 -0400
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ravi.bangoria@linux.vnet.ibm.com>;
 Thu, 15 Jun 2017 20:35:45 -0600
Subject: Re: [PATCH] ppc64/perf: Fix oops when kthread execs user process
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
References: <1497534408-4591-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
 <20170615152749.GA2800@naverao1-tp.localdomain>
Cc: mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
 mingo@kernel.org, peterz@infradead.org, acme@kernel.org,
 alexander.shishkin@linux.intel.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Date: Fri, 16 Jun 2017 08:05:31 +0530
MIME-Version: 1.0
In-Reply-To: <20170615152749.GA2800@naverao1-tp.localdomain>
Content-Type: text/plain; charset=windows-1252
Message-Id: <594343F3.4070504@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thanks Naveen,

On Thursday 15 June 2017 08:57 PM, Naveen N. Rao wrote:
> Hmm... are you sure it's the same issue? The above commit only went into 
> v4.7, which means we weren't able to use --call-graph=dwarf till v4.7.

Yes sorry. It's from v4.7 onwards.

-Ravi
