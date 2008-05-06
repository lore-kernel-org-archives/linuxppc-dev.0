Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from WA4EHSOBE001.bigfish.com (outbound-wa4.frontbridge.com
	[216.32.181.16]) by ozlabs.org (Postfix) with ESMTP id 3CAE3DDD01
	for <linuxppc-dev@ozlabs.org>; Wed,  7 May 2008 03:33:47 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Subject: RE: [PATCH 2/4] [POWERPC] Xilinx: Virtex: Enable dcr for MMIO
	andNATIVE
Date: Tue, 6 May 2008 10:33:43 -0700
In-Reply-To: <1210032708.21644.131.camel@pasglop>
References: <20080421080353.5d2b3bb9@zod.rchland.ibm.com>
	<1210010201-28436-1-git-send-email-stephen.neuendorffer@xilinx.com>
	<1210010201-28436-2-git-send-email-stephen.neuendorffer@xilinx.com>
	<20080505175646.BDF3D11806D@mail196-wa4.bigfish.com>
	<1210032708.21644.131.camel@pasglop>
From: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
To: <benh@kernel.crashing.org>
Message-ID: <20080506173344.974BBC300BB@mail2-wa4.bigfish.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Yes, but this is a symptom of a separate problem, which is that it is
sometimes valuable to generate an optimized kernel configuration for a
particular FPGA system.  First order, I'm more concerned about getting a
kernel which is generic and can work with (more or less) any device
tree.

Steve

> -----Original Message-----
> From: Benjamin Herrenschmidt [mailto:benh@kernel.crashing.org]
> Sent: Monday, May 05, 2008 5:12 PM
> To: Stephen Neuendorffer
> Cc: jwboyer@linux.vnet.ibm.com; grant.likely@secretlab.ca;
linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH 2/4] [POWERPC] Xilinx: Virtex: Enable dcr for MMIO
andNATIVE
>=20
>=20
> On Mon, 2008-05-05 at 10:56 -0700, Stephen Neuendorffer wrote:
> > FPGA designs may have need of both MMIO-based and NATIVE-based dcr
> > interfaces.
>=20
> You say _may_ ... wouldn't it be better if it was thus left to a given
> virtex based platform to enable DCR_MMIO if it uses it and leave only
> NATIVE by default ?
>=20
> > Signed-off-by: Stephen Neuendorffer
<stephen.neuendorffer@xilinx.com>
> > ---
> >  arch/powerpc/platforms/40x/Kconfig |    2 ++
> >  1 files changed, 2 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/powerpc/platforms/40x/Kconfig
b/arch/powerpc/platforms/40x/Kconfig
> > index a9260e2..b8e06df 100644
> > --- a/arch/powerpc/platforms/40x/Kconfig
> > +++ b/arch/powerpc/platforms/40x/Kconfig
> > @@ -123,6 +123,8 @@ config 405GPR
> >
> >  config XILINX_VIRTEX
> >  	bool
> > +	select PPC_DCR_MMIO
> > +	select PPC_DCR_NATIVE
> >
> >  config XILINX_VIRTEX_II_PRO
> >  	bool
>=20
