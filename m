Return-Path: <peterz@infradead.org>
Received: from merlin.infradead.org (unknown [IPv6:2001:4978:20e::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7F2792C00C3
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Mar 2014 22:16:33 +1100 (EST)
Date: Wed, 5 Mar 2014 12:16:15 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 0/2] sched: Removed unused mc_capable() and smt_capable()
Message-ID: <20140305111615.GV9987@twins.programming.kicks-ass.net>
References: <20140304210621.16893.8772.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140304210621.16893.8772.stgit@bhelgaas-glaptop.roam.corp.google.com>
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
 sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 04, 2014 at 02:07:31PM -0700, Bjorn Helgaas wrote:
> This is just cleanup of a couple unused interfaces and (for sparc64) a
> supporting variable.
> 

Thanks!
