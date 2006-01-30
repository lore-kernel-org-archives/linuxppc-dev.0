Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (dsl027-180-168.sfo1.dsl.speakeasy.net
	[216.27.180.168]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C372A68A3A
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Jan 2006 10:03:43 +1100 (EST)
Date: Mon, 30 Jan 2006 15:02:44 -0800 (PST)
Message-Id: <20060130.150244.81476469.davem@davemloft.net>
To: sdbrady@ntlworld.com
Subject: Re: [parisc-linux] Re: [PATCH 3/6] C-language equivalents of
	include/asm-*/bitops.h
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060130195004.GA25860@miranda.arrow>
References: <20060129071242.GA24624@miranda.arrow>
	<20060130170647.GC3816@linux-mips.org>
	<20060130195004.GA25860@miranda.arrow>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linux-mips@linux-mips.org, linux-m68k@vger.kernel.org,
	linux-ia64@vger.kernel.org, spyro@f2s.com, ak@suse.de,
	dhowells@redhat.com, linuxppc-dev@ozlabs.org, gerg@uclinux.org,
	sparclinux@vger.kernel.org, uclinux-v850@lsi.nec.co.jp,
	ysato@users.sourceforge.jp, takata@linux-m32r.org,
	linuxsh-shmedia-dev@lists.sourceforge.net,
	grundler@parisc-linux.org, torvalds@osdl.org,
	ink@jurassic.park.msu.ru, mita@miraclelinux.com,
	chris@zankel.net, dev-etrax@axis.com, ultralinux@vger.kernel.org,
	linux-kernel@vger.kernel.org, ralf@linux-mips.org,
	linuxsh-dev@lists.sourceforge.net, linux390@de.ibm.com,
	parisc-linux@parisc-linux.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Stuart Brady <sdbrady@ntlworld.com>
Date: Mon, 30 Jan 2006 19:50:04 +0000

> Shame about popc on SPARC.  However, ffz is cheese, regardless of pops.
> (On sparc64, ffs is too.)  I'll wait for the generic bitops patches to
> be dealt with (or not) and then submit a patch fixing this if needed.

I'm happy with any improvement you might make here, for sure.

The sparc64 ffz() implementation was done so dog stupid like that
so that the code would be small since this gets inlined all over
the place.

So if you can keep it small and improve it, or make it a bit larger
and uninline it, that's great.
