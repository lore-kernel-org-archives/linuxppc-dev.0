Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 2FF4D2C007A
 for <linuxppc-dev@ozlabs.org>; Thu,  3 Oct 2013 17:23:21 +1000 (EST)
Message-ID: <1380784979.645.87.camel@pasglop>
Subject: Re: [PATCH 3/3] KVM: PPC: Book3S: Add support for hwrng found on
 some powernv systems
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gleb Natapov <gleb@redhat.com>
Date: Thu, 03 Oct 2013 17:22:59 +1000
In-Reply-To: <20131003054355.GT17294@redhat.com>
References: <20131001083908.GA17294@redhat.com>
 <1380620338.645.22.camel@pasglop> <524AAFAA.3010801@redhat.com>
 <20131002050940.GA25363@drongo> <524BDD73.3020106@redhat.com>
 <1380704789.645.57.camel@pasglop>
 <668E4650-BC22-4CBF-A282-E7875DF29DB6@suse.de>
 <3CBF5732-E7EE-4C96-8132-6D7B77270DAF@suse.de>
 <20131002100224.GF17294@redhat.com> <1380751340.645.68.camel@pasglop>
 <20131003054355.GT17294@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: tytso@mit.edu, kvm@vger.kernel.org, linuxppc-dev@ozlabs.org,
 Alexander Graf <agraf@suse.de>, kvm-ppc@vger.kernel.org,
 linux-kernel@vger.kernel.org, herbert@gondor.hengli.com.au,
 Paul Mackerras <paulus@samba.org>, mpm@selenic.com,
 Paolo Bonzini <pbonzini@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-10-03 at 08:43 +0300, Gleb Natapov wrote:
> Why it can be a bad idea? User can drain hwrng continuously making other
> users of it much slower, or even worse, making them fall back to another
> much less reliable, source of entropy.

Not in a very significant way, we generate entropy at 1Mhz after all, which
is pretty good.

Cheers,
Ben.
