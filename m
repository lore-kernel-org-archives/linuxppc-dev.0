Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0E3B81A05C7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jun 2015 08:37:46 +1000 (AEST)
In-Reply-To: <1434012217-9776-9-git-send-email-maddy@linux.vnet.ibm.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, benh@kernel.crashing.org,
 paulus@samba.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, rusty@rustcorp.com.au,
 linux-kernel@vger.kernel.org, eranian@google.com,
 Janani <jananive@linux.vnet.ibm.com>, sukadev@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, khandual@linux.vnet.ibm.com
Subject: Re: [8/8] powerpc/perf: cleanup in perf_event_print_debug()
Message-Id: <20150625223745.DD63F1401E7@ozlabs.org>
Date: Fri, 26 Jun 2015 08:37:45 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-11-06 at 08:43:37 UTC, Madhavan Srinivasan wrote:
> From: Janani <jananive@linux.vnet.ibm.com>
> 
> Code cleanup/fix in perf_event_print_debug(). Performance
> Monitoring Unit (PMU) registers in the server side
> are 64bit long.

No they're not, see the ISA, figure 17.

cheers
