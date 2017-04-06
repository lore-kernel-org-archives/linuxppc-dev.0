Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vz9S175b9zDqJv
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Apr 2017 14:57:21 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v364nRtE085448
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Apr 2017 00:57:11 -0400
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [125.16.236.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29n9g7bghq-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Apr 2017 00:57:11 -0400
Received: from localhost
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Thu, 6 Apr 2017 10:27:08 +0530
Received: from d28av08.in.ibm.com (d28av08.in.ibm.com [9.184.220.148])
 by d28relay06.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v364v6Mj18022532
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Apr 2017 10:27:06 +0530
Received: from d28av08.in.ibm.com (localhost [127.0.0.1])
 by d28av08.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v364v5eH001607
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Apr 2017 10:27:06 +0530
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Ian Munsie <imunsie@au1.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>,
 Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 Greg Kurz <gkurz@linux.vnet.ibm.com>
Subject: Re: [PATCH] cxl: Route eeh events to all drivers in
 cxl_pci_error_detected()
In-Reply-To: <9789e76d-d410-57e6-8cae-7d81919810e7@au1.ibm.com>
References: <20170405061608.13797-1-vaibhav@linux.vnet.ibm.com>
 <9789e76d-d410-57e6-8cae-7d81919810e7@au1.ibm.com>
Date: Thu, 06 Apr 2017 10:27:04 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <877f2y6sm7.fsf@vajain21.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Andrew,

Thanks for reviewing the patch.

Andrew Donnellan <andrew.donnellan@au1.ibm.com> writes:

>> Based-on: https://patchwork.ozlabs.org/patch/747102/
>> Fixes: 9e8df8a21963("cxl: EEH support")
>> Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
>
> Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
>
> Should this go to stable?
Yes, Once this patch gets an ack from Fred, I will resend the patch
marking cc to the stable tree.

-- 
Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Linux Technology Center, IBM India Pvt. Ltd.
