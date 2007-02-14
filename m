Return-Path: <benh@kernel.crashing.org>
Subject: RE: [PATCH 15/16] Add device tree for Ebony
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Yoder Stuart-B08248 <stuart.yoder@freescale.com>
In-Reply-To: <9696D7A991D0824DBA8DFAC74A9C5FA302A1B952@az33exm25.fsl.freescale.net>
References: <20070213060904.GA6214@localhost.localdomain>
	<20070213061026.5837FDDDE9@ozlabs.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A1B705@az33exm25.fsl.freescale.net>
	<1171470754.4003.101.camel@zod.rchland.ibm.com>
	<6206de08b7f12175bebe669291c66334@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A1B86F@az33exm25.fsl.freescale.net>
	<9df9bf3adf511f4c1a7945e022fdd447@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A1B8EF@az33exm25.fsl.freescale.net>
	<1171489360.20192.184.camel@localhost.localdomain>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A1B952@az33exm25.fsl.freescale.net>
Content-Type: text/plain
Date: Thu, 15 Feb 2007 09:57:11 +1100
Message-Id: <1171493831.20192.194.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > That's the current FSL practice yes. As I said, I'm not too 
> > fan of it. I
> > prefer a more precise representation of the internal bus layout.
> 
> Hmm.  I haven't been around here that long and assumed that
> the soc node was an approach arrived at after discussion and
> debate in the PPC Linux community in general.

Little discussion, as I said, I don't mind that much neither what
approach FSL uses for their own devices anyway, as long as it's
consistent and works for your needs. For the IBM CoreConnect parts, I'd
like to stick with the device type being "plb", "plb4", "plb5", "opb"
etc... for the various busses.

> Do we need to re-open up the discussion about how to represent
> SOCs in the device tree?  Does it matter?  Or, just have different
> vendors do it their own way?

I don't think it matters in the sense that I don't think we want to
change the current practice of FSL SoCs. It fits your needs well, so
let's stick with it.

> Some consistency would be good in my opinion.

Ben.
