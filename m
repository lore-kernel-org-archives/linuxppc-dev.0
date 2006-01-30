Return-Path: <ralf@linux-mips.org>
Received: from bacchus.net.dhis.org (unknown [194.74.144.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1EBB168A00
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Jan 2006 05:01:23 +1100 (EST)
Date: Mon, 30 Jan 2006 17:06:47 +0000
From: Ralf Baechle <ralf@linux-mips.org>
To: Stuart Brady <sdbrady@ntlworld.com>
Subject: Re: [parisc-linux] Re: [PATCH 3/6] C-language equivalents of
	include/asm-*/bitops.h
Message-ID: <20060130170647.GC3816@linux-mips.org>
References: <20060125112625.GA18584@miraclelinux.com>
	<20060125113206.GD18584@miraclelinux.com>
	<20060125200250.GA26443@flint.arm.linux.org.uk>
	<20060126000618.GA5592@twiddle.net>
	<20060126085540.GA15377@flint.arm.linux.org.uk>
	<20060126161849.GA13632@colo.lackof.org>
	<20060126164020.GA27222@flint.arm.linux.org.uk>
	<20060126230443.GC13632@colo.lackof.org>
	<20060126230353.GC27222@flint.arm.linux.org.uk>
	<20060129071242.GA24624@miranda.arrow>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060129071242.GA24624@miranda.arrow>
Cc: linux-mips@linux-mips.org, linux-m68k@vger.kernel.org,
	linux-ia64@vger.kernel.org, Ian Molton <spyro@f2s.com>,
	Andi Kleen <ak@suse.de>, David Howells <dhowells@redhat.com>,
	linuxppc-dev@ozlabs.org, Greg Ungerer <gerg@uclinux.org>,
	sparclinux@vger.kernel.org, Miles Bader <uclinux-v850@lsi.nec.co.jp>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Hirokazu Takata <takata@linux-m32r.org>,
	linuxsh-shmedia-dev@lists.sourceforge.net,
	Grant Grundler <grundler@parisc-linux.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Akinobu Mita <mita@miraclelinux.com>,
	Chris Zankel <chris@zankel.net>, dev-etrax@axis.com,
	ultralinux@vger.kernel.org, linux-kernel@vger.kernel.org,
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

On Sun, Jan 29, 2006 at 07:12:42AM +0000, Stuart Brady wrote:

> On MIPS, fls() and flz() should probably use CLO.

It actually uses clz.

> Curiously, MIPS is the only arch with a flz() function.

No longer.  The fls implementation was based on flz and fls was the only
user of flz.  So I cleaned that, once I commit flz will be gone.  Not
only a cleanup but also a minor optimization.

  Ralf
