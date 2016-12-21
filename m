Return-Path: <khandual@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tk5HF6ygRzDwNX
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Dec 2016 18:04:09 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uBL73lWJ140882
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Dec 2016 02:04:07 -0500
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [125.16.236.9])
 by mx0a-001b2d01.pphosted.com with ESMTP id 27fepkwm52-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Dec 2016 02:04:07 -0500
Received: from localhost
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 21 Dec 2016 12:34:04 +0530
Received: from d28relay08.in.ibm.com (d28relay08.in.ibm.com [9.184.220.159])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id EA1C0394004E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Dec 2016 12:34:00 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay08.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uBL73JPZ25362534
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Dec 2016 12:33:19 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uBL73rjj026513
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Dec 2016 12:33:58 +0530
Subject: Re: [PATCH v3 3/5] powerpc/mm: add radix__create_section_mapping()
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Reza Arbab <arbab@linux.vnet.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
References: <1481831443-22761-1-git-send-email-arbab@linux.vnet.ibm.com>
 <1481831443-22761-4-git-send-email-arbab@linux.vnet.ibm.com>
 <87zijsthma.fsf@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Alistair Popple <apopple@au1.ibm.com>
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Wed, 21 Dec 2016 12:33:48 +0530
MIME-Version: 1.0
In-Reply-To: <87zijsthma.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <585A2954.2000005@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/19/2016 02:34 PM, Aneesh Kumar K.V wrote:
> Reza Arbab <arbab@linux.vnet.ibm.com> writes:
> 
>> > Add the linear page mapping function for radix, used by memory hotplug.
>> > This is similar to vmemmap_populate().
>> >
> Ok with this patch your first patch becomes useful. Can you merge that
> with this and rename mmu_linear_psize to mmu_hotplug_psize or even use
> mmu_virtual_psize. The linear naming is confusing.

mmu_linear_psize variable was referring to the page size used to create
kernel linear mapping (the 0xc00.... range) for the newly added memory
section. Why the name should be changed ?
