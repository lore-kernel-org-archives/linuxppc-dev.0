Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (dsl027-180-168.sfo1.dsl.speakeasy.net
	[216.27.180.168]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3965A68AC4
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jan 2006 11:05:20 +1100 (EST)
Date: Wed, 25 Jan 2006 16:04:30 -0800 (PST)
Message-Id: <20060125.160430.94334986.davem@davemloft.net>
To: paulus@samba.org
Subject: Re: [PATCH 5/6] fix warning on test_ti_thread_flag()
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <17367.64370.844350.972910@cargo.ozlabs.ibm.com>
References: <20060125112625.GA18584@miraclelinux.com>
	<20060125113446.GF18584@miraclelinux.com>
	<17367.64370.844350.972910@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org, spyro@f2s.com,
	ak@suse.de, dhowells@redhat.com, linuxppc-dev@ozlabs.org,
	gerg@uclinux.org, sparclinux@vger.kernel.org,
	uclinux-v850@lsi.nec.co.jp, ysato@users.sourceforge.jp,
	takata@linux-m32r.org, linuxsh-dev@lists.sourceforge.net,
	torvalds@osdl.org, ink@jurassic.park.msu.ru, rth@twiddle.net,
	mita@miraclelinux.com, chris@zankel.net, dev-etrax@axis.com,
	ultralinux@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	linux-kernel@vger.kernel.org,
	linuxsh-shmedia-dev@lists.sourceforge.net, linux390@de.ibm.com,
	rmk@arm.linux.org.uk, parisc-linux@parisc-linux.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Paul Mackerras <paulus@samba.org>
Date: Thu, 26 Jan 2006 09:28:02 +1100

> Akinobu Mita writes:
> 
> > If the arechitecture is
> > - BITS_PER_LONG == 64
> > - struct thread_info.flag 32 is bits
> > - second argument of test_bit() was void *
> > 
> > Then compiler print error message on test_ti_thread_flags()
> > in include/linux/thread_info.h
> 
> And correctly so.  The correct fix is to make thread_info.flag an
> unsigned long.  This patch is NAKed.

I agree.
