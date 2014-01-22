Return-Path: <mpe@ellerman.id.au>
Message-ID: <1390354379.11104.3.camel@concordia>
Subject: Re: [PATCH 0/8] Add support for PowerPC Hypervisor supplied
 performance counters
From: Michael Ellerman <mpe@ellerman.id.au>
To: Cody P Schafer <cody@linux.vnet.ibm.com>
Date: Wed, 22 Jan 2014 12:32:59 +1100
In-Reply-To: <1389916434-2288-1-git-send-email-cody@linux.vnet.ibm.com>
References: <1389916434-2288-1-git-send-email-cody@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>,
 LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Paul Mackerras <paulus@samba.org>,
 Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
 Linux PPC <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-01-16 at 15:53 -0800, Cody P Schafer wrote:
> These patches add basic pmus for 2 powerpc hypervisor interfaces to obtain
> performance counters: gpci ("get performance counter info") and 24x7.
> 
> The counters supplied by these interfaces are continually counting and never
> need to be (and cannot be) disabled or enabled. They additionally do not
> generate any interrupts. This makes them in some regards similar to software
> counters, and as a result their implimentation shares some common code (which
> an initial patch exposes) with the sw counters.

Hi Cody,

Can you please add some more explanation of this series.

In particular why do we need two new PMUs, and how do they relate to each
other?

And can you add an example of how I'd actually use them using perf.

cheers
