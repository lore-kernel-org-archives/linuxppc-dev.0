Return-Path: <peterz@infradead.org>
Received: from casper.infradead.org (casper.infradead.org [85.118.1.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C74CC1A0C9E
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Apr 2015 05:10:32 +1100 (AEDT)
Date: Wed, 1 Apr 2015 20:10:23 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: Re: [PATCH 4/4] perf/powerpc: Implement group_read() txn interface
 for 24x7 counters
Message-ID: <20150401181023.GY27490@worktop.programming.kicks-ass.net>
References: <1425458108-3341-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1425458108-3341-5-git-send-email-sukadev@linux.vnet.ibm.com>
 <20150317065733.GN2896@worktop.programming.kicks-ass.net>
 <20150326055705.GA5593@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150326055705.GA5593@us.ibm.com>
Cc: dev@codyps.com, Paul Mackerras <paulus@samba.org>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 25, 2015 at 10:57:05PM -0700, Sukadev Bhattiprolu wrote:
> Would something liks this work?
> 

Sure, that looks fine.

Thanks.
