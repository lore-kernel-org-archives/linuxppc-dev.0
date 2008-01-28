Return-Path: <benh@kernel.crashing.org>
Subject: Re: [Cbe-oss-dev] [PATCH 3/3] Cell IOMMU static mapping support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20080128214813.GA24416@lixom.net>
References: <edf2d9650b044e2bc21e9b74ad1044f4e5b6615c.1201257905.git.michael@ellerman.id.au>
	<9ce4678eef9e50908969eb1ef8470e307f3076ff.1201257905.git.michael@ellerman.id.au>
	<20080126025117.GA28066@lixom.net> <200801281241.49059.arnd@arndb.de>
	<20080128162343.GA19859@lixom.net> <1201554977.6815.189.camel@pasglop>
	<20080128214813.GA24416@lixom.net>
Content-Type: text/plain
Date: Tue, 29 Jan 2008 08:37:57 +1100
Message-Id: <1201556277.6815.194.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, "cbe-oss-dev@ozlabs.org" <cbe-oss-dev@ozlabs.org>,
	Arnd Bergmann <arnd@arndb.de>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mon, 2008-01-28 at 15:48 -0600, Olof Johansson wrote:
> > > Does the cell I/O bridge reflect out accesses to 2-4GB on the bus
> > > again? If not, that could be another place to stick the dynamic range
> > > for large config machines.
> > 
> > On the PCI bus itself, 2-4GB is where MMIO sits.
> 
> Depending on the implementation, 2-4GB accesses _from_ PCI could mean
> something else. 

Not on PCI / PCI-X no. Maybe PCI-E could do that sort of ugly hacks but
that wouldn't be within specs I believe.

> But for most machines it doesn't, and I'm guessing cell
> is one of those.

Ben.
