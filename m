Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6031D1A065E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 May 2015 18:38:51 +1000 (AEST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 25 May 2015 14:08:48 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 724FF3940049
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 May 2015 14:08:46 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4P8cjXJ2425132
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 May 2015 14:08:45 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4P8cjbL016864
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 May 2015 14:08:45 +0530
Message-ID: <5562DF94.2090804@linux.vnet.ibm.com>
Date: Mon, 25 May 2015 14:08:44 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
CC: mikey@neuling.org, anton@samba.org, shuahkh@osg.samsung.com
Subject: Re: [PATCH V5 00/13] POWER DSCR fixes, improvements, docs and tests
References: <1432190593-17253-1-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1432190593-17253-1-git-send-email-khandual@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/21/2015 12:13 PM, Anshuman Khandual wrote:
> 	This patch series has patches for POWER DSCR fixes, improvements,
> in code documentaion, kernel support user documentation and selftest based
> test cases. It has got five test cases which are derived from Anton's DSCR
> test bucket which can be listed as follows.
> 
> (1) http://ozlabs.org/~anton/junkcode/dscr_default_test.c
> (2) http://ozlabs.org/~anton/junkcode/dscr_explicit_test.c
> (3) http://ozlabs.org/~anton/junkcode/dscr_inherit_exec_test.c
> (4) http://ozlabs.org/~anton/junkcode/dscr_inherit_test.c
> (5) http://ozlabs.org/~anton/junkcode/user_dscr_test.c
> 
> NOTE1: Anton's original inherit exec test expected the child to have
> system default DSCR value instead of the inherited DSCR value from
> it's parent. But looks like thats not the case when we execute the
> test, it always inherits it's parent's DSCR value over the exec call
> as well. So I have changed the test program assuming its correct to
> have the inherited DSCR value in the fork/execed child program.
> Please let me know if thats not correct and I am missing something
> there.
> 
> Changes in V5:
> -------------
> - Fixed build problem with get_default_dscr/set_default_dscr functions
>   by checking on the return values of read & write system calls.

These patches are available for pull from this location mentioned below.

https://github.com/akhandual/linux.git dscr_v5
