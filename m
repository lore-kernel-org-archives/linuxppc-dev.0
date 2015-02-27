Return-Path: <pbonzini@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5671E1A006F
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Feb 2015 00:06:23 +1100 (AEDT)
Message-ID: <54F06BBB.9050709@redhat.com>
Date: Fri, 27 Feb 2015 14:06:03 +0100
From: Paolo Bonzini <pbonzini@redhat.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 0/2] powerpc/kvm: Enable running guests on RT Linux
References: <1424251955-308-1-git-send-email-bogdan.purcareata@freescale.com>	
 <54E73A6C.9080500@suse.de> <54E740E7.5090806@redhat.com>	
 <54E74A8C.30802@linutronix.de> <1424734051.4698.17.camel@freescale.com>	
 <54EF196E.4090805@redhat.com> <54EF2025.80404@linutronix.de>
 <1424999159.4698.78.camel@freescale.com>
In-Reply-To: <1424999159.4698.78.camel@freescale.com>
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alexander Graf <agraf@suse.de>,
 Bogdan Purcareata <bogdan.purcareata@freescale.com>,
 mihai.caraman@freescale.com, Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 27/02/2015 02:05, Scott Wood wrote:
> Obviously leaving it in a buggy state is not what we want -- but I lean
> towards a short term "fix" of putting "depends on !PREEMPT_RT" on the
> in-kernel MPIC emulation (which is itself just an optimization -- you
> can still use KVM without it).  This way people don't enable it with RT
> without being aware of the issue, and there's more of an incentive to
> fix it properly.

That would indeed work for me.

Paolo
