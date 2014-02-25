Return-Path: <michael@ozlabs.org>
In-Reply-To: <1392415338-16288-6-git-send-email-cody@linux.vnet.ibm.com>
To: Cody P Schafer <cody@linux.vnet.ibm.com>,
 Linux PPC <linuxppc-dev@lists.ozlabs.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v2 05/11] powerpc: add hv_gpci interface header
Message-Id: <20140225033328.1D5652C030B@ozlabs.org>
Date: Tue, 25 Feb 2014 14:33:27 +1100 (EST)
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>,
 LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Paul Mackerras <paulus@samba.org>,
 Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-14-02 at 22:02:09 UTC, Cody P Schafer wrote:
> "H_GetPerformanceCounterInfo" (refered to as hv_gpci or just gpci from
> here on) is an interface to retrieve specific performance counters and
> other data from the hypervisor. All outputs have a fixed format (and
> are represented as structs in this patch).

I still see unused stuff in here, can you strip it back to just what we need.
Same goes for the next patch.

cheers
