Return-Path: <SRS0+5527751654f2e5afd62c+1639+infradead.org+arjan@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5265DDDEFD
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Feb 2008 08:05:32 +1100 (EST)
Date: Mon, 18 Feb 2008 13:04:22 -0800
From: Arjan van de Ven <arjan@infradead.org>
To: Jean Delvare <khali@linux-fr.org>
Subject: Re: [Patch 0/2] powerpc: avoid userspace poking to legacy ioports
Message-ID: <20080218130422.6ee10099@laptopd505.fenrus.org>
In-Reply-To: <20080218215842.66bb004f@hyperion.delvare>
References: <20080213182800.5c6940a8@de.ibm.com>
	<20080213183506.7f3e3145@de.ibm.com>
	<1202935374.7296.44.camel@pasglop>
	<20080218211519.2b159ade@hyperion.delvare>
	<1203367323.6740.21.camel@pasglop>
	<20080218215842.66bb004f@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: parabelboi@bopserverein.de, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Christian Krafft <krafft@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 18 Feb 2008 21:58:42 +0100
Jean Delvare <khali@linux-fr.org> wrote:

> On Tue, 19 Feb 2008 07:42:03 +1100, Benjamin Herrenschmidt wrote:
> > 
> > > Maybe Christian's patch can be improved to not do the check on
> > > these? As long as /dev/port exists, it seems reasonable that the
> > > kernel should behave, no matter what I/O ports are accessed from
> > > user-space.
> > 
> > nonsense.
> > 
> >  /dev/mem exists for example, but you are still not supposed to go
> > bang all over the place in it.
> 
> You should at least be able to read from it without crashing the
> machine. Of course writing is a different story.

keep dreaming. This is not how /dev/mem works today, not on x86 and very likely not on ppc either.
