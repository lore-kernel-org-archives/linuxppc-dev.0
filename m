Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id B279CDDF27
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Apr 2007 04:15:05 +1000 (EST)
Date: Wed, 11 Apr 2007 13:32:25 -0500
To: Kim Phillips <kim.phillips@freescale.com>
Subject: Re: [PATCH 1/4] powerpc: document max-speed and interface-type
	properties
Message-ID: <20070411183225.GA30055@lixom.net>
References: <20070410165639.1b619c34.kim.phillips@freescale.com>
	<20070410224809.GA20848@lixom.net>
	<20070410181949.2a26d646.kim.phillips@freescale.com>
	<20070411014958.GB20848@lixom.net>
	<20070411130913.68501459.kim.phillips@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070411130913.68501459.kim.phillips@freescale.com>
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 11, 2007 at 01:09:13PM -0500, Kim Phillips wrote:
> On Tue, 10 Apr 2007 20:49:58 -0500
> olof@lixom.net (Olof Johansson) wrote:
> 
> > On Tue, Apr 10, 2007 at 06:19:49PM -0500, Kim Phillips wrote:
> > > On Tue, 10 Apr 2007 17:48:09 -0500
> > > olof@lixom.net (Olof Johansson) wrote:
> > > 
> > > > 
> > > > Do you really need to set max speed for devices that are at the default
> > > > max speed for the interface type? Seems redundant.
> > > > 
> > > > If for example there's an rgmii interface that for some reason only can
> > > > handle 100Mbit, that'd be different.
> > > 
> > > rgmii@100/10Mbit are supported interface/speed combinations for our MDS boards; see pdf p. 72 in:
> > > 
> > > http://www.freescale.com/files/32bit/doc/user_guide/MPC8360EAMDSUM.pdf
> > 
> > Right, my bad. Sorry for the confusion -- That comment was meant for the
> > next patch in the series where you specify the speed even for interfaces
> > that support the full max.
> > 
> just to be clear, you want the logic in ucc_geth (phylib
> patch) to be enhanced such that it sets the maximum max-speed
> based on the interface-type, e.g. if rgmii specified and
> max-speed not specified, assign max-speed = 1000?

Yes, that would seem logical, wouldn't it?


-Olof
