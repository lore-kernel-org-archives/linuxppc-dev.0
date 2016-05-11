Return-Path: <bsingharora@gmail.com>
Received: from mail-pa0-x243.google.com (mail-pa0-x243.google.com
 [IPv6:2607:f8b0:400e:c03::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r4JD4663xzDqCn
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 May 2016 11:18:44 +1000 (AEST)
Received: by mail-pa0-x243.google.com with SMTP id zy2so2762813pac.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 May 2016 18:18:44 -0700 (PDT)
Subject: Re: [PATCH 2/2] Deduplicate the actual base page size code
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, mpe@ellerman.id.au
References: <1462892262-18066-1-git-send-email-bsingharora@gmail.com>
 <1462892262-18066-3-git-send-email-bsingharora@gmail.com>
 <871t59kcnh.fsf@skywalker.in.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <8def36ee-f94f-8d31-da87-dfe896df4df4@gmail.com>
Date: Wed, 11 May 2016 11:18:33 +1000
MIME-Version: 1.0
In-Reply-To: <871t59kcnh.fsf@skywalker.in.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 11/05/16 04:09, Aneesh Kumar K.V wrote:
> Balbir Singh <bsingharora@gmail.com> writes:
> 
>> Deduplicate to one function to compute the actual page size.
>> Some additional warnings added for AP size as well.
> 
> 
> This is getting chaned in a cleanup series I am testing before posting. 
> The change from ap to psize need more update in commit message. 
> 
> commit 701e0d3dc33c93a97b825f403d58f6be99b89203
> Author: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> Date:   Tue May 10 11:33:15 2016 +0530
> 
>     powerpc/mm/radix/hugetlb: Add helper for finding page size from hstate
>     
>     Use the helper instead of open coding the same at multiple place
>     
>     Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

This version makes more sense. While we are at it, mind replacing psize with base_psize and asserting
that base_psize is always 0 or 5.

Balbir Singh.
