Return-Path: <pbonzini@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id CA8A42C00BC
 for <linuxppc-dev@ozlabs.org>; Thu,  3 Oct 2013 00:33:13 +1000 (EST)
Message-ID: <524C2EAE.7090209@redhat.com>
Date: Wed, 02 Oct 2013 16:33:18 +0200
From: Paolo Bonzini <pbonzini@redhat.com>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 3/3] KVM: PPC: Book3S: Add support for hwrng found on
 some powernv systems
References: <5243F933.7000907@redhat.com> <20131001083426.GB27484@concordia>
 <20131001083908.GA17294@redhat.com> <1380620338.645.22.camel@pasglop>
 <524AAFAA.3010801@redhat.com> <20131002050940.GA25363@drongo>
 <524BDD73.3020106@redhat.com> <1380704789.645.57.camel@pasglop>
 <668E4650-BC22-4CBF-A282-E7875DF29DB6@suse.de>
 <3CBF5732-E7EE-4C96-8132-6D7B77270DAF@suse.de>
 <20131002100224.GF17294@redhat.com> <1380722275.12149.28.camel@concordia>
 <029A8D6C-C23C-42B2-8C26-D76B59E2C9DD@suse.de>
In-Reply-To: <029A8D6C-C23C-42B2-8C26-D76B59E2C9DD@suse.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: tytso@mit.edu, kvm@vger.kernel.org, Gleb Natapov <gleb@redhat.com>,
 linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
 herbert@gondor.hengli.com.au, Paul Mackerras <paulus@samba.org>,
 mpm@selenic.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Il 02/10/2013 16:08, Alexander Graf ha scritto:
> > The hwrng is accessible by host userspace via /dev/mem.
> 
> A guest should live on the same permission level as a user space
> application. If you run QEMU as UID 1000 without access to /dev/mem, why
> should the guest suddenly be able to directly access a memory location
> (MMIO) it couldn't access directly through a normal user space interface.
> 
> It's basically a layering violation.

With Michael's earlier patch in this series, the hwrng is accessible by
host userspace via /dev/hwrng, no?

Paolo
