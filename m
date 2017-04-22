Return-Path: <michaele@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w92K130sQzDq5b
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Apr 2017 16:10:29 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3M68irX081541
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Apr 2017 02:10:26 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29ygy2w5nr-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Apr 2017 02:10:26 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <michaele@au1.ibm.com>;
 Sat, 22 Apr 2017 16:10:23 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3M6ACOJ62914782
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Apr 2017 16:10:20 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3M69j8h029500
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Apr 2017 16:09:47 +1000
From: Michael Ellerman <michaele@au1.ibm.com>
To: paulmck@linux.vnet.ibm.com, Paolo Bonzini <pbonzini@redhat.com>
Cc: mingo@kernel.org, kvm@vger.kernel.org, peterz@infradead.org,
 fweisbec@gmail.com, jiangshanlai@gmail.com, oleg@redhat.com,
 kvm-ppc@vger.kernel.org, linux-kernel@vger.kernel.org,
 dhowells@redhat.com, edumazet@google.com,
 "paulus\@samba.org" <paulus@samba.org>, rostedt@goodmis.org,
 akpm@linux-foundation.org, dipankar@in.ibm.com,
 mathieu.desnoyers@efficios.com, tglx@linutronix.de,
 "linuxppc-dev\@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 bobby.prani@gmail.com, josh@joshtriplett.org
Subject: Re: powerpc KVM build break in linux-next (was Re: [PATCH
 tip/core/rcu 40/40] srcu: Parallelize callback handling)
In-Reply-To: <20170421125135.GW3956@linux.vnet.ibm.com>
References: <20170412174003.GA23207@linux.vnet.ibm.com>
 <1492018825-25634-40-git-send-email-paulmck@linux.vnet.ibm.com>
 <871ssn692a.fsf@concordia.ellerman.id.au>
 <24c85d26-bb4b-892d-5837-6d02af570e0e@redhat.com>
 <20170421003834.GA14351@linux.vnet.ibm.com>
 <87zifatu3a.fsf@concordia.ellerman.id.au>
 <20170421041754.GV3956@linux.vnet.ibm.com>
 <ca07b47e-8141-1691-169d-16c99d03902a@redhat.com>
 <20170421125135.GW3956@linux.vnet.ibm.com>
Date: Sat, 22 Apr 2017 16:09:21 +1000
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87d1c5ynvy.fsf@concordia.ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Paul E. McKenney" <paulmck@linux.vnet.ibm.com> writes:
> On Fri, Apr 21, 2017 at 09:27:59AM +0200, Paolo Bonzini wrote:
>> On 21/04/2017 06:17, Paul E. McKenney wrote:
>> >> Thanks, this looks perfect to me, and if you're happy to put it on top
>> >> of your tree that would limit the breakage to a smaller history window,
>> >> so that would be ideal.
>> >>
>> >> Tested-by: Michael Ellerman <mpe@ellerman.id.au>
>> > Thank you, Michael!
>> > 
>> > Paolo, does this look good to you?  My upstream maintainer will be much
>> > more likely to take this with your ack.  ;-)
>> 
>> Sure,
>> 
>> Acked-by: Paolo Bonzini <pbonzini@redhat.com>
>> 
>> since I don't expect conflicts between whoever applies this patch and
>> the KVM tree.
>
> Applied, thank you!

Thanks all.

cheers
