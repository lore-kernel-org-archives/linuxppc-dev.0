Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tKKXr6XTHzDvsV
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2016 23:03:56 +1100 (AEDT)
In-Reply-To: <1475202784-5653-11-git-send-email-wei.guo.simon@gmail.com>
To: Simon Guo <wei.guo.simon@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Michael Neuling <mikey@neuling.org>, linux-kselftest@vger.kernel.org,
 Jack Miller <jack@codezen.org>, Simon Guo <wei.guo.simon@gmail.com>,
 Chris Smart <chris@distroguy.com>, Rashmica Gupta <rashmicy@gmail.com>,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>, Shuah Khan <shuah@kernel.org>,
 Cyril Bur <cyrilbur@gmail.com>, linux-kernel@vger.kernel.org,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [v15, 10/15] selftests/powerpc: Add ptrace tests for VSX,
 VMX registers
Message-Id: <3tKKXr5SR3z9t2n@ozlabs.org>
Date: Thu, 17 Nov 2016 23:03:56 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-30-09 at 02:32:59 UTC, Simon Guo wrote:
> From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> 
> This patch adds ptrace interface test for VSX, VMX registers.
> This also adds ptrace interface based helper functions related
> to VSX, VMX registers access. This also adds some assembly
> helper functions related to VSX and VMX registers.
> 
> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/0da535c0844b81111f837670e0b9b3

cheers
