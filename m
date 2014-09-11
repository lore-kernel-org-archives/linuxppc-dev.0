Return-Path: <peterz@infradead.org>
Received: from casper.infradead.org (casper.infradead.org [85.118.1.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E20521A001B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Sep 2014 01:53:20 +1000 (EST)
Date: Thu, 11 Sep 2014 17:53:03 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Aaron Tomlin <atomlin@redhat.com>
Subject: Re: [PATCH v3 0/3] sched: Always check the integrity of the canary
Message-ID: <20140911155303.GI4783@worktop.ger.corp.intel.com>
References: <1410255749-2956-1-git-send-email-atomlin@redhat.com>
 <1410450088-18236-1-git-send-email-atomlin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1410450088-18236-1-git-send-email-atomlin@redhat.com>
Cc: dzickus@redhat.com, jcastillo@redhat.com, riel@redhat.com, x86@kernel.org,
 akpm@linux-foundation.org, mingo@kernel.com, bmr@redhat.com, prarit@redhat.com,
 oleg@redhat.com, rostedt@goodmis.org, linux-kernel@vger.kernel.org,
 minchan@kernel.org, mingo@redhat.com, aneesh.kumar@linux.vnet.ibm.com,
 akpm@google.com, hannes@cmpxchg.org, jgh@redhat.com,
 linuxppc-dev@lists.ozlabs.org, tglx@linutronix.de, pzijlstr@redhat.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


What's with the threading all versions together? Please don't do that --
also don't post a new version just for this though.
