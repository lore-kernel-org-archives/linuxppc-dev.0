Return-Path: <dgibson@ozlabs.org>
Date: Wed, 9 May 2007 09:30:26 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Loeliger Jon-LOELIGER <jdl@freescale.com>
Subject: Re: [PATCH 3/3] [POWERPC] dts: kill hardcoded phandles
Message-ID: <20070508233026.GA2112@localhost.localdomain>
References: <20070508055431.GA21009@localhost.localdomain>
	<AF0367BA48C55940A43CCF08DF35553C012AA472@az33exm24.fsl.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AF0367BA48C55940A43CCF08DF35553C012AA472@az33exm24.fsl.freescale.net>
Cc: linux-pcmcia@lists.infradead.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 08, 2007 at 07:29:20AM -0700, Jon Loeliger wrote:
> 
> > > -       interrupt-controller@f8200000 {
> > > -               linux,phandle = <f8200000>;
> > > +		pci_pic:interrupt-controller@f8200000 {
> > 
> > I'd like to establish a convention of putting a space after the : and
> > using capitals for labels unless there's a strong reason not to in a
> > particular case.  It makes them easier to visually distinguish next to
> > the node name.
> 
> Colon-space is easy and I'll buy it.
> I'm not big on uppercase shouting, though.

I don't think it will really be any more shouty than the convention of
using caps for simple constant #defines.  The Ebony device tree uses
this now, and I think it turns out quite well (though in that case
there's the additional reason to use caps that the labels are based on
the component names used in the 440GP user manual, which are given as
caps).

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
