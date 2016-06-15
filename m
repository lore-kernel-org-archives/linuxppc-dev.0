Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rVB5h2Q7dzDqjp
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jun 2016 01:59:04 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5FFsAYh120564
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jun 2016 11:59:02 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23jfktmgbd-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jun 2016 11:59:02 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 15 Jun 2016 09:59:01 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>,
 Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] Add support for power9 in ibm_architecture_vec
In-Reply-To: <CAKTCnzmLQoBLTyE+bDqwbCTJ+zDLih1Xzm17Qf3M=8v2MBAptQ@mail.gmail.com>
References: <900d62c2-8bdf-839a-49fa-99aff00a4d87@gmail.com>
 <87k2hqaegk.fsf@skywalker.in.ibm.com>
 <CAKTCnzmLQoBLTyE+bDqwbCTJ+zDLih1Xzm17Qf3M=8v2MBAptQ@mail.gmail.com>
Date: Wed, 15 Jun 2016 21:28:54 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87h9cua1fl.fsf@skywalker.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Balbir Singh <bsingharora@gmail.com> writes:

> On Wed, Jun 15, 2016 at 9:17 PM, Aneesh Kumar K.V
> <aneesh.kumar@linux.vnet.ibm.com> wrote:
>> Shouldn't this be 125 + 16 ?
>
> Actually the previous patch broke it and Ben fixed it, it should have
> been 133 after adding POWER8NVL. My patch adds 16+1 (1 for the
> OV1_PPC_3_00)
>
> 133+17 = 150
>
> Michael, can you please check. I did a quick check with  gdb
>


I missed that  OV1_PPC_3_00 is byte 3 of option vection 1. I guess you
also need to update VECTOR_LENGHT above the option vector 1 to 3.
ie, it should be VECTOR_LENGTH(3) ?

-aneesh
