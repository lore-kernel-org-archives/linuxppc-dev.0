Return-Path: <paolo.bonzini@gmail.com>
Received: from mail-wm0-x242.google.com (mail-wm0-x242.google.com
 [IPv6:2a00:1450:400c:c09::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rl0nd0S8tzDqyj
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jul 2016 22:44:37 +1000 (AEST)
Received: by mail-wm0-x242.google.com with SMTP id 187so35455823wmz.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 Jul 2016 05:44:36 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
Subject: Re: [PATCH v2 0/4] implement vcpu preempted check
To: Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>
References: <1467124991-13164-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <20160706065255.GH30909@twins.programming.kicks-ass.net>
 <577CB786.8000902@suse.com>
 <20160706081920.GG30921@twins.programming.kicks-ass.net>
Cc: linux-s390@vger.kernel.org, xen-devel-request@lists.xenproject.org,
 dave@stgolabs.net, benh@kernel.crashing.org,
 Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>, boqun.feng@gmail.com,
 will.deacon@arm.com, linux-kernel@vger.kernel.org, waiman.long@hpe.com,
 virtualization@lists.linux-foundation.org, mingo@redhat.com,
 paulus@samba.org, mpe@ellerman.id.au, schwidefsky@de.ibm.com,
 paulmck@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <eb0672ba-4a00-f87e-9f01-31537d7497e3@redhat.com>
Date: Wed, 6 Jul 2016 14:44:31 +0200
MIME-Version: 1.0
In-Reply-To: <20160706081920.GG30921@twins.programming.kicks-ass.net>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 06/07/2016 10:19, Peter Zijlstra wrote:
>>> Paolo, could you help out with an (x86) KVM interface for this?
>> > 
>> > Xen support of this interface should be rather easy. Could you please
>> > Cc: xen-devel-request@lists.xenproject.org in the next version?
> So meta question; aren't all you virt people looking at the regular
> virtualization list? Or should we really dig out all the various
> hypervisor lists and Cc them?

I at least skim the subjects.

Paolo
