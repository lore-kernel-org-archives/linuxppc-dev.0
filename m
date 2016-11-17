Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tKKXv0vbDzDvsL
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2016 23:03:59 +1100 (AEDT)
In-Reply-To: <1475202784-5653-13-git-send-email-wei.guo.simon@gmail.com>
To: Simon Guo <wei.guo.simon@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Michael Neuling <mikey@neuling.org>, linux-kselftest@vger.kernel.org,
 Jack Miller <jack@codezen.org>, Simon Guo <wei.guo.simon@gmail.com>,
 Chris Smart <chris@distroguy.com>, Rashmica Gupta <rashmicy@gmail.com>,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>, Shuah Khan <shuah@kernel.org>,
 Cyril Bur <cyrilbur@gmail.com>, linux-kernel@vger.kernel.org,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [v15, 12/15] selftests/powerpc: Add ptrace tests for VSX,
 VMX registers in suspended TM
Message-Id: <3tKKXt6Z28z9t1T@ozlabs.org>
Date: Thu, 17 Nov 2016 23:03:58 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-30-09 at 02:33:01 UTC, Simon Guo wrote:
> From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> 
> This patch adds ptrace interface test for VSX, VMX registers
> inside suspended TM context.
> 
> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/a18b55bf51b32136fb9c5190b1cbf8

cheers
