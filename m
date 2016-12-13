Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tdNk92G0pzDvgm
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Dec 2016 02:22:41 +1100 (AEDT)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3tdNk84FcRz9t10
 for <linuxppc-dev@ozlabs.org>; Wed, 14 Dec 2016 02:22:40 +1100 (AEDT)
Message-ID: <1481642555.17253.70.camel@kernel.crashing.org>
Subject: Re: [powerpc/nmi: RFC 2/2] Keep interrupts enabled even on soft
 disable
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Balbir Singh <bsingharora@gmail.com>, Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>, Paul
 Mackerras <paulus@samba.org>
Date: Tue, 13 Dec 2016 09:22:35 -0600
In-Reply-To: <1481599689.8786.2.camel@gmail.com>
References: <20161212095003.1885-1-bsingharora@gmail.com>
 <20161212095003.1885-3-bsingharora@gmail.com>
 <20161212233111.1712ba79@roar.ozlabs.ibm.com>
 <1481556264.17253.57.camel@kernel.crashing.org>
 <1481599689.8786.2.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-12-13 at 14:28 +1100, Balbir Singh wrote:
> > Also note that there's already a PACA field to "recover" an
> > interrupt
> > snatched by KVM, though it's XICS specific, while your approach is
> > more
> > generic, you may want to merge the two. Talk to Paulus.
> > 
> 
> That is specific to KVM for kvm_interrupt_hv and kvm has a referecne
> to the xics as well and within it, saved_xirr is tracked

yes but it does exactly the same thing as what you are adding some one
of them should probably go.

Cheers,
Ben.
