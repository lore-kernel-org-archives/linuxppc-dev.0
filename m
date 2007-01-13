Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (147.175.241.83.in-addr.dgcsystems.net
	[83.241.175.147]) by ozlabs.org (Postfix) with ESMTP id 20A6DDDE07
	for <linuxppc-dev@ozlabs.org>; Sun, 14 Jan 2007 03:51:19 +1100 (EST)
From: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
To: "'Kumar Gala'" <galak@kernel.crashing.org>
Subject: RE: latest linux git doesn't compile ucc_geth_phy.c and ucc_geth.c
Date: Sat, 13 Jan 2007 17:51:13 +0100
Message-ID: <020e01c73733$0932c350$020120ac@Jocke>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <00a601c730cc$2c3aef70$1e67a8c0@Jocke>
Cc: 'linuxppc-dev' <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: 
> linuxppc-dev-bounces+joakim.tjernlund=transmode.se@ozlabs.org 
> [mailto:linuxppc-dev-bounces+joakim.tjernlund=transmode.se@ozl
> abs.org] On Behalf Of Joakim Tjernlund
> Sent: den 5 januari 2007 14:20
> To: 'Kumar Gala'
> Cc: 'linuxppc-dev'
> Subject: RE: latest linux git doesn't compile ucc_geth_phy.c 
> and ucc_geth.c
> 
> > -----Original Message-----
> > From: Kumar Gala [mailto:galak@kernel.crashing.org] 
> > Sent: den 18 december 2006 19:44
> > To: Timur Tabi
> > Cc: Joakim Tjernlund; 'linuxppc-dev'
> > Subject: Re: latest linux git doesn't compile ucc_geth_phy.c 
> > and ucc_geth.c
> > 
> > 
> > On Dec 18, 2006, at 9:56 AM, Timur Tabi wrote:
> > 
> > > Joakim Tjernlund wrote:
> > >
> > >>> I've tested these on an 8360EMDS, and Kumar has reviewed and
> > >>> signed off on the
> > >>> code, so I think they're good.  Please let me know if 
> they're not.
> > >>
> > >> Has these been sent upstream yet? Didn't se them in 
> linux tree as  
> > >> of now.
> > >
> > > I posted the patches to the linuxppc-dev and netdev mailing 
> > lists.   
> > > At this
> > > point, these patches are at the whim of Paul M. and/or 
> Jeff G. for  
> > > merging.
> > > Since the holidays are upon us, I'm not surprised that 
> things are  
> > > taking longer
> > > than normal.
> > 
> > There really at the whim of Jeff G. since they are 
> completely driver  
> > related.  I pinged Jeff G. to hopefully pick them up and push them  
> > for 2.6.20.
> 
> I do think these has been forgotten.
> 
>  Jocke

These are still not in linus tree. Tried to ping Jeff/netdev a couple of times
but nothing yet. Can't you push these via Paulus tree instead as Jeff seems to
be doing other things?

The actual patches are here:
http://ozlabs.org/pipermail/linuxppc-dev/2006-December/029247.html
http://ozlabs.org/pipermail/linuxppc-dev/2006-December/029248.html

 Jocke
