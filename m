Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wv4zF32n9zDqjF
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jun 2017 14:22:01 +1000 (AEST)
Date: Fri, 23 Jun 2017 14:22:00 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, "H.
 Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>,
 Linux-Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel Mailing
 List <linux-kernel@vger.kernel.org>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, PowerPC <linuxppc-dev@lists.ozlabs.org>, John
 Stultz <john.stultz@linaro.org>
Subject: Re: linux-next: build warning after merge of the tip tree
Message-ID: <20170623142200.3df2515d@canb.auug.org.au>
In-Reply-To: <87efubqr7y.fsf@concordia.ellerman.id.au>
References: <20170623135834.49322610@canb.auug.org.au>
 <20170623140006.26585989@canb.auug.org.au>
 <87efubqr7y.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

On Fri, 23 Jun 2017 14:10:25 +1000 Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Fixed in my next today by:
> 
>   d4cfb11387ee ("powerpc: Convert VDSO update function to use new update_vsyscall interface")
> 
> But you must have pulled before I pushed that, so the warning will go
> away tomorrow.

Excellent, thanks.

-- 
Cheers,
Stephen Rothwell
