Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tKKXs6cvRzDvsP
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2016 23:03:57 +1100 (AEDT)
In-Reply-To: <1475202784-5653-12-git-send-email-wei.guo.simon@gmail.com>
To: Simon Guo <wei.guo.simon@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Michael Neuling <mikey@neuling.org>, linux-kselftest@vger.kernel.org,
 Jack Miller <jack@codezen.org>, Simon Guo <wei.guo.simon@gmail.com>,
 Chris Smart <chris@distroguy.com>, Rashmica Gupta <rashmicy@gmail.com>,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>, Shuah Khan <shuah@kernel.org>,
 Cyril Bur <cyrilbur@gmail.com>, linux-kernel@vger.kernel.org,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [v15, 11/15] selftests/powerpc: Add ptrace tests for VSX,
 VMX registers in TM
Message-Id: <3tKKXs5R6Hz9t2b@ozlabs.org>
Date: Thu, 17 Nov 2016 23:03:57 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-30-09 at 02:33:00 UTC, Simon Guo wrote:
> From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> 
> This patch adds ptrace interface test for VSX, VMX registers
> inside TM context. This also adds ptrace interface based helper
> functions related to chckpointed VSX, VMX registers access.
> 
> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/11508074c9a74a00df1aa6cfba81d1

cheers
