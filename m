Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D84251A02EE
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Mar 2016 11:30:41 +1100 (AEDT)
In-Reply-To: <20160216232427.GA27660@us.ibm.com>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [1/2] powerpc/perf/hv-24x7: Display domain indices in sysfs
Message-Id: <20160311003041.B7A55140C39@ozlabs.org>
Date: Fri, 11 Mar 2016 11:30:41 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-16-02 at 23:24:27 UTC, Sukadev Bhattiprolu wrote:
> >From aff5a822e873522b9a3f355f816547394b452a64 Mon Sep 17 00:00:00 2001
> From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> Date: Tue, 16 Feb 2016 20:07:51 -0500
> Subject: [PATCH 1/2] powerpc/perf/hv-24x7: Display domain indices in sysfs
> 
> To help users determine domains, display the domain indices used by the
> kernel in sysfs.
> 
> 	$ cat /sys/bus/event_source/devices/hv_24x7/interface/domains
> 	1: Physical Chip
> 	2: Physical Core
> 	3: VCPU Home Core
> 	4: VCPU Home Chip
> 	5: VCPU Home Node
> 	6: VCPU Remote Node
> 
> Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/d34171e88aeed4a99c00c7f2af

cheers
