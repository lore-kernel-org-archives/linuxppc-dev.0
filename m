Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2/2] Add local bus device nodes to MPC837xMDS device trees.
Date: Tue, 11 Mar 2008 01:43:49 +0100
References: <1204800155-11613-1-git-send-email-leoli@freescale.com>
	<9f7d0248e911f6fa1a2d4292c96ef72e@kernel.crashing.org>
	<20080310235429.GC11559@localhost.localdomain>
In-Reply-To: <20080310235429.GC11559@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200803110143.50561.arnd@arndb.de>
Cc: Li Yang <leoli@freescale.com>, paulus@samba.org,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 11 March 2008, David Gibson wrote:
> On Fri, Mar 07, 2008 at 04:39:30AM +0100, Segher Boessenkool wrote:
> > > This isn't a problem with this device tree, but it's probably time we
> > > started establishing some conventional generic names for nand flash
> > > and board-control devices.
> > >
> > > So, to start the ball rolling, I've seen several names for nand flash
> > > nodes, I'd suggest we standardise on "nand-flash".
> >=20
> > What's wrong with the already well-established generic name "flash"?
>=20
> I was concerned that using "flash" for both NOR flash (which it
> already is) and NAND flash might be unwise. =A0I am quite open to being
> convinced otherwise, though.

One argument for just using "flash" is that there are much finer differences
than just "NAND" and "NOR", with at least "dataflash", "OneNAND", "SD/MMC"
being further types of flash that don't fit the categories exactly, though
each one for different reasons.

=46or SD/MMC, there are good reasons to use something completely different,
for the others, calling them all "flash" sounds better than fitting them
into "nand" and "nor".

	Arnd <><
