Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH] ppc: Add support for AMCC Taishan 440GX eval board
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jon Loeliger <jdl@jdl.com>
In-Reply-To: <E1HGhb3-0001fb-9M@jdl.com>
References: <200702121129.05004.sr@denx.de>
	<1171281988.20192.1.camel@localhost.localdomain>
	<ada7iun8bz3.fsf@cisco.com>
	<1171310108.20192.7.camel@localhost.localdomain>
	<E1HGhb3-0001fb-9M@jdl.com>
Content-Type: text/plain
Date: Tue, 13 Feb 2007 07:23:22 +1100
Message-Id: <1171311802.20192.15.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Roland Dreier <rdreier@cisco.com>,
	Stefan Roese <sr@denx.de>, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-02-12 at 14:16 -0600, Jon Loeliger wrote:
> So, like, the other day Benjamin Herrenschmidt mumbled:
> > 
> > Note that there are still things that we might want to change. For
> > example, I think we really should look into adding a macro mecanism
> > and/or an include mecanism to dtc so that we can do things like #include
> > <ibm440gp.dtc> to get the base processor/SoC definition and then
> > "overlay" some properties on top of it (like emac phy mode etc...)
> 
> What do people prefer here?  Straight CPP pre-run?

CPP pre-run has issue, notably due to the usage of "#" in property
names.

> Direct support built into dtc to do file-inclusion, macros?

We aren't sure yet, though David might have ideas.

> Thoughts, opinions, suggestions, pre-NACKs, Cabernet Franc bribes?

I'd take the later :-)

Ben.
