Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vc71p6zTdzDqFh
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Mar 2017 16:02:06 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v264xcQD094407
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Mar 2017 00:02:03 -0500
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [125.16.236.7])
 by mx0a-001b2d01.pphosted.com with ESMTP id 290bym3vd9-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Mar 2017 00:02:03 -0500
Received: from localhost
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Mon, 6 Mar 2017 10:31:59 +0530
Received: from d28relay09.in.ibm.com (d28relay09.in.ibm.com [9.184.220.160])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 17859394005E
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Mar 2017 10:31:57 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay09.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v2651udO12255396
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Mar 2017 10:31:56 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v2651uTS007632
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Mar 2017 10:31:56 +0530
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: Vipin K Parashar <vipin@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: stewart@linux.vnet.ibm.com, Vipin K Parashar <vipin@linux.vnet.ibm.com>
Subject: Re: [PATCH v3] powernv/sensor: Handle OPAL_WRONG_STATE error return
In-Reply-To: <1488707468-16643-1-git-send-email-vipin@linux.vnet.ibm.com>
References: <1488707468-16643-1-git-send-email-vipin@linux.vnet.ibm.com>
Date: Mon, 06 Mar 2017 10:31:54 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87zigz577h.fsf@vajain21.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Vipin,

Minor spell fix in the patch description:

Vipin K Parashar <vipin@linux.vnet.ibm.com> writes:
> OPAL returns OPAL_WRONG_STATE upon failing to provide
> sensor data due to core sleeping/offline. Added check
> for OPAL_WRONG_STATE rerurn code with sensor read failure.
s/rerurn/return

> Also added a log message indicating sensor data being
> queried for sleeping/offline core.
s/for/for a/

-- 
Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Linux Technology Center, IBM India Pvt. Ltd.
