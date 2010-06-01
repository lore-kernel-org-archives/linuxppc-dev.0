Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id C4E50B7D2D
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Jun 2010 18:36:25 +1000 (EST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] KVM: PPC: elide struct thread_struct instances from stack
References: <m26323onam.fsf@igel.home>
	<20100531224040.GA22927@brick.ozlabs.ibm.com>
Date: Tue, 01 Jun 2010 10:36:21 +0200
In-Reply-To: <20100531224040.GA22927@brick.ozlabs.ibm.com> (Paul Mackerras's
	message of "Tue, 1 Jun 2010 08:40:40 +1000")
Message-ID: <m3r5krrvy2.fsf@hase.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, Alexander Graf <agraf@suse.de>,
	kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Paul Mackerras <paulus@samba.org> writes:

> I re-read the relevant part of the PowerPC architecture spec
> yesterday, and it seems pretty clear that the FPSCR doesn't affect the
> behaviour of lfs and stfs, and is not affected by them.  So in fact 4
> out of the 7 instructions in each of those procedures are unnecessary
> (and similarly for the cvt_fd/df used in the alignment fixup code).

I'd prefer to have this deferred to a separate patch.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
