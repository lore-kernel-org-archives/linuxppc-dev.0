Return-Path: <takata@linux-m32r.org>
Received: from mail03.idc.renesas.com (mail.renesas.com [202.234.163.13])
	by ozlabs.org (Postfix) with ESMTP id C720468A02
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Jan 2006 00:04:07 +1100 (EST)
Received: from mail03.idc.renesas.com ([127.0.0.1])
	by mail03.idc.renesas.com. (SMSSMTP 4.1.9.35) with SMTP id
	M2006012722040526936
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jan 2006 22:04:05 +0900
Date: Fri, 27 Jan 2006 22:04:01 +0900 (JST)
Message-Id: <20060127.220401.356433243.takata.hirokazu@renesas.com>
To: mita@miraclelinux.com
Subject: Re: [PATCH 4/6] use include/asm-generic/bitops for each architecture
From: Hirokazu Takata <takata@linux-m32r.org>
In-Reply-To: <20060126014934.GA6648@miraclelinux.com>
References: <20060125112625.GA18584@miraclelinux.com>
	<20060125113336.GE18584@miraclelinux.com>
	<20060126014934.GA6648@miraclelinux.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: akpm@osdl.org, linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
	spyro@f2s.com, ak@suse.de, dhowells@redhat.com,
	linuxppc-dev@ozlabs.org, gerg@uclinux.org,
	sparclinux@vger.kernel.org, uclinux-v850@lsi.nec.co.jp,
	ysato@users.sourceforge.jp, takata@linux-m32r.org,
	linuxsh-dev@lists.sourceforge.net, torvalds@osdl.org,
	ink@jurassic.park.msu.ru, rth@twiddle.net, chris@zankel.net,
	dev-etrax@axis.com, ultralinux@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
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

From: mita@miraclelinux.com (Akinobu Mita)
Subject: Re: [PATCH 4/6] use include/asm-generic/bitops for each architecture
Date: Thu, 26 Jan 2006 10:49:34 +0900
> On Wed, Jan 25, 2006 at 08:33:37PM +0900, mita wrote:
> > compile test on i386, x86_64, ppc, sparc, sparc64, alpha
> > boot test on i386, x86_64, ppc
...
>
> o m32r
> 
> - remove __{,test_and_}{set,clear,change}_bit() and test_bit()
> - remove ffz()
> - remove find_{next,first}{,_zero}_bit()
> - remove __ffs()
> - remove fls()
> - remove fls64()
> - remove sched_find_first_bit()
> - remove ffs()
> - remove hweight()
> - remove ext2_{set,clear,test,find_first_zero,find_next_zero}_bit()
> - remove ext2_{set,clear}_bit_atomic()
> - remove minix_{test,set,test_and_clear,test,find_first_zero}_bit()
> - define HAVE_ARCH_ATOMIC_BITOPS
> 

compile and boot test on m32r: OK

Code size became a little bigger...  ;-)

$ size linux-2.6.16-rc1*/vmlinux
   text    data     bss     dec     hex filename
1768030  124412  721632 2614074  27e33a linux-2.6.16-rc1.bitops/vmlinux
1755010  124412  721632 2601054  27b05e linux-2.6.16-rc1.org/vmlinux

-- Takata
