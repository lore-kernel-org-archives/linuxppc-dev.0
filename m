Return-Path: <gleb@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 452E52C010C
 for <linuxppc-dev@ozlabs.org>; Tue,  1 Oct 2013 18:40:18 +1000 (EST)
Date: Tue, 1 Oct 2013 11:39:08 +0300
From: Gleb Natapov <gleb@redhat.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 3/3] KVM: PPC: Book3S: Add support for hwrng found on
 some powernv systems
Message-ID: <20131001083908.GA17294@redhat.com>
References: <1380177066-3835-1-git-send-email-michael@ellerman.id.au>
 <1380177066-3835-3-git-send-email-michael@ellerman.id.au>
 <5243F933.7000907@redhat.com> <20131001083426.GB27484@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131001083426.GB27484@concordia>
Cc: tytso@mit.edu, kvm@vger.kernel.org, linuxppc-dev@ozlabs.org, agraf@suse.de,
 kvm-ppc@vger.kernel.org, linux-kernel@vger.kernel.org,
 herbert@gondor.hengli.com.au, Paul Mackerras <paulus@samba.org>,
 mpm@selenic.com, Paolo Bonzini <pbonzini@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Oct 01, 2013 at 06:34:26PM +1000, Michael Ellerman wrote:
> On Thu, Sep 26, 2013 at 11:06:59AM +0200, Paolo Bonzini wrote:
> > Il 26/09/2013 08:31, Michael Ellerman ha scritto:
> > > Some powernv systems include a hwrng. Guests can access it via the
> > > H_RANDOM hcall.
> > 
> > Is there any reason to do this in the kernel?  
> 
> It's less code, and it's faster :)
> 
> > It does not have to be a particularly fast path;
> 
> Sure, but do we have to make it slow on purpose?
> 
We do not put non performance critical devices into the kernel.

--
			Gleb.
