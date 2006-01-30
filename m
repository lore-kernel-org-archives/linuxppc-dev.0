Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (dsl027-180-168.sfo1.dsl.speakeasy.net
	[216.27.180.168]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C0C0F68ACE
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Jan 2006 15:03:41 +1100 (EST)
Date: Sun, 29 Jan 2006 20:03:35 -0800 (PST)
Message-Id: <20060129.200335.69237695.davem@davemloft.net>
To: sdbrady@ntlworld.com
Subject: Re: [parisc-linux] Re: [PATCH 3/6] C-language equivalents of
	include/asm-*/bitops.h
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060129071242.GA24624@miranda.arrow>
References: <20060126230443.GC13632@colo.lackof.org>
	<20060126230353.GC27222@flint.arm.linux.org.uk>
	<20060129071242.GA24624@miranda.arrow>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org, spyro@f2s.com,
	ak@suse.de, dhowells@redhat.com, linuxppc-dev@ozlabs.org,
	gerg@uclinux.org, sparclinux@vger.kernel.org,
	uclinux-v850@lsi.nec.co.jp, ysato@users.sourceforge.jp,
	takata@linux-m32r.org, linuxsh-shmedia-dev@lists.sourceforge.net,
	grundler@parisc-linux.org, torvalds@osdl.org,
	ink@jurassic.park.msu.ru, mita@miraclelinux.com,
	chris@zankel.net, dev-etrax@axis.com, ultralinux@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
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
Date: Sun, 29 Jan 2006 07:12:42 +0000

> There are versions of hweight*() for sparc64 which use POPC when
> ULTRA_HAS_POPULATION_COUNT is defined, but AFAICS, it's never defined.

That's right, the problem here is that no chips actually implement
the instruction in hardware, it is software emulated, ie. useless :-)
