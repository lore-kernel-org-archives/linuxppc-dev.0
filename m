Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EF86D1A0338
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Dec 2014 13:24:48 +1100 (AEDT)
Message-ID: <1419215088.20221.3.camel@ellerman.id.au>
Subject: Re: [PATCH] powerpc: powernv: Return to cpu offline loop when
 finished in KVM guest
From: Michael Ellerman <mpe@ellerman.id.au>
To: Alexander Graf <agraf@suse.de>
Date: Mon, 22 Dec 2014 13:24:48 +1100
In-Reply-To: <5497501E.9040806@suse.de>
References: <20141203034840.GA612@iris.ozlabs.ibm.com>
 <878ui13xbe.fsf@igel.home> <5497501E.9040806@suse.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>, Andreas Schwab <schwab@linux-m68k.org>,
 kvm-ppc@vger.kernel.org, kvm@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2014-12-21 at 23:56 +0100, Alexander Graf wrote:
> On 21.12.14 15:13, Andreas Schwab wrote:
> > arch/powerpc/kvm/built-in.o: In function `kvm_no_guest':
> > arch/powerpc/kvm/book3s_hv_rmhandlers.o:(.text+0x724): undefined reference to `power7_wakeup_loss'
> 
> Ugh. We just removed support for 970 HV mode, but that obviously doesn't
> mean you can't compile in support for HV mode without enabling p7.
> 
> Paul, what would you think of a patch that makes BOOK3S_HV depend on
> PPC_POWERNV?

Paul's out until after Christmas I think, maybe later.

That sounds reasonable to me though, it reflects reality, and we can always
change it in future.

cheers
