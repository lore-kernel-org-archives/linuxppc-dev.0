Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 728621A084E
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Feb 2015 19:37:12 +1100 (AEDT)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 4 Feb 2015 18:37:10 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 2AC1E2BB0047
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Feb 2015 19:37:07 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t148awGp41287770
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Feb 2015 19:37:07 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t148aXM2021512
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Feb 2015 19:36:33 +1100
Message-ID: <54D1D9F8.3050402@linux.vnet.ibm.com>
Date: Wed, 04 Feb 2015 14:06:08 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 anton@samba.org
Subject: Re: [PATCH V2 00/12] POWER DSCR fixes, improvements, docs and tests
References: <1421144560-15901-1-git-send-email-khandual@linux.vnet.ibm.com>
 <54D1D66D.1030000@linux.vnet.ibm.com>
In-Reply-To: <54D1D66D.1030000@linux.vnet.ibm.com>
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

On 02/04/2015 01:51 PM, Anshuman Khandual wrote:
> On 01/13/2015 03:52 PM, Anshuman Khandual wrote:
>> > 	This patch series has patches for POWER DSCR fixes, improvements,
>> > in code documentaion, kernel support user documentation and selftest based
>> > test cases. It has got five test cases which are derived from Anton's DSCR
>> > test bucket which can be listed as follows.
>> > 
>> > (1) http://ozlabs.org/~anton/junkcode/dscr_default_test.c
>> > (2) http://ozlabs.org/~anton/junkcode/dscr_explicit_test.c
>> > (3) http://ozlabs.org/~anton/junkcode/dscr_inherit_exec_test.c
>> > (4) http://ozlabs.org/~anton/junkcode/dscr_inherit_test.c
>> > (5) http://ozlabs.org/~anton/junkcode/user_dscr_test.c
>> > 
>> > So the derivied test cases have Anton's copyright along with mine but the
>> > commit message as of now has only my signed-off-by statement. As Anton
>> > mentioned before he would put his signed-off-by after reviewing these
>> > modified test cases.
>> > 
>> > NOTE1: Anton's original inherit exec test expected the child to have system
>> > default DSCR value instead of the inherited DSCR value from it's parent.
>> > But looks like thats not the case when we execute the test, it always
>> > inherits it's parent's DSCR value over the exec call as well. So I have
>> > changed the test program assuming its correct to have the inherited DSCR
>> > value in the fork/execed child program. Please let me know if thats not
>> > correct and I am missing something there.
>> > 
>> > NOTE2: The selftests/powerpc/.gitignore will be added and will get updated
>> > through a different patch series related to ptrace instead of this one.
>> > 
>> > Changes in V2:
>> > -------------
>> > - Updated the thread struct DSCR value inside mtspr facility exception path
>> > - Modified the in code documentation to follow the kernel-doc format
>> > - Added seven selftest based DSCR related test cases under powerpc
> Hey Michael,
> 
> Did you get a chance to look into these patches ? After going through the
> discussions regarding all the selftest test cases, seems like they are good
> to go unless you disagree.

Hey Anton,

As discussed before (https://patchwork.ozlabs.org/patch/418583/), could you please
review the first five selftest test cases [patch 6, 7, 8, 9, 10] which are derived
from your DSCR test bucket and also consider acking them which will enable me to add
your Signed-off-by in the next version of the patch series. Thank you.

(1) http://ozlabs.org/~anton/junkcode/dscr_default_test.c
(2) http://ozlabs.org/~anton/junkcode/dscr_explicit_test.c
(3) http://ozlabs.org/~anton/junkcode/dscr_inherit_exec_test.c
(4) http://ozlabs.org/~anton/junkcode/dscr_inherit_test.c
(5) http://ozlabs.org/~anton/junkcode/user_dscr_test.c

Regards
Anshuman
