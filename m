Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w8bGT53yKzDq66
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Apr 2017 22:51:45 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3LCmrWo073768
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Apr 2017 08:51:43 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29y5c6e6y5-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Apr 2017 08:51:43 -0400
Received: from localhost
 by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Fri, 21 Apr 2017 08:51:42 -0400
Date: Fri, 21 Apr 2017 05:51:35 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Michael Ellerman <michaele@au1.ibm.com>, tglx@linutronix.de,
 kvm@vger.kernel.org, oleg@redhat.com, peterz@infradead.org,
 fweisbec@gmail.com, bobby.prani@gmail.com, jiangshanlai@gmail.com,
 linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
 josh@joshtriplett.org, dhowells@redhat.com, edumazet@google.com,
 "paulus@samba.org" <paulus@samba.org>, rostedt@goodmis.org,
 dipankar@in.ibm.com, mathieu.desnoyers@efficios.com,
 akpm@linux-foundation.org,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 mingo@kernel.org
Subject: Re: powerpc KVM build break in linux-next (was Re: [PATCH
 tip/core/rcu 40/40] srcu: Parallelize callback handling)
Reply-To: paulmck@linux.vnet.ibm.com
References: <20170412174003.GA23207@linux.vnet.ibm.com>
 <1492018825-25634-40-git-send-email-paulmck@linux.vnet.ibm.com>
 <871ssn692a.fsf@concordia.ellerman.id.au>
 <24c85d26-bb4b-892d-5837-6d02af570e0e@redhat.com>
 <20170421003834.GA14351@linux.vnet.ibm.com>
 <87zifatu3a.fsf@concordia.ellerman.id.au>
 <20170421041754.GV3956@linux.vnet.ibm.com>
 <ca07b47e-8141-1691-169d-16c99d03902a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ca07b47e-8141-1691-169d-16c99d03902a@redhat.com>
Message-Id: <20170421125135.GW3956@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Apr 21, 2017 at 09:27:59AM +0200, Paolo Bonzini wrote:
> 
> 
> On 21/04/2017 06:17, Paul E. McKenney wrote:
> >> Thanks, this looks perfect to me, and if you're happy to put it on top
> >> of your tree that would limit the breakage to a smaller history window,
> >> so that would be ideal.
> >>
> >> Tested-by: Michael Ellerman <mpe@ellerman.id.au>
> > Thank you, Michael!
> > 
> > Paolo, does this look good to you?  My upstream maintainer will be much
> > more likely to take this with your ack.  ;-)
> 
> Sure,
> 
> Acked-by: Paolo Bonzini <pbonzini@redhat.com>
> 
> since I don't expect conflicts between whoever applies this patch and
> the KVM tree.

Applied, thank you!

							Thanx, Paul
