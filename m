Return-Path: <clg@fr.ibm.com>
Received: from e06smtp16.uk.ibm.com (e06smtp16.uk.ibm.com [195.75.94.112])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 36B351A00B2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Oct 2014 18:30:45 +1100 (AEDT)
Received: from /spool/local
 by e06smtp16.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@fr.ibm.com>;
 Tue, 28 Oct 2014 07:30:39 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id C2DDF219004D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Oct 2014 07:30:13 +0000 (GMT)
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
 [9.149.37.216])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s9S7UcKt60817418
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Oct 2014 07:30:38 GMT
Received: from d06av04.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s9S7UbxY017817
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Oct 2014 01:30:37 -0600
Message-ID: <544F45D9.2080009@fr.ibm.com>
Date: Tue, 28 Oct 2014 08:29:29 +0100
From: Cedric Le Goater <clg@fr.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: powerc: fix build failure when CONFIG_HUGETLB_PAGE is not set
References: <20141028043122.9E00E14007F@ozlabs.org>
In-Reply-To: <20141028043122.9E00E14007F@ozlabs.org>
Content-Type: text/plain; charset=windows-1252
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Michael,

On 10/28/2014 05:31 AM, Michael Ellerman wrote:
> On Mon, 2014-27-10 at 14:30:06 UTC, =?utf-8?q?C=C3=A9dric_Le_Goater?= wrote:
>> CC      arch/powerpc/mm/slice.o
>> In file included from ../arch/powerpc/mm/slice.c:33:0:
>> ../include/linux/hugetlb.h:141:47: error: expected identifier or ‘(’ before numeric constant
>>  #define is_hugepage_only_range(mm, addr, len) 0
>>                                                ^
>> ../arch/powerpc/mm/slice.c:704:5: note: in expansion of macro ‘is_hugepage_only_range’
>>  int is_hugepage_only_range(struct mm_struct *mm, unsigned long addr,
>>      ^
> 
> Hi Cedric,
> 
> I'm pretty sure this is fixed in my fixes branch:
> 
>   https://git.kernel.org/cgit/linux/kernel/git/mpe/linux.git/log/?h=fixes

Indeed. I just picked -rc2 without checking your branch. I will next time.

Thanks,

C.
