Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tKKXj0qyGzDvs0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2016 23:03:49 +1100 (AEDT)
In-Reply-To: <1475202784-5653-4-git-send-email-wei.guo.simon@gmail.com>
To: Simon Guo <wei.guo.simon@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Michael Neuling <mikey@neuling.org>, linux-kselftest@vger.kernel.org,
 Jack Miller <jack@codezen.org>, Simon Guo <wei.guo.simon@gmail.com>,
 Chris Smart <chris@distroguy.com>, Rashmica Gupta <rashmicy@gmail.com>,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>, Shuah Khan <shuah@kernel.org>,
 Cyril Bur <cyrilbur@gmail.com>, linux-kernel@vger.kernel.org,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [v15,03/15] selftests/powerpc: Add ptrace tests for EBB
Message-Id: <3tKKXh65zmz9t1d@ozlabs.org>
Date: Thu, 17 Nov 2016 23:03:48 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-30-09 at 02:32:52 UTC, Simon Guo wrote:
> From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> 
> This patch adds ptrace interface test for EBB/PMU specific
> registers. This also adds some generic ptrace interface
> based helper functions to be used by other patches later
> on in the series.
> 
> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/f666ad413db6f7fbfaeec6b11ed6f8

cheers
