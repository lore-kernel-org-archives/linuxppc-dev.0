Return-Path: <mgreer@mvista.com>
Date: Mon, 30 Apr 2007 11:08:39 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Jon Loeliger <jdl@freescale.com>
Subject: Re: [PATCH 11/13] powerpc: Add DTS file for the Motorola PrPMC2800
	platform
Message-ID: <20070430180839.GA7673@mag.az.mvista.com>
References: <20070425234630.GA4046@mag.az.mvista.com>
	<20070426000151.GM4046@mag.az.mvista.com>
	<20070427204148.GA14490@mag.az.mvista.com>
	<1177951541.4616.4.camel@ld0161-tx32>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1177951541.4616.4.camel@ld0161-tx32>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Apr 30, 2007 at 11:45:41AM -0500, Jon Loeliger wrote:
> On Fri, 2007-04-27 at 15:41, Mark A. Greer wrote:
> > [PATCH 11/13] powerpc: Add DTS file for the Motorola PrPMC2800 platform
> > 
> > Signed-off-by: Mark A. Greer <mgreer@mvista.com>
> > ---
> > 
> >  prpmc2800.dts |  321 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 321 insertions(+)
> > 
> > Index: powerpc/arch/powerpc/boot/dts/prpmc2800.dts
> > ===================================================================
> > --- /dev/null
> > +++ powerpc/arch/powerpc/boot/dts/prpmc2800.dts
> > @@ -0,0 +1,321 @@
> > +/* Device Tree Source for Motorola PrPMC2800
> > + *
> > + * Author: Mark A. Greer <mgreer@mvista.com>
> > + *
> > + * 2007 (c) MontaVista, Software, Inc.  This file is licensed under
> > + * the terms of the GNU General Public License version 2.  This program
> > + * is licensed "as is" without any warranty of any kind, whether express
> > + * or implied.
> > + *
> > + * To build:
> > + *   dtc -I dts -O asm -o prpmc2800.S -V 16 -b 0 prpmc2800.dts
> > + *   dtc -I dts -O dtb -o prpmc2800.dtb -V 16 -b 0 prpmc2800.dts
> 
> Any real reason to keep the -V 16 in there?
> If not, please remove this advice!

Nope.  It just got copied along...

Mark
