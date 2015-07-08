Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1EE271A1992
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jul 2015 20:54:08 +1000 (AEST)
In-Reply-To: <1436247946-16292-1-git-send-email-imunsie@au.ibm.com>
To: Ian Munsie <imunsie@au1.ibm.com>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: mikey <mikey@neuling.org>, Matt Ochs <mrochs@us.ibm.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
 linuxppc-dev <linuxppc-dev@ozlabs.org>, Ian Munsie <imunsie@au1.ibm.com>
Subject: Re: [1/2] cxl: Fix off by one error allowing subsequent mmap page to
 be accessed
Message-Id: <20150708105407.D6556140788@ozlabs.org>
Date: Wed,  8 Jul 2015 20:54:07 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-07-07 at 05:45:45 UTC, Ian Munsie wrote:
> From: Ian Munsie <imunsie@au1.ibm.com>
> 
> It was discovered that if a process mmaped their problem state area they
> were able to access one page more than expected, potentially allowing
> them to access the problem state area of an unrelated process.
> 
> This was due to a simple off by one error in the mmap fault handler
> introduced in 0712dc7e73e59d79bcead5d5520acf4e9e917e87 ("cxl: Fix issues
> when unmapping contexts"), which is fixed in this patch.
> 
> Cc: stable@vger.kernel.org
> Fixes: 0712dc7e73e5 ("cxl: Fix issues when unmapping contexts")
> Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/cgit/linux/kernel/git/powerpc/linux.git/commit/?h=fixes&id=10a5894f2dedd8a26b3132497445b314c0d952c4

cheers
