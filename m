Return-Path: <wfarnsworth@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id AA0BCDDEF5
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2008 08:19:47 +1100 (EST)
Subject: Re: [PATCH v2 1/2] Add localbus and flash nodes to mpc8641_hpcn.dts
From: Wade Farnsworth <wfarnsworth@mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <65C80AAA-CC92-41BC-86FC-D74A2C7D5059@kernel.crashing.org>
References: <1201019917.5716.154.camel@rhino>
	<1201032819.5716.170.camel@rhino> <47965506.9070305@freescale.com>
	<65C80AAA-CC92-41BC-86FC-D74A2C7D5059@kernel.crashing.org>
Content-Type: text/plain
Date: Tue, 22 Jan 2008 14:19:43 -0700
Message-Id: <1201036783.5716.177.camel@rhino>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-01-22 at 15:07 -0600, Kumar Gala wrote:
> On Jan 22, 2008, at 2:41 PM, Jon Loeliger wrote:
> 
> > Wade Farnsworth wrote:
> >
> >> +
> >> +		ranges = <0 0 ff800000 00800000
> >> +			  1 0 fe000000 01000000
> >> +			  2 0 f8200000 00100000
> >> +			  3 0 f8100000 00100000>;
> >> +
> >
> > I think you want just:
> >
> >   ranges = <0 0 f8000000 8000000>

Wouldn't that cover all of the CCSR regs, not just CS0?

> >
> > right?  And is it really on CS 0?
> 
> I'm assuming he's listed CS1, CS2, and CS3 even though we don't have a  
> children yet.  (second flash chip, CF, and pixis).

Yes that's correct.

--Wade
