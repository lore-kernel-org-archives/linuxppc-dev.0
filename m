Return-Path: <borntraeger@de.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rl6Nt70QPzDr04
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jul 2016 02:57:02 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u66Gtj8F067073
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Jul 2016 12:57:00 -0400
Received: from e06smtp08.uk.ibm.com (e06smtp08.uk.ibm.com [195.75.94.104])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2415xkg12q-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 Jul 2016 12:57:00 -0400
Received: from localhost
 by e06smtp08.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <borntraeger@de.ibm.com>;
 Wed, 6 Jul 2016 17:56:58 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 7FA8B17D8042
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jul 2016 17:58:19 +0100 (BST)
Received: from d06av11.portsmouth.uk.ibm.com (d06av11.portsmouth.uk.ibm.com
 [9.149.37.252])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u66Guuvl23920954
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Jul 2016 16:56:56 GMT
Received: from d06av11.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av11.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u66GusnE024804
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Jul 2016 10:56:55 -0600
Subject: Re: [PATCH v2 0/4] implement vcpu preempted check
To: Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>
References: <1467124991-13164-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <20160706065255.GH30909@twins.programming.kicks-ass.net>
 <577CB786.8000902@suse.com>
 <20160706081920.GG30921@twins.programming.kicks-ass.net>
Cc: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org,
 virtualization@lists.linux-foundation.org, linux-s390@vger.kernel.org,
 mingo@redhat.com, mpe@ellerman.id.au, paulus@samba.org,
 benh@kernel.crashing.org, paulmck@linux.vnet.ibm.com,
 waiman.long@hpe.com, will.deacon@arm.com, boqun.feng@gmail.com,
 dave@stgolabs.net, schwidefsky@de.ibm.com, pbonzini@redhat.com,
 xen-devel-request@lists.xenproject.org,
 Martin Schwidefsky <schwidefsky@de.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 6 Jul 2016 18:56:52 +0200
MIME-Version: 1.0
In-Reply-To: <20160706081920.GG30921@twins.programming.kicks-ass.net>
Content-Type: text/plain; charset=windows-1252
Message-Id: <577D3854.6090407@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/06/2016 10:19 AM, Peter Zijlstra wrote:
> On Wed, Jul 06, 2016 at 09:47:18AM +0200, Juergen Gross wrote:
>> On 06/07/16 08:52, Peter Zijlstra wrote:
> 
>>> Paolo, could you help out with an (x86) KVM interface for this?
>>
>> Xen support of this interface should be rather easy. Could you please
>> Cc: xen-devel-request@lists.xenproject.org in the next version?
> 
> So meta question; aren't all you virt people looking at the regular
> virtualization list? Or should we really dig out all the various
> hypervisor lists and Cc them?
> 

Some of the kvm on s390 team reads this, but I would assume that the base s390 team
does not (Martin can you confirm?) as the main focus was z/VM and LPAR. So maybe adding
linux-s390@vger for generic things does make sense.
