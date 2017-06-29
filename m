Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wyzKD2fLjzDr3x
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 22:21:04 +1000 (AEST)
In-Reply-To: <20170411052325.20206-1-bsingharora@gmail.com>
To: Balbir Singh <bsingharora@gmail.com>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [1/2] powerpc/tracing: Trace TLBIE(L)
Message-Id: <3wyzKD06WVz9s76@ozlabs.org>
Date: Thu, 29 Jun 2017 22:21:03 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-04-11 at 05:23:25 UTC, Balbir Singh wrote:
> Just a quick patch to trace tlbie(l)'s. The idea being that it can be
> enabled when we suspect corruption or when we need to see if we are doing
> the right thing during flush. I think the format can be enhanced to
> make it nicer (expand the RB/RS/IS/L cases in more detail if we ever
> need that level of details).
> 
> A typical trace might look like this
> 
> <...>-5141  [062]  1354.486693: tlbie:
> 	tlbie with lpid 0, local 0, rb=7b5d0ff874f11f1, rs=0, ric=0 prs=0 r=0
> systemd-udevd-2584  [018]  1354.486772: tlbie:
> 	tlbie with lpid 0, local 0, rb=17be1f421adc10c1, rs=0, ric=0 prs=0 r=0
> ...
> 
> qemu-system-ppc-5371  [016]  1412.369519: tlbie:
> 	tlbie with lpid 0, local 1, rb=67bd8900174c11c1, rs=0, ric=0 prs=0 r=0
> qemu-system-ppc-5377  [056]  1421.687262: tlbie:
> 	tlbie with lpid 1, local 0, rb=5f04edffa00c11c1, rs=1, ric=0 prs=0 r=0
> 
> Signed-off-by: Balbir Singh <bsingharora@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/0428491cba9277db42d66eb245d742

cheers
