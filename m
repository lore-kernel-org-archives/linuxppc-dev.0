Return-Path: <michael@ozlabs.org>
In-Reply-To: <1389916434-2288-6-git-send-email-cody@linux.vnet.ibm.com>
To: Cody P Schafer <cody@linux.vnet.ibm.com>,
 Linux PPC <linuxppc-dev@lists.ozlabs.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 5/8] powerpc: add 24x7 interface header
Message-Id: <20140201055807.8E65F2C00C7@ozlabs.org>
Date: Sat,  1 Feb 2014 16:58:07 +1100 (EST)
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>,
 LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Paul Mackerras <paulus@samba.org>,
 Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
 Cody P Schafer <cody@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-16-01 at 23:53:51 UTC, Cody P Schafer wrote:
> 24x7 (also called hv_24x7 or H_24X7) is an interface to obtain
> performance counters from the hypervisor. These counters do not have a
> fixed format/possition and are instead documented in a "24x7 Catalog",
> which is provided by the hypervisor (that interface is also documented
> in this header).
> 
> This method of obtaining performance counters from the hypervisor is
> intended to paritialy replace the gpci interface.

Same comments as for the previous patch.

cheers
