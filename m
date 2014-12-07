Return-Path: <richard@nod.at>
Received: from radon.swed.at (a.ns.miles-group.at [95.130.255.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0724D1A0CFA
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Dec 2014 10:15:13 +1100 (AEDT)
Message-ID: <5484DF7C.7060600@nod.at>
Date: Mon, 08 Dec 2014 00:15:08 +0100
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
To: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Subject: Re: [PATCH] arch: powerpc: kernel: signal_32.c: Remove unused function
References: <1417990021-18696-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
 <5484D240.30506@nod.at>
 <CAFo99gYvkzCTi6FZXfPOCqafNYn6y4H4hx62KqJjex60KV70_A@mail.gmail.com>
In-Reply-To: <CAFo99gYvkzCTi6FZXfPOCqafNYn6y4H4hx62KqJjex60KV70_A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Cc: Michael Neuling <mikey@neuling.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Am 08.12.2014 um 00:11 schrieb Rickard Strandqvist:
> Hi
> 
> Ok, sorry :-(
> 
> But I really do not. I've hacked together a script that will scan all
> the code for the function, and test builds with some different config
> options turned on.

Looks like you did not build a powerpc32 kernel. :-)

FWIW, this is the reference to the function:
arch/powerpc/include/asm/systbl.h:OLDSYS(debug_setcontext)

Thanks,
//richard
