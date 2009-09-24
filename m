Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E9139B7043
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Sep 2009 13:44:44 +1000 (EST)
Subject: Re: [PATCH 00/10] Add support for GCC's __builtin_unreachable()
	and use it in BUG.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Daney <ddaney@caviumnetworks.com>
In-Reply-To: <4AA991C1.1050800@caviumnetworks.com>
References: <4AA991C1.1050800@caviumnetworks.com>
Content-Type: text/plain
Date: Thu, 24 Sep 2009 13:37:13 +1000
Message-Id: <1253763433.7103.391.camel@pasglop>
Mime-Version: 1.0
Cc: linux-mips@linux-mips.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-s390@vger.kernel.org,
	linux-am33-list@redhat.com, Helge Deller <deller@gmx.de>,
	x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
	Mike Frysinger <vapier@gentoo.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	uclinux-dist-devel@blackfin.uclinux.org,
	Thomas Gleixner <tglx@linutronix.de>, Richard Henderson <rth@twiddle.net>,
	Haavard Skinnemoen <hskinnemoen@atmel.com>,
	linux-parisc@vger.kernel.org, ralf@linux-mips.org,
	Kyle McMartin <kyle@mcmartin.ca>, linux-alpha@vger.kernel.org,
	Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Koichi Yasutake <yasutake.koichi@jp.panasonic.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-09-10 at 16:54 -0700, David Daney wrote:
> Starting with version 4.5, GCC has a new built-in function called
> __builtin_unreachable().  The function tells the compiler that control
> flow will never reach that point.  Currently we trick the compiler by
> putting in for(;;); but this has the disadvantage that extra code is
> emitted for an endless loop.  For an i386 kernel using
> __builtin_unreachable() results in an allyesconfig that is nearly 4000
> bytes smaller.

For the powerpc part:

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
