Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao05.cox.net (fed1rmmtao05.cox.net [68.230.241.34])
	by ozlabs.org (Postfix) with ESMTP id F1D112BDB3
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  9 Oct 2004 05:48:09 +1000 (EST)
Date: Fri, 8 Oct 2004 12:48:07 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Dan Malek <dan@embeddededge.com>
Message-ID: <20041008194807.GG14773@smtp.west.cox.net>
References: <Pine.LNX.4.60.0410080704170.6219@dell.enoriver.com>
	<20041008164047.GC14773@smtp.west.cox.net>
	<944792EE-194E-11D9-9299-003065F9B7DC@embeddededge.com>
	<20041008180209.GD14773@smtp.west.cox.net>
	<7079964C-1959-11D9-9299-003065F9B7DC@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7079964C-1959-11D9-9299-003065F9B7DC@embeddededge.com>
Cc: Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: Re: cleaning up the Kconfig menu structure -- the bigger picture
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, Oct 08, 2004 at 02:39:51PM -0400, Dan Malek wrote:
> 
> On Oct 8, 2004, at 2:02 PM, Tom Rini wrote:
> 
> >But that's what I just described.  Letting the special config options
> >(I don't know if I'd call 85xx_PCI2 "I/O", but it is special) live in
> >platforms/8xx/Kconfig (or ppc/Kconfig.cpm1, or whatever).
> 
> You are conveniently ignoring the 4xx serial port configuration
> options that live in the platforms/4xx/Kconfig right now.  Taking
> debating lessons from dubyah, I guess :-)

No, just that I know Matt wants to see the uart0/uart1 part die and I
bet SERIAL_SICC would be rewritten and moved it was maintained. :)

> If you need change for the sake of change or just because you
> want to disagree with me, then there isn't anything I can do to
> convince you otherwise.  There is precedent from previous
> releases, in the current release with other processors, and from
> extensive experience that you should make you consider my
> suggestions.  I can understand moving the sources to better
> assist the development of code that interacts with these drivers,
> but scattering the unique and interdependent configuration
> options around isn't helpful.

I don't get it.  We do agree that the very specific stuff does indeed
belong somewhere that's obvious to the user, right?  We do agree that
for cpm2, cpm2-specific and not driver related stuff belongs in
platforms/85xx/Kconfig, right?  Are we disagreeing that the non-driver
portions of 8xx_io (and 82xx_io) should just live in syslib/ with
similar functionality bits of other machine types?  And that drivers
should live in drivers/ and asked with other drivers?

> The non-ppc folks updating the
> generic Kconfig files are going to be totally confused by that.

They haven't been confused by all of the other architectures stuff.  In
fact, they've helped clean things up too.

-- 
Tom Rini
http://gate.crashing.org/~trini/
