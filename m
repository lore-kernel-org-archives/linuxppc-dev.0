Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 92984DDE04
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 26 Jun 2007 02:50:47 +1000 (EST)
Date: Mon, 25 Jun 2007 12:00:03 -0500
To: Matt Sealey <matt@genesi-usa.com>
Subject: Re: Mem-2-Mem DMA - Generalized API
Message-ID: <20070625170003.GA6484@lixom.net>
References: <20070624193932.GA11797@clifford.at>
	<200706242221.57507.arnd@arndb.de>
	<467FA0EA.3000607@genesi-usa.com> <467FBABD.9040103@anagramm.de>
	<467FD1DF.4000602@genesi-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <467FD1DF.4000602@genesi-usa.com>
From: olof@lixom.net (Olof Johansson)
Cc: Arnd Bergmann <arnd@arndb.de>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, Jun 25, 2007 at 03:31:59PM +0100, Matt Sealey wrote:
> 
> Indeed. I wonder if we could pull apart the IOAT/DMA stuff and genericise
> it (it should be possible) or simply add to it, or if making a powerpc
> specific dma engine abstraction would be an easier idea.

It's hard to anticipate all possible uses of a framework when you first
write it.  So, when you first write it with one device in mind, it's
fairly obvious that it might not fit well with the second device that
will use it. That's the case of drivers/dma and IOAT today.

That's the case with the dma engine framework today. Expand it, extend
it, fix it and improve it. Don't duplicate, re-invent and re-implement.


-Olof
