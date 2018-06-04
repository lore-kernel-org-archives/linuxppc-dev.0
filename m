Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40zxgC4lDqzF0dm
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jun 2018 00:11:03 +1000 (AEST)
In-Reply-To: <20180521042108.8318-2-ravi.bangoria@linux.ibm.com>
To: Ravi Bangoria <ravi.bangoria@linux.ibm.com>, mikey@neuling.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: sandipan@linux.vnet.ibm.com, Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
 linux-kernel@vger.kernel.org, matthew.brown.dev@gmail.com, paulus@samba.org,
 anton@samba.org, naveen.n.rao@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, cyrilbur@gmail.com
Subject: Re: [1/3] powerpc/sstep: Introduce GETTYPE macro
Message-Id: <40zxg85MWNz9s5c@ozlabs.org>
Date: Tue,  5 Jun 2018 00:11:00 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2018-05-21 at 04:21:06 UTC, Ravi Bangoria wrote:
> Replace 'op->type & INSTR_TYPE_MASK' expression with GETTYPE(op->type)
> macro.
> 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/e6684d07e4308430b9b6497265781a

cheers
