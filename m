Return-Path: <bigeasy@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2001:470:1f0b:db:abcd:42:0:1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5B70B1A02E4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Feb 2015 03:36:58 +1100 (AEDT)
Date: Wed, 25 Feb 2015 17:36:49 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 0/2] powerpc/kvm: Enable running guests on RT Linux
Message-ID: <20150225163649.GD6823@linutronix.de>
References: <1424251955-308-1-git-send-email-bogdan.purcareata@freescale.com>
 <54E73A6C.9080500@suse.de> <54E740E7.5090806@redhat.com>
 <54E74A8C.30802@linutronix.de>
 <1424734051.4698.17.camel@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1424734051.4698.17.camel@freescale.com>
Cc: linux-rt-users@vger.kernel.org, Alexander Graf <agraf@suse.de>,
 linux-kernel@vger.kernel.org,
 Bogdan Purcareata <bogdan.purcareata@freescale.com>,
 mihai.caraman@freescale.com, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Scott Wood | 2015-02-23 17:27:31 [-0600]:

>This isn't a host PIC driver.  It's guest PIC emulation, some of which
>is indeed not suitable for a rawlock (in particular, openpic_update_irq
>which loops on the number of vcpus, with a loop body that calls
>IRQ_check() which loops over all pending IRQs).  The vcpu limits are a
>temporary bandaid to avoid the worst latencies, but I'm still skeptical
>about this being upstream material.

Okay.

>-Scott

Sebastian
