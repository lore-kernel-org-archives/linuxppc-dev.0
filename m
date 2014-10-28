Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BD0711A0061
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Oct 2014 15:31:22 +1100 (AEDT)
In-Reply-To: <1414420206-7869-1-git-send-email-clg@fr.ibm.com>
To: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@fr.ibm.com> 
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: powerc: fix build failure when CONFIG_HUGETLB_PAGE is not set
Message-Id: <20141028043122.9E00E14007F@ozlabs.org>
Date: Tue, 28 Oct 2014 15:31:22 +1100 (AEDT)
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-27-10 at 14:30:06 UTC, =?utf-8?q?C=C3=A9dric_Le_Goater?= wrote:
> CC      arch/powerpc/mm/slice.o
> In file included from ../arch/powerpc/mm/slice.c:33:0:
> ../include/linux/hugetlb.h:141:47: error: expected identifier or ‘(’ before numeric constant
>  #define is_hugepage_only_range(mm, addr, len) 0
>                                                ^
> ../arch/powerpc/mm/slice.c:704:5: note: in expansion of macro ‘is_hugepage_only_range’
>  int is_hugepage_only_range(struct mm_struct *mm, unsigned long addr,
>      ^

Hi Cedric,

I'm pretty sure this is fixed in my fixes branch:

  https://git.kernel.org/cgit/linux/kernel/git/mpe/linux.git/log/?h=fixes

cheers
