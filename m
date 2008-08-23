Return-Path: <glppd-linuxppc64-dev@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by ozlabs.org (Postfix) with ESMTP id B5D31DDDEC
	for <linuxppc-dev@ozlabs.org>; Sun, 24 Aug 2008 04:05:13 +1000 (EST)
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1KWwXv-0005ab-55
	for linuxppc-dev@ozlabs.org; Sat, 23 Aug 2008 17:05:03 +0000
Received: from cct.net8.nerim.net ([213.41.184.223])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Aug 2008 17:05:03 +0000
Received: from arno by cct.net8.nerim.net with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Aug 2008 17:05:03 +0000
To: linuxppc-dev@ozlabs.org
From: arno@natisbad.org (Arnaud Ebalard)
Subject: Re: Random crashes with 2.6.27-rc3 on PPC
Date: Sat, 23 Aug 2008 18:58:02 +0200
Message-ID: <874p5bekit.fsf@natisbad.org>
References: <200808231610.46473.mb@bu3sch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: news <news@ger.gmane.org>
Cc: linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

Michael Buesch <mb@bu3sch.de> writes:

> I am seeing random kernel and userland application
> crashes on a Powerbook running a 2.6.27-rc3 based kernel
> (wireless-testing.git). 
>
> The crashes did recently appear. It might be the case that they were
> introduced with the merge of 2.6.27-rc1 into wireless-testing.
> I'm not sure on that one, however. Just a guess. I still need to
> do more testing (also on vanilla upstream kernels).
>
> The crashes are completely random and they look like bad hardware.
> However I cannot reproduce on 2.6.25.9 (That's a kernel I still had
> installed, so I tried that one). So it most likely is _not_ caused
> by faulty hardware.
>
> The crashes are hard to reproduce, and happen about every 20 minutes
> when compiling a kernel tree. (gcc segfaults). Sometimes the kernel
> oopses in random places with pointer dereference faults.

Exact same thing here on a PB 12" (not a ppc64, but ppc32). It was not
on a wireless-testing.git but on a recent net-2.6 or 2.6.27-rc3 (I do
not remember precisely). I thought it was a thermal issue and did not
spend time on it because of another regression I bisected (sysctl+IPv6)
that version useless for me.

> Is this a known issue?

Now it is ;-)

> I'm going to bisect this one, but it will take a lot of time, as
> reproducing takes about 20 minutes. So that's about an hour for one
> test round.

Thanks for doing that.

Cheers,

a+
