Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <16878.11077.556326.769738@cargo.ozlabs.ibm.com>
Date: Wed, 19 Jan 2005 20:41:25 +1100
From: Paul Mackerras <paulus@samba.org>
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1106120622.10851.42.camel@baythorne.infradead.org>
References: <200501082324.j08NOIva030415@hera.kernel.org>
	<20050109151353.GA9508@suse.de>
	<1105956993.26551.327.camel@hades.cambridge.redhat.com>
	<1106107876.4534.163.camel@gaston>
	<1106120622.10851.42.camel@baythorne.infradead.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Linus Torvalds <torvalds@osdl.org>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] raid6: altivec support
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Woodhouse writes:

> Yeah.... I'm increasingly tempted to merge ppc32/ppc64 into one arch
> like mips/parisc/s390. Or would that get vetoed on the basis that we
> don't have all that horrid non-OF platform support in ppc64 yet, and
> we're still kidding ourselves that all those embedded vendors will
> either not notice ppc64 or will use OF?

I'm going to insist that every new ppc64 platform supplies a device
tree.  They don't have to have OF but they do need to have the booter
or wrapper supply a flattened device tree (which is just a few kB of
binary data as far as the booter/wrapper is concerned).  It doesn't
have to include all the 

As for merging ppc32 and ppc64, I think it would end up an awful ifdef
mess, but if you can see a clean way to do it, send me a patch. :)

Paul.
