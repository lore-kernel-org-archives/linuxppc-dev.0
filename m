Return-Path: <shuahkh@osg.samsung.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D07CF1A0157
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Nov 2014 04:06:54 +1100 (AEDT)
Received: from lists.s-osg.org (lists.s-osg.org [54.187.51.154])
 by ozlabs.org (Postfix) with ESMTP id 882F6140188
 for <linuxppc-dev@ozlabs.org>; Wed, 26 Nov 2014 04:06:53 +1100 (AEDT)
Message-ID: <5474B72A.7040403@osg.samsung.com>
Date: Tue, 25 Nov 2014 10:06:50 -0700
From: Shuah Khan <shuahkh@osg.samsung.com>
MIME-Version: 1.0
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: Re: [V5 7/7] selftests, powerpc: Add test case for TM related ptrace
 interface
References: <1416902731-22446-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1416902731-22446-8-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1416902731-22446-8-git-send-email-khandual@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
Cc: mikey@neuling.org, james.hogan@imgtec.com, avagin@openvz.org,
 Paul.Clothier@imgtec.com, peterz@infradead.org, palves@redhat.com,
 oleg@redhat.com, davem@davemloft.net, dhowells@redhat.com, kirjanov@gmail.com,
 davej@redhat.com, akpm@linux-foundation.org, sukadev@linux.vnet.ibm.com,
 tglx@linutronix.de, sam.bobroff@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/25/2014 01:05 AM, Anshuman Khandual wrote:
> This patch adds one more test case called 'tm-ptrace' targeting TM
> related ptrace interface. This test creates one child process to
> run some basic TM transactions and the parent process attaches the
> child to do some ptrace probing using the recently added regset
> interfaces. The parent process then compares the received values
> against the expected values to verify whether it has passed the
> given test or not.
> 
> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> ---
>  tools/testing/selftests/powerpc/tm/Makefile    |   2 +-
>  tools/testing/selftests/powerpc/tm/tm-ptrace.c | 542 +++++++++++++++++++++++++
>  2 files changed, 543 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/powerpc/tm/tm-ptrace.c
> 
> diff --git a/tools/testing/selftests/powerpc/tm/Makefile b/tools/testing/selftests/powerpc/tm/Makefile
> index 2cede23..71d400a 100644
> --- a/tools/testing/selftests/powerpc/tm/Makefile
> +++ b/tools/testing/selftests/powerpc/tm/Makefile
> @@ -1,4 +1,4 @@
> -PROGS := tm-resched-dscr
> +PROGS := tm-resched-dscr tm-ptrace
>  

Could you please add .gitignore for the binaries in this directory
to avoid git status including the binaries it in its output.

thanks,
-- Shuah

-- 
Shuah Khan
Sr. Linux Kernel Developer
Samsung Research America (Silicon Valley)
shuahkh@osg.samsung.com | (970) 217-8978
