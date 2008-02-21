Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18365.1344.466799.556560@cargo.ozlabs.ibm.com>
Date: Thu, 21 Feb 2008 15:59:44 +1100
From: Paul Mackerras <paulus@samba.org>
To: avorontsov@ru.mvista.com
Subject: Re: [Linux-fbdev-devel] [PATCH 1/2] fb: add support for foreign
	endianness
In-Reply-To: <20080220121818.GA20836@localhost.localdomain>
References: <20080214224942.a0cb6218.akpm@linux-foundation.org>
	<20080215164542.GB16810@localhost.localdomain>
	<Pine.LNX.4.64.0802171030330.6848@anakin>
	<20080218081847.e9e65f2f.krzysztof.h1@poczta.fm>
	<19805.1203355811@turing-police.cc.vt.edu>
	<47BA162C.5000807@anagramm.de> <1203381353.6740.59.camel@pasglop>
	<47BABD3A.7010102@anagramm.de>
	<20080219040530.7b1d115d.akpm@linux-foundation.org>
	<18363.31427.989835.105966@cargo.ozlabs.ibm.com>
	<20080220121818.GA20836@localhost.localdomain>
Cc: linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com,
	Krzysztof Helt <krzysztof.h1@poczta.fm>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Vorontsov writes:

> > I was wondering if it would be sufficient to provide alternative
> > versions of fb_readl, fb_writel etc. that do byte-swapping.
> 
> This is of course viable alternative. And I was considering this, but
> later I abandoned the idea: that way we'll end up doing math in the
> native endianness and then converting it to the foreign. This feels
> ugly in contrast when we can do the right math in the first place, per
> framebuffer.

OK.  I guess I'm convinced then.  However, your patch description
needs to be a lot better.  It should describe things like why you
want to make the change and why the change you are proposing is a good
idea and is better than other alternatives.  If you'd done that
originally we might not have needed to have all this discussion. :)

Paul.
