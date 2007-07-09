Return-Path: <jwboyer@jdub.homelinux.org>
Received: from jdub.homelinux.org (unknown [209.180.55.243])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A9A71DDF18
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  9 Jul 2007 13:37:37 +1000 (EST)
Subject: Re: ARCH=ppc vs ARCH=powerpc
From: Josh Boyer <jwboyer@jdub.homelinux.org>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200707090234.14851.arnd@arndb.de>
References: <Pine.LNX.4.61.0707061706140.4792@mtfhpc.demon.co.uk>
	<200707090234.14851.arnd@arndb.de>
Content-Type: text/plain
Date: Sun, 08 Jul 2007 22:37:30 -0500
Message-Id: <1183952250.3308.0.camel@vader.jdub.homelinux.org>
Mime-Version: 1.0
Cc: Mark Fortescue <mark@mtfhpc.demon.co.uk>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, 2007-07-09 at 02:34 +0200, Arnd Bergmann wrote:
> On Friday 06 July 2007, Mark Fortescue wrote:
> > For me, the requirement is to keep support for the cards indicated in 
> > arch/ppc/config/xxx_defconfig (as I have one that I might what to use with 
> > linux) in the same way as they are supported in ARCH=ppc.
> 
> The one thing that is holding up the transition to arch/powerpc is lack
> of people with access to the respective boards. If you have one board
> that you care about, it would be good if you look into getting it moved
> over. Tell us if you have problems doing so. It shouldn't be all that
> hard any more, and if it is, maybe some documentation is missing.

It's not just lack of boards.  It's lack of understanding of the
requirements to get a board port into arch/powerpc.  Namely, the device
tree stuff.

josh
