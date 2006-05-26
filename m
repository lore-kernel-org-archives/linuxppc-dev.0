Return-Path: <olof@lixom.net>
Date: Fri, 26 May 2006 08:16:49 -0700
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Cell and new CPU feature bits
Message-ID: <20060526151649.GA5067@pb15.lixom.net>
References: <1148011621.13249.7.camel@localhost.localdomain>
	<20060519051939.GJ8220@pb15.lixom.net>
	<1148624357.8089.88.camel@localhost.localdomain>
	<20060526064341.GA6183@pb15.lixom.net>
	<1148628831.8089.107.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1148628831.8089.107.camel@localhost.localdomain>
From: Olof Johansson <olof@lixom.net>
Cc: Arnd Bergmann <arnd@arndb.de>, Steve Munroe <sjmunroe@us.ibm.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	Olof Johansson <olof@lixom.net>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, May 26, 2006 at 05:33:51PM +1000, Benjamin Herrenschmidt wrote:

> > Do we see this likely to be used in "global userspace", or more likely
> > in the processor-specific glibc sections? If it's in the
> > processor-specific ones, maybe we should have a per-processor bitfield
> > with erratas/features instead of a global one. That'd make allocation
> > easier too.
> 
> Do we have to deal with that many errata that affect userland ? It's
> generally an area where processors are fairly well validated... I don't
> think we need to scale up that much on this one.

Right, amount of erratas should be limited. BUt the amount of features
can be larger, especially as they grow over time and never go away.

> > > Yes, I think a new CPU feature bit for that too is needed. Not much of
> > > these left...
> > 
> > Well, are these instructions architected in some later version past
> > 2.02? If so, the bit is only needed on the older processors -- yet again
> > a case for sub-feature/errata bitmasks.
> 
> I have to check but I suspect it's still optional.

Ok. Features like that tend to be implementation-specific in the firt
processor they show up in, and later make it into the architecture.
That's why I'm asking. :-)

-Olof
