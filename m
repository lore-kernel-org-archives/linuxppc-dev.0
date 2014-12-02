Return-Path: <shuahkh@osg.samsung.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2F2C51A021F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Dec 2014 05:23:33 +1100 (AEDT)
Received: from lists.s-osg.org (lists.s-osg.org [54.187.51.154])
 by ozlabs.org (Postfix) with ESMTP id DD29D140161
 for <linuxppc-dev@ozlabs.org>; Wed,  3 Dec 2014 05:23:31 +1100 (AEDT)
Message-ID: <547E039F.7070509@osg.samsung.com>
Date: Tue, 02 Dec 2014 11:23:27 -0700
From: Shuah Khan <shuahkh@osg.samsung.com>
MIME-Version: 1.0
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH V6 9/9] selftests: Make GIT ignore all binaries in powerpc
 test suite
References: <1417507013-11948-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1417507013-11948-10-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1417507013-11948-10-git-send-email-khandual@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
Cc: Shuah Khan <shuahkh@osg.samsung.com>, mikey@neuling.org,
 james.hogan@imgtec.com, avagin@openvz.org, Paul.Clothier@imgtec.com,
 peterz@infradead.org, palves@redhat.com, oleg@redhat.com, davem@davemloft.net,
 dhowells@redhat.com, kirjanov@gmail.com, davej@redhat.com,
 akpm@linux-foundation.org, sukadev@linux.vnet.ibm.com, tglx@linutronix.de,
 sam.bobroff@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/02/2014 12:56 AM, Anshuman Khandual wrote:
> This patch includes all of the powerpc test binaries into the
> .gitignore file listing in their respective directories. This
> will make sure that GIT ignores all of these test binaries while
> displaying status.
> 
> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> ---
>  .../testing/selftests/powerpc/copyloops/.gitignore |  4 ++++
>  tools/testing/selftests/powerpc/mm/.gitignore      |  1 +
>  tools/testing/selftests/powerpc/pmu/.gitignore     |  3 +++
>  tools/testing/selftests/powerpc/pmu/ebb/.gitignore | 22 ++++++++++++++++++++++
>  .../selftests/powerpc/primitives/.gitignore        |  1 +
>  5 files changed, 31 insertions(+)
>  create mode 100644 tools/testing/selftests/powerpc/copyloops/.gitignore
>  create mode 100644 tools/testing/selftests/powerpc/mm/.gitignore
>  create mode 100644 tools/testing/selftests/powerpc/pmu/.gitignore
>  create mode 100644 tools/testing/selftests/powerpc/pmu/ebb/.gitignore
>  create mode 100644 tools/testing/selftests/powerpc/primitives/.gitignore
> 

Creating a single .gitignore at tools/testing/selftests/powerpc will
make this simpler without having to add one .gitignore for each
directory underneath.

Thanks for taking on the task to add .gitignore for all powerpc
binaries.

-- Shuah


-- 
Shuah Khan
Sr. Linux Kernel Developer
Samsung Research America (Silicon Valley)
shuahkh@osg.samsung.com | (970) 217-8978
