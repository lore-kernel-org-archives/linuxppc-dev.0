Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sqmQY3ZFXzDrSN
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Oct 2016 08:44:53 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: wei.guo.simon@gmail.com, linuxppc-dev@lists.ozlabs.org
Cc: Shuah Khan <shuah@kernel.org>, Cyril Bur <cyrilbur@gmail.com>,
 Chris Smart <chris@distroguy.com>,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
 Michael Neuling <mikey@neuling.org>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Simon Guo <wei.guo.simon@gmail.com>, Jack Miller <jack@codezen.org>,
 Rashmica Gupta <rashmicy@gmail.com>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v15 03/15] selftests/powerpc: Add ptrace tests for EBB
In-Reply-To: <1475202784-5653-4-git-send-email-wei.guo.simon@gmail.com>
References: <1475202784-5653-1-git-send-email-wei.guo.simon@gmail.com>
 <1475202784-5653-4-git-send-email-wei.guo.simon@gmail.com>
Date: Fri, 07 Oct 2016 08:44:48 +1100
Message-ID: <8760p5duen.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

wei.guo.simon@gmail.com writes:

> From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
>
> This patch adds ptrace interface test for EBB/PMU specific
> registers. This also adds some generic ptrace interface
> based helper functions to be used by other patches later
> on in the series.

This is consistently failing for me on a P8 Tuleta (pvr 004b 0201):

# ./ptrace-ebb 
test: ptrace_ebb_pmu
tags: git_version:v4.8-rc5-176-g89cf1de0ae90
EBBRR: 100059f8
EBBHR: 100053cc; expected: 100053cc
BESCR: 8000000100000000
SIAR:  100012d0
SDAR:  3fff7e4cc000
SIER:  3000000; expected: 2000000
MMCR2: 0; expected: 0
MMCR0: 180000080; expected: 180000080
failure: ptrace_ebb_pmu

cheers
