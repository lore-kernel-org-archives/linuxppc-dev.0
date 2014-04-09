Return-Path: <dave.hansen@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by ozlabs.org (Postfix) with ESMTP id 8A193140100
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Apr 2014 01:51:57 +1000 (EST)
Message-ID: <53456BE2.90905@intel.com>
Date: Wed, 09 Apr 2014 08:48:50 -0700
From: Dave Hansen <dave.hansen@intel.com>
MIME-Version: 1.0
To: Peter Zijlstra <peterz@infradead.org>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: Re: [PATCH V2 1/2] mm: move FAULT_AROUND_ORDER to arch/
References: <1396592835-24767-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1396592835-24767-2-git-send-email-maddy@linux.vnet.ibm.com>
 <533EDB63.8090909@intel.com> <5344A312.80802@linux.vnet.ibm.com>
 <20140409082008.GA10526@twins.programming.kicks-ass.net>
In-Reply-To: <20140409082008.GA10526@twins.programming.kicks-ass.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-arch@vger.kernel.org, riel@redhat.com, rusty@rustcorp.com.au,
 x86@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 ak@linux.intel.com, paulus@samba.org, mgorman@suse.de,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org, mingo@kernel.org,
 kirill.shutemov@linux.intel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/09/2014 01:20 AM, Peter Zijlstra wrote:
> This still misses out on Ben's objection that its impossible to get this
> right at compile time for many kernels, since they can boot and run on
> many different subarchs.

Completely agree.  The Kconfig-time stuff should probably just be a knob
to turn it off completely, if anything.
