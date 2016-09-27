Return-Path: <bsingharora@gmail.com>
Received: from mail-pa0-x243.google.com (mail-pa0-x243.google.com
 [IPv6:2607:f8b0:400e:c03::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sjk3R5btHzDrSf
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Sep 2016 11:37:23 +1000 (AEST)
Received: by mail-pa0-x243.google.com with SMTP id my20so9472074pab.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Sep 2016 18:37:23 -0700 (PDT)
Subject: Re: [RFC PATCH] powerpc/mm: THP page cache support
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 "Kirill A. Shutemov" <kirill@shutemov.name>
References: <1474560160-7327-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20160926105054.GA16074@node.shutemov.name>
 <87wphy8xny.fsf@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <f0052929-753d-49f7-80e1-85a1f1b237ee@gmail.com>
Date: Tue, 27 Sep 2016 11:37:13 +1000
MIME-Version: 1.0
In-Reply-To: <87wphy8xny.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 27/09/16 01:53, Aneesh Kumar K.V wrote:
>>>  
>>> +void zap_deposited_table(struct mm_struct *mm, pmd_t *pmd)
>>
>> static?
> 
> Ok I will fix that.

inline as well?

Balbir Singh.
