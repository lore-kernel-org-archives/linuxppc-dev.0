Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r4CYh0jn0zDq5s
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 May 2016 07:48:40 +1000 (AEST)
In-Reply-To: <20160301054739.15714.191.stgit@mars.in.ibm.com>
To: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
Subject: Re: [v2, 2/3] powernv: Rename pSeries to powenv from
 machine_check_pSeries_early.
Message-Id: <3r4CYg4NDvz9t4h@ozlabs.org>
Date: Wed, 11 May 2016 07:48:39 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-01-03 at 05:47:46 UTC, Mahesh Salgaonkar wrote:
> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> 
> The routine machine_check_pSeries_early() is only used on powernv, not
> pseries. Hence rename machine_check_pSeries_early to
> machine_check_powernv_early.
> 
> Reported-by: Paul Mackerras <paulus@samba.org>
> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/d389b7082652871c62da021c11

cheers
