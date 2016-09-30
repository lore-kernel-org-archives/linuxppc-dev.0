Return-Path: <xinhui@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sld590yL2zDrPw
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Sep 2016 14:00:28 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8U3vhc3071887
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Sep 2016 00:00:26 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25s8st1ghw-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Sep 2016 00:00:26 -0400
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xinhui@linux.vnet.ibm.com>;
 Fri, 30 Sep 2016 00:00:25 -0400
Subject: Re: [PATCH v3 0/4] implement vcpu preempted check
To: Peter Zijlstra <peterz@infradead.org>,
 Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
References: <1469101514-49475-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <20160929101040.GV5016@twins.programming.kicks-ass.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 virtualization@lists.linux-foundation.org, linux-s390@vger.kernel.org,
 xen-devel-request@lists.xenproject.org, kvm@vger.kernel.org,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 mingo@redhat.com, paulmck@linux.vnet.ibm.com, will.deacon@arm.com,
 kernellwp@gmail.com, jgross@suse.com, pbonzini@redhat.com,
 bsingharora@gmail.com
From: Pan Xinhui <xinhui@linux.vnet.ibm.com>
Date: Fri, 30 Sep 2016 12:00:12 +0800
MIME-Version: 1.0
In-Reply-To: <20160929101040.GV5016@twins.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Message-Id: <15710298-7a7b-5c01-6cf6-25c7dc0bcbdc@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



在 2016/9/29 18:10, Peter Zijlstra 写道:
> On Thu, Jul 21, 2016 at 07:45:10AM -0400, Pan Xinhui wrote:
>> change from v2:
>> 	no code change, fix typos, update some comments
>>
>> change from v1:
>> 	a simplier definition of default vcpu_is_preempted
>> 	skip mahcine type check on ppc, and add config. remove dedicated macro.
>> 	add one patch to drop overload of rwsem_spin_on_owner and mutex_spin_on_owner.
>> 	add more comments
>> 	thanks boqun and Peter's suggestion.
>>
>> This patch set aims to fix lock holder preemption issues.
>
> So I really like the concept, but I would also really like to see
> support for more hypervisors included before we can move forward with
> this.
>
> Please consider s390 and (x86/arm) KVM. Once we have a few, more can
> follow later, but I think its important to not only have PPC support for
> this.
>
hi, Peter
	right, we need consider more arches.
I will try to work out a RFC patch on x86 anyway. There are already some discussions of the solution on x86 :)

thanks
xinhui
