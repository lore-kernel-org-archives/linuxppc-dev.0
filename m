Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [125.16.236.8])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r1KgY45tqzDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 May 2016 15:13:44 +1000 (AEST)
Received: from localhost
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Fri, 6 May 2016 10:43:41 +0530
Received: from d28relay08.in.ibm.com (d28relay08.in.ibm.com [9.184.220.159])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 76EE6125804F
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 May 2016 10:45:43 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay08.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u465Dcb012517606
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 May 2016 10:43:38 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u465DbZt004258
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 May 2016 10:43:38 +0530
Message-ID: <572C2801.7050605@linux.vnet.ibm.com>
Date: Fri, 06 May 2016 10:43:37 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
CC: mikey@neuling.org, oohall@gmail.com
Subject: Re: [PATCH 0/2] Enable ZONE_DEVICE on POWER
References: <1462450304-19173-1-git-send-email-khandual@linux.vnet.ibm.com>
 <87r3dgk1bh.fsf@skywalker.in.ibm.com>
In-Reply-To: <87r3dgk1bh.fsf@skywalker.in.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/05/2016 08:18 PM, Aneesh Kumar K.V wrote:
> Anshuman Khandual <khandual@linux.vnet.ibm.com> writes:
> 
>> This enables base ZONE_DEVICE support on POWER. This series depends on
>> the following patches posted by Oliver.
>>
>> https://patchwork.ozlabs.org/patch/618867/
>> https://patchwork.ozlabs.org/patch/618868/
>>
>> Anshuman Khandual (2):
>>   powerpc/mm: Make vmemmap_populate accommodate ZONE_DEVICE memory
>>   powerpc/mm: Enable support for ZONE_DEVICE on PPC_BOOK3S_64 platforms
>>
>>  arch/powerpc/mm/init_64.c | 4 +++-
>>  mm/Kconfig                | 2 +-
>>  2 files changed, 4 insertions(+), 2 deletions(-)
>>
> 
> What is the use case ? Who will use ZONE_DEVICE on ppc64. This should be
> be merged along with the patch series that use this. 

IIUC, Oliver has been looking at using ZONE_DEVICE for the NVDIMM (or
some other persistent memory) drivers. I have been following Dan William's
work on this front and want to explore more details about it's functioning
on ppc64. This enablement will just help us little bit in that direction.
