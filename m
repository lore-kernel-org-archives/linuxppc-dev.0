Return-Path: <peterz@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 55A391400DB
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Apr 2014 19:07:03 +1000 (EST)
Date: Mon, 28 Apr 2014 11:06:49 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: Re: [PATCH V3 1/2] mm: move FAULT_AROUND_ORDER to arch/
Message-ID: <20140428090649.GD27561@twins.programming.kicks-ass.net>
References: <1398675690-16186-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1398675690-16186-2-git-send-email-maddy@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1398675690-16186-2-git-send-email-maddy@linux.vnet.ibm.com>
Cc: linux-arch@vger.kernel.org, riel@redhat.com, rusty@rustcorp.com.au,
 dave.hansen@intel.com, x86@kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, ak@linux.intel.com, paulus@samba.org, mgorman@suse.de,
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

On Mon, Apr 28, 2014 at 02:31:29PM +0530, Madhavan Srinivasan wrote:
> +unsigned int fault_around_order = CONFIG_FAULT_AROUND_ORDER;

__read_mostly?
