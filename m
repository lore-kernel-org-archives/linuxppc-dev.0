Return-Path: <peterz@infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:4978:20e::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w2L3P2h75zDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Apr 2017 18:35:29 +1000 (AEST)
Date: Tue, 11 Apr 2017 10:35:21 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Jin, Yao" <yao.jin@linux.intel.com>
Cc: acme@kernel.org, jolsa@kernel.org, mingo@redhat.com,
 alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
 ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com,
 linuxppc-dev@lists.ozlabs.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3 2/5] perf/x86/intel: Record branch type
Message-ID: <20170411083521.rlnkfz326rwpzs3k@hirez.programming.kicks-ass.net>
References: <1491908193-25418-1-git-send-email-yao.jin@linux.intel.com>
 <1491908193-25418-3-git-send-email-yao.jin@linux.intel.com>
 <20170411075219.bcteozodfkmwo45f@hirez.programming.kicks-ass.net>
 <eff40b15-0da5-f573-1716-d9732ea1fd36@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <eff40b15-0da5-f573-1716-d9732ea1fd36@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Apr 11, 2017 at 04:11:21PM +0800, Jin, Yao wrote:
> 
> 
> On 4/11/2017 3:52 PM, Peter Zijlstra wrote:
> > This is still a completely inadequate changelog. I really will not
> > accept patches like this.
> > 
> Hi,
> 
> The changelog is added in the cover-letter ("[PATCH v3 0/5] perf report: Show branch type").
> 
> Does the changelog need to be added in each patch's description?
> 
> That's fine, I can add and resend this patch.

The cover letter is not retained; it is throw away information.

Each patch should have a coherent changelog that explain why the patch
was done and explain non trivial things in the implementation.

Simply copy/pasting the same story in multiple patches is not right
either, for the simple fact that the patches were not the same. You did
a different thing, so you need a different story.
