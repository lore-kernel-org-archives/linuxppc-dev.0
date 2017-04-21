Return-Path: <pbonzini@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w8S5P6drjzDq66
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Apr 2017 17:28:25 +1000 (AEST)
Subject: Re: powerpc KVM build break in linux-next (was Re: [PATCH
 tip/core/rcu 40/40] srcu: Parallelize callback handling)
To: paulmck@linux.vnet.ibm.com, Michael Ellerman <michaele@au1.ibm.com>
References: <20170412174003.GA23207@linux.vnet.ibm.com>
 <1492018825-25634-40-git-send-email-paulmck@linux.vnet.ibm.com>
 <871ssn692a.fsf@concordia.ellerman.id.au>
 <24c85d26-bb4b-892d-5837-6d02af570e0e@redhat.com>
 <20170421003834.GA14351@linux.vnet.ibm.com>
 <87zifatu3a.fsf@concordia.ellerman.id.au>
 <20170421041754.GV3956@linux.vnet.ibm.com>
Cc: tglx@linutronix.de, kvm@vger.kernel.org, oleg@redhat.com,
 peterz@infradead.org, fweisbec@gmail.com, bobby.prani@gmail.com,
 jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
 kvm-ppc@vger.kernel.org, josh@joshtriplett.org, dhowells@redhat.com,
 edumazet@google.com, "paulus@samba.org" <paulus@samba.org>,
 rostedt@goodmis.org, dipankar@in.ibm.com,
 mathieu.desnoyers@efficios.com, akpm@linux-foundation.org,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 mingo@kernel.org
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ca07b47e-8141-1691-169d-16c99d03902a@redhat.com>
Date: Fri, 21 Apr 2017 09:27:59 +0200
MIME-Version: 1.0
In-Reply-To: <20170421041754.GV3956@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 21/04/2017 06:17, Paul E. McKenney wrote:
>> Thanks, this looks perfect to me, and if you're happy to put it on top
>> of your tree that would limit the breakage to a smaller history window,
>> so that would be ideal.
>>
>> Tested-by: Michael Ellerman <mpe@ellerman.id.au>
> Thank you, Michael!
> 
> Paolo, does this look good to you?  My upstream maintainer will be much
> more likely to take this with your ack.  ;-)

Sure,

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

since I don't expect conflicts between whoever applies this patch and
the KVM tree.

Paolo
