Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 79C321A09DC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Feb 2015 10:35:06 +1100 (AEDT)
In-Reply-To: <20150203062810.13207.93694.stgit@preeti.in.ibm.com>
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: driver/cpuidle-powernv: Avoid endianness conversions while
 parsing DT
Message-Id: <20150218233506.4B5411400F1@ozlabs.org>
Date: Thu, 19 Feb 2015 10:35:06 +1100 (AEDT)
Cc: stewart@linux.vnet.ibm.com, rafael.j.wysocki@intel.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-03-02 at 06:31:15 UTC, Preeti U Murthy wrote:
> We currently read the information about idle states from the DT
> so as to populate the cpuidle table. Use those APIs to read from
> the DT that can avoid endianness conversions of the property values
> in the cpuidle driver.
> 
> Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
