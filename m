Return-Path: <peterz@infradead.org>
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:770:15f::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0E3FB1A09FE
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Mar 2016 22:59:48 +1100 (AEDT)
Date: Wed, 2 Mar 2016 12:59:42 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 acme@kernel.org, mingo@redhat.com, paulus@samba.org
Subject: Re: hw_breakpoint: Fix Oops at destroying hw_breakpoint event on
 powerpc
Message-ID: <20160302115942.GC6356@twins.programming.kicks-ass.net>
References: <1456912517-5711-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
 <20160302115324.63B35140BF5@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160302115324.63B35140BF5@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 02, 2016 at 10:53:24PM +1100, Michael Ellerman wrote:
> Peterz, acme, do you guys want to take this? Or should I?

I'm not too happy its touching event->ctx at all. It really should not
be doing that.
