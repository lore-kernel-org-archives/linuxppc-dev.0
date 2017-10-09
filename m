Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y9mNm13ZKzDqv8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Oct 2017 03:46:47 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v99GitUR012562
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Oct 2017 12:46:41 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dg9s8b5x1-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Oct 2017 12:46:41 -0400
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Mon, 9 Oct 2017 17:46:39 +0100
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v99GkZNF23134250
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Oct 2017 16:46:36 GMT
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v99GkYQp019621
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Oct 2017 03:46:35 +1100
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>
Cc: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 "Alastair D'Silva" <alastair@au1.ibm.com>
Subject: Re: [PATCH] cxl: Dump PSL_FIR1/2 registers on PSL9 error irq
In-Reply-To: <20170907121346.22011-1-vaibhav@linux.vnet.ibm.com>
References: <20170907121346.22011-1-vaibhav@linux.vnet.ibm.com>
Date: Mon, 09 Oct 2017 22:16:30 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87zi90mfq1.fsf@vajain21.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fred just pointed out that there is no register named FIR2 on PSL9
instead we have a FIR_MASK register in its place. So I will re-spin this
patch with the correct register name.

Thanks everyone for the review and to Fred for pointing out the issue.

-- 
Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Linux Technology Center, IBM India Pvt. Ltd.
