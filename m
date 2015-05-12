Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C72BC1A0048
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 16:02:06 +1000 (AEST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 12 May 2015 11:32:03 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id E8AB53940053
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 11:31:57 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4C61vxx655742
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 11:31:57 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4C61ua6023766
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 11:31:56 +0530
Message-ID: <55519753.4020807@linux.vnet.ibm.com>
Date: Tue, 12 May 2015 11:31:55 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 00/13] POWER DSCR fixes, improvements, docs and tests
References: <1428654612-23539-1-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1428654612-23539-1-git-send-email-khandual@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: mikey@neuling.org, shuahkh@osg.samsung.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/10/2015 01:59 PM, Anshuman Khandual wrote:
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
> So the derivied test cases have Anton's copyright along with mine but the
> commit message as of now has only my signed-off-by statement. As Anton
> mentioned before he would put his signed-off-by after reviewing these
> modified test cases.
> 
> NOTE1: Anton's original inherit exec test expected the child to have system
> default DSCR value instead of the inherited DSCR value from it's parent.
> But looks like thats not the case when we execute the test, it always
> inherits it's parent's DSCR value over the exec call as well. So I have
> changed the test program assuming its correct to have the inherited DSCR
> value in the fork/execed child program. Please let me know if thats not
> correct and I am missing something there.
> 
> Changes in V3:
> -------------
> - Minor changes to last couple of sysfs test cases
> - Added .gitignore file for the new test directory

Hey Michael/Ben/Mikey,

Do you have any thoughts or updates on this patch series. Its already
been a month for this latest version to be on the list.
