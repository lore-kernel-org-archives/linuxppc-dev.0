Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vnKWH73J6zDq7c
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 15:26:03 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2L4O4h4020004
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 00:25:53 -0400
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [125.16.236.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 299yqcjbn8-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 00:25:53 -0400
Received: from localhost
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Tue, 21 Mar 2017 09:55:50 +0530
Received: from d28av08.in.ibm.com (d28av08.in.ibm.com [9.184.220.148])
 by d28relay08.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v2L4OZxp15204590
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 09:54:35 +0530
Received: from d28av08.in.ibm.com (localhost [127.0.0.1])
 by d28av08.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v2L4PlbE016011
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 09:55:48 +0530
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Ian Munsie <imunsie@au1.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>,
 Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2] cxl: Force context lock during EEH flow
In-Reply-To: <83375caf-9b1a-dc15-98cb-8c65077dc5e8@au1.ibm.com>
References: <20170320095525.8582-1-vaibhav@linux.vnet.ibm.com>
 <83375caf-9b1a-dc15-98cb-8c65077dc5e8@au1.ibm.com>
Date: Tue, 21 Mar 2017 09:55:41 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87pohbw916.fsf@vajain21.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thanks for reviewing the patch Andrew,

Andrew Donnellan <andrew.donnellan@au1.ibm.com> writes:
> This change looks alright to me, it's a fix really, but I think might 
> need a quick mention in the changelog? AFAICT it'll change the return 
> value in cases where, for whatever reason, an earlier slice returns 
> PCI_ERS_RESULT_NONE and a later slice would return 
> PCI_ERS_RESULT_DISCONNECT, from what I can see.
Yes I agree. Will resend the patch mentioning this change in the
change-log.

-- 
Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Linux Technology Center, IBM India Pvt. Ltd.
