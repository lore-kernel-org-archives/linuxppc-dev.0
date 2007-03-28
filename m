Return-Path: <stuart.yoder@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [RFC 3/3] powerpc: Add DTS file for the Motorola PrPMC2800platform
Date: Wed, 28 Mar 2007 12:49:31 -0700
Message-ID: <9696D7A991D0824DBA8DFAC74A9C5FA302BDAC95@az33exm25.fsl.freescale.net>
In-Reply-To: <1175105479.7553.75.camel@zod.rchland.ibm.com>
References: <20070328011924.GA1586@mag.az.mvista.com>
	<20070328012206.GD1586@mag.az.mvista.com>
	<9696D7A991D0824DBA8DFAC74A9C5FA302BDAB3E@az33exm25.fsl.freescale.net>
	<1175105479.7553.75.camel@zod.rchland.ibm.com>
From: "Yoder Stuart-B08248" <stuart.yoder@freescale.com>
To: "Josh Boyer" <jwboyer@linux.vnet.ibm.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>,
	Dale Farnsworth <dfarnsworth@mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=20

> -----Original Message-----
> From: Josh Boyer [mailto:jwboyer@linux.vnet.ibm.com]=20
> Sent: Wednesday, March 28, 2007 1:11 PM
> To: Yoder Stuart-B08248
> Cc: Mark A. Greer; linuxppc-dev; Dale Farnsworth
> Subject: RE: [RFC 3/3] powerpc: Add DTS file for the Motorola=20
> PrPMC2800platform
>=20
> On Wed, 2007-03-28 at 09:43 -0700, Yoder Stuart-B08248 wrote:
> > Biggest concern is that I see a lot of undocumented device
> > types and properties...
>=20
> Yes, but that is a problem in general.
>=20
> > > +		virtual-reg =3D <f1000000>;
> >=20
> > What is virtual-reg for?  I gather it is related to the bootwrapper
> > needed virtual addresses for devices reg blocks.  But, I counted
> > 12 instances of the property in this file.  Are all needed by the
> > bootwrapper??
> >=20
> > Does anyone where this property came from historically?  If it's
> > specifically for a Linux bootwrapper the name should reflect=20
> > that-- linux,bootwrapper-reg-vaddr -- or something...
>=20
> It came from a discussion Mark, I, and a few others had on this list a
> few months ago about the requirement for reusing the virtual=20
> address set
> up by the firmware for the bootwrapper.  You cannot assume a 1:1
> physical to virtual mapping for things, so the bootwrapper=20
> console code
> looks for virtual-reg first and uses that address for it's operations.
>=20
> > Based on some offline dicussions I think I know what block-index
> > is, but I'd like to see this property documented in
> > booting-without-of.txt.
>=20
> As an aside, there's a lot of stuff that needs updating in
> booting-without-of.txt.  The interrupt mapping it suggests is=20
> incorrect,
> some of the entry point stuff is invalid, etc.  There's now several
> properties that are being introduced that aren't in there as well.

Right. I know.  But, should we not try to keep that document as=20
up to date as we can?   As new, needed properties are created
they should be documented somewhere, and booting-without-of.txt
seem to be the right place to do it for now.

Stuart
