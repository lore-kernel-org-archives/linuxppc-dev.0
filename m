Return-Path: <mita@miraclelinux.com>
Received: from mail01.miraclelinux.com (ns.miraclelinux.com [219.118.163.66])
	by ozlabs.org (Postfix) with ESMTP id 85E9568AC4
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Jan 2006 14:15:26 +1100 (EST)
Date: Mon, 30 Jan 2006 12:15:22 +0900
To: Hirokazu Takata <takata@linux-m32r.org>
Subject: Re: [PATCH 4/6] use include/asm-generic/bitops for each architecture
Message-ID: <20060130031522.GA6897@miraclelinux.com>
References: <20060125112625.GA18584@miraclelinux.com>
	<20060125113336.GE18584@miraclelinux.com>
	<20060126014934.GA6648@miraclelinux.com>
	<20060127.220401.356433243.takata.hirokazu@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060127.220401.356433243.takata.hirokazu@renesas.com>
From: mita@miraclelinux.com (Akinobu Mita)
Cc: akpm@osdl.org, linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
	spyro@f2s.com, ak@suse.de, dhowells@redhat.com,
	linuxppc-dev@ozlabs.org, gerg@uclinux.org,
	sparclinux@vger.kernel.org, uclinux-v850@lsi.nec.co.jp,
	ysato@users.sourceforge.jp, linuxsh-dev@lists.sourceforge.net,
	torvalds@osdl.org, ink@jurassic.park.msu.ru, rth@twiddle.net,
	chris@zankel.net, dev-etrax@axis.com, ultralinux@vger.kernel.org,
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

On Fri, Jan 27, 2006 at 10:04:01PM +0900, Hirokazu Takata wrote:

> compile and boot test on m32r: OK

Thanks.

> Code size became a little bigger...  ;-)
> 
> $ size linux-2.6.16-rc1*/vmlinux
>    text    data     bss     dec     hex filename
> 1768030  124412  721632 2614074  27e33a linux-2.6.16-rc1.bitops/vmlinux
> 1755010  124412  721632 2601054  27b05e linux-2.6.16-rc1.org/vmlinux

The only difference I can find is __ffs()/ffz().
As Russel King clealy pointed out, it will generate larger code
than before.
