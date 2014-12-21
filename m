Return-Path: <agraf@suse.de>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8BAEA1A04F6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Dec 2014 09:56:37 +1100 (AEDT)
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1A29B1400B7
 for <linuxppc-dev@ozlabs.org>; Mon, 22 Dec 2014 09:56:36 +1100 (AEDT)
Message-ID: <5497501E.9040806@suse.de>
Date: Sun, 21 Dec 2014 23:56:30 +0100
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Andreas Schwab <schwab@linux-m68k.org>, Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] powerpc: powernv: Return to cpu offline loop when finished
 in KVM guest
References: <20141203034840.GA612@iris.ozlabs.ibm.com>
 <878ui13xbe.fsf@igel.home>
In-Reply-To: <878ui13xbe.fsf@igel.home>
Content-Type: text/plain; charset=windows-1252
Cc: linuxppc-dev@ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 21.12.14 15:13, Andreas Schwab wrote:
> arch/powerpc/kvm/built-in.o: In function `kvm_no_guest':
> arch/powerpc/kvm/book3s_hv_rmhandlers.o:(.text+0x724): undefined reference to `power7_wakeup_loss'

Ugh. We just removed support for 970 HV mode, but that obviously doesn't
mean you can't compile in support for HV mode without enabling p7.

Paul, what would you think of a patch that makes BOOK3S_HV depend on
PPC_POWERNV?


Alex
