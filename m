Return-Path: <James.Bottomley@SteelEye.com>
Received: from hancock.sc.steeleye.com (hancock.steeleye.com [71.30.118.248])
	by ozlabs.org (Postfix) with ESMTP id 874B4DDEF3
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Mar 2007 05:09:07 +1100 (EST)
Subject: Re: [parisc-linux] [PATCH 1/2] Use a weak symbol for the empty
	version of pcibios_add_platform_entries()
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Michael Ellerman <michael@ellerman.id.au>
In-Reply-To: <1173193568.89821.610708199943.qpush@concordia>
References: <1173193568.89821.610708199943.qpush@concordia>
Content-Type: text/plain
Date: Tue, 06 Mar 2007 12:01:00 -0600
Message-Id: <1173204060.3379.28.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
Cc: discuss@x86-64.org, dev-etrax@axis.com, linux-ia64@vger.kernel.org,
	chris@zankel.net, Greg Kroah-Hartman <greg@kroah.com>,
	linux-m68k@vger.kernel.org, uclinux-v850@lsi.nec.co.jp,
	linuxppc-dev@ozlabs.org, linux-mips@linux-mips.org,
	gerg@uclinux.org, sparclinux@vger.kernel.org,
	ink@jurassic.park.msu.ru, linux-pci@atrey.karlin.mff.cuni.cz,
	rth@twiddle.net, kernel@wantstofly.org, parisc-linux@parisc-linux.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-03-06 at 16:06 +0100, Michael Ellerman wrote:
> I'm not sure if this is going to fly, weak symbols work on the compilers I'm
> using, but whether they work for all of the affected architectures I can't say.
> I've cc'ed as many arch maintainers/lists as I could find.

Well, for your use, PCI already uses weak symbols, so it must work on
every architecture that you want to do it on ...

James
