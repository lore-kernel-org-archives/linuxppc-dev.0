Return-Path: <arbab@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tjhcb3BDhzDwTH
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Dec 2016 02:32:47 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uBKFTIfj007774
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2016 10:32:45 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 27f6s2anry-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2016 10:32:45 -0500
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <arbab@linux.vnet.ibm.com>;
 Tue, 20 Dec 2016 08:32:44 -0700
Date: Tue, 20 Dec 2016 09:32:39 -0600
From: Reza Arbab <arbab@linux.vnet.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Alistair Popple <apopple@au1.ibm.com>
Subject: Re: [PATCH v3 3/5] powerpc/mm: add radix__create_section_mapping()
References: <1481831443-22761-1-git-send-email-arbab@linux.vnet.ibm.com>
 <1481831443-22761-4-git-send-email-arbab@linux.vnet.ibm.com>
 <42967170-8b23-4682-ea44-4df0b1b205fd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
In-Reply-To: <42967170-8b23-4682-ea44-4df0b1b205fd@gmail.com>
Message-Id: <20161220153238.mndybchlz3cts7co@arbab-laptop.austin.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Dec 20, 2016 at 05:28:40PM +1100, Balbir Singh wrote:
>>+#ifdef CONFIG_MEMORY_HOTPLUG
>>+int radix__create_section_mapping(unsigned long start, unsigned long end)
>>+{
>>+	unsigned long page_size = 1 << mmu_psize_defs[mmu_linear_psize].shift;
>
>Can we refactor bits from radix_init_pgtable() and reuse?

Yes, that's my plan for v4.

-- 
Reza Arbab
