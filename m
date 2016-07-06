Return-Path: <peterz@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:1868:205::9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rktvg662NzDqy7
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jul 2016 18:19:27 +1000 (AEST)
Date: Wed, 6 Jul 2016 10:19:20 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Juergen Gross <jgross@suse.com>
Cc: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 virtualization@lists.linux-foundation.org,
 linux-s390@vger.kernel.org, mingo@redhat.com, mpe@ellerman.id.au,
 paulus@samba.org, benh@kernel.crashing.org,
 paulmck@linux.vnet.ibm.com, waiman.long@hpe.com,
 will.deacon@arm.com, boqun.feng@gmail.com, dave@stgolabs.net,
 schwidefsky@de.ibm.com, pbonzini@redhat.com,
 xen-devel-request@lists.xenproject.org
Subject: Re: [PATCH v2 0/4] implement vcpu preempted check
Message-ID: <20160706081920.GG30921@twins.programming.kicks-ass.net>
References: <1467124991-13164-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <20160706065255.GH30909@twins.programming.kicks-ass.net>
 <577CB786.8000902@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <577CB786.8000902@suse.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 06, 2016 at 09:47:18AM +0200, Juergen Gross wrote:
> On 06/07/16 08:52, Peter Zijlstra wrote:

> > Paolo, could you help out with an (x86) KVM interface for this?
> 
> Xen support of this interface should be rather easy. Could you please
> Cc: xen-devel-request@lists.xenproject.org in the next version?

So meta question; aren't all you virt people looking at the regular
virtualization list? Or should we really dig out all the various
hypervisor lists and Cc them?
