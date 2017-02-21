Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vSB9k1qdzzDqBV
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 17:56:26 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1L6nHS2057008
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 01:56:23 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28rg6w15gq-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 01:56:23 -0500
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 20 Feb 2017 23:56:22 -0700
Subject: Re: [PATCH V3 01/10] powerpc/mm/slice: Convert slice_mask high slice
 to a bitmap
To: Balbir Singh <bsingharora@gmail.com>
References: <1487498837-12017-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1487498837-12017-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20170221044300.GA21059@balbir.ozlabs.ibm.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Tue, 21 Feb 2017 12:26:15 +0530
MIME-Version: 1.0
In-Reply-To: <20170221044300.GA21059@balbir.ozlabs.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <5735c55a-df11-cfb5-7e61-d467ba3718eb@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Tuesday 21 February 2017 10:13 AM, Balbir Singh wrote:
> On Sun, Feb 19, 2017 at 03:37:08PM +0530, Aneesh Kumar K.V wrote:
>> In followup patch we want to increase the va range which will result
>> in us requiring high_slices to have more than 64 bits. To enable this
>> convert high_slices to bitmap. We keep the number bits same in this patch
>> and later change that to higher value
>>
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>> ---
> For consistency it would be nice to have low_slices represented similarly
> as well.

That will need converting lot of low_slices update to bitmap api with no 
real benefit
> Acked-by: Balbir Singh <bsingharora@gmail.com>
>

-aneesh
