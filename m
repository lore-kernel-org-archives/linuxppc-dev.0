Return-Path: <ak@linux.intel.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 33B301A031F
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Apr 2015 09:35:39 +1000 (AEST)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by ozlabs.org (Postfix) with ESMTP id 08168140213
 for <linuxppc-dev@ozlabs.org>; Tue,  7 Apr 2015 09:35:37 +1000 (AEST)
Date: Mon, 6 Apr 2015 16:35:35 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: perf report broken for branch stack samples
Message-ID: <20150406233535.GF15335@tassilo.jf.intel.com>
References: <551BB43E.5070600@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <551BB43E.5070600@linux.vnet.ibm.com>
Cc: Linux PPC dev <linuxppc-dev@ozlabs.org>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Michael Ellerman <michaele@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 01, 2015 at 02:32:54PM +0530, Anshuman Khandual wrote:
> Hello,
> 
> perf report is not showing up the branch stack sample results in the
> from_symbol ---> to_symbol format even if the perf.data file has got
> the samples (through 'perf record -b <workload>' session). Perf report

Sorry for the late answer. This was already fixed in tip by 

commit fefd2d9619de3bf0bf02a8622e9f445c3d19cc3f
Author: He Kuang <hekuang@huawei.com>
Date:   Sun Feb 15 10:33:37 2015 +0800

    perf report: Fix branch stack mode cannot be set

-Andi
