Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao09.cox.net (fed1rmmtao09.cox.net [68.230.241.30])
	by ozlabs.org (Postfix) with ESMTP id 8F59A67A5C
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Jan 2005 04:55:40 +1100 (EST)
Date: Thu, 20 Jan 2005 10:55:38 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Message-ID: <20050120175537.GB32020@smtp.west.cox.net>
References: <200501082324.j08NOIva030415@hera.kernel.org>
	<20050109151353.GA9508@suse.de>
	<1105956993.26551.327.camel@hades.cambridge.redhat.com>
	<1106107876.4534.163.camel@gaston>
	<1106120622.10851.42.camel@baythorne.infradead.org>
	<16878.11077.556326.769738@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <16878.11077.556326.769738@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Linus Torvalds <torvalds@osdl.org>, David Woodhouse <dwmw2@infradead.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] raid6: altivec support
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 19, 2005 at 08:41:25PM +1100, Paul Mackerras wrote:
> David Woodhouse writes:
> 
> > Yeah.... I'm increasingly tempted to merge ppc32/ppc64 into one arch
> > like mips/parisc/s390. Or would that get vetoed on the basis that we
> > don't have all that horrid non-OF platform support in ppc64 yet, and
> > we're still kidding ourselves that all those embedded vendors will
> > either not notice ppc64 or will use OF?
> 
> I'm going to insist that every new ppc64 platform supplies a device
> tree.  They don't have to have OF but they do need to have the booter
> or wrapper supply a flattened device tree (which is just a few kB of
> binary data as far as the booter/wrapper is concerned).  It doesn't
> have to include all the 

*shurg*
It really is a great idea, but I think it will just move the ire from
(serial infos, IRQ table, ?) being in platforms/fooboard.[ch] to
platforms/fooboard.h or platforms/fooboard_bootinfos.h

So lets just hope ppc64 keeps getting ignored :)

-- 
Tom Rini
http://gate.crashing.org/~trini/
