Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rTx3c5zgSzDqZV
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jun 2016 16:11:24 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5F69LP0024337
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jun 2016 02:11:22 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23jggswdhv-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jun 2016 02:11:21 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Wed, 15 Jun 2016 16:11:18 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 51B3B2BB005A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jun 2016 16:11:17 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5F6BHoh10879314
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jun 2016 16:11:17 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5F6BGX3028817
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jun 2016 16:11:16 +1000
Date: Wed, 15 Jun 2016 11:41:12 +0530
From: Shreyas B Prabhu <shreyas@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>
CC: ego@linux.vnet.ibm.com, mikey@neuling.org, benh@au1.ibm.com,
 linux-kernel@vger.kernel.org, maddy@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [v6, 07/11] powerpc/powernv: set power_save func after the idle
 states are initialized
References: <3rTwNj07nPz9t1J@ozlabs.org>
In-Reply-To: <3rTwNj07nPz9t1J@ozlabs.org>
Content-Type: text/plain; charset=windows-1252
Message-Id: <5760F180.90107@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 06/15/2016 11:11 AM, Michael Ellerman wrote:
> On Wed, 2016-08-06 at 16:54:27 UTC, "Shreyas B. Prabhu" wrote:
>> pnv_init_idle_states discovers supported idle states from the
>> device tree and does the required initialization. Set power_save
>> function pointer only after this initialization is done
> 
> This looks like a bug fix? Or is this not a concern in practice for some reason
> (and if so what is that reason)?
> 

This isn't a concern currently because, all powernv machines so far
supported nap and nap does not need any initialization from kernel side.

Thanks,
Shreyas
