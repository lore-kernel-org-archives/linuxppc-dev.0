Return-Path: <benh@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <0F51EC83-8969-4083-B0D7-9343D075B635@freescale.com>
References: <20050822141235.GA7110@austin.ibm.com>
	<0F51EC83-8969-4083-B0D7-9343D075B635@freescale.com>
Content-Type: text/plain
Date: Tue, 23 Aug 2005 15:41:47 +1000
Message-Id: <1124775707.5159.92.camel@gaston>
Mime-Version: 1.0
Cc: Olof Johansson <olof@lixom.net>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	ppc64-dev <linuxppc64-dev@ozlabs.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 3/3] Move all the very similar files
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2005-08-22 at 09:20 -0500, Kumar Gala wrote:
> On Aug 22, 2005, at 9:12 AM, Olof Johansson wrote:
> 
> > On Mon, Aug 22, 2005 at 04:10:30PM +1000, Stephen Rothwell wrote:
> >
> >> This moves all the very similar files - either the ppc64 file  
> >> included
> >> the ppc file or they differed in simple comments.
> >>
> >
> > [...]
> >
> >>  include/asm-powerpc/pmac_feature.h |  379
> >>
> > ++++++++++++++++++++++++++++++++++++
> >
> >>  include/asm-powerpc/pmac_low_i2c.h |   43 ++++
> >>
> >
> > Since the need is considered big enough to create  a hierarchy for
> > the code under arch/powerpc/, wouldn't something corresponding be a
> > good idea for the include files? Or do we want to clutter them with
> > all platform-specific files in one directory?
> 
> I'm in agreement, but am wondering how many of the pmac specific  
> headers could end up in arch/powerpc/platforms/pmac in the future.

Most of the ones that are in include/asm* are there because drivers
outside of arch/* use them.

Ben.
