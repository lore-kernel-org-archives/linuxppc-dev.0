Return-Path: <wfarnsworth@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id 29AAADDD0B
	for <linuxppc-dev@ozlabs.org>; Fri, 18 May 2007 02:59:02 +1000 (EST)
Subject: Re: [PATCH 5/5] PCI fixes for the MPC8641 Rev 2.0 silicon and Rev
	1.02hardware
From: Wade Farnsworth <wfarnsworth@mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <744CD970-5421-47D6-A30A-C7C79BE21BE8@kernel.crashing.org>
References: <1179245829.8132.100.camel@rhino> <1179247809.8132.138.camel@rhino>
	<46B96294322F7D458F9648B60E15112C23441B@zch01exm26.fsl.freescale.net>
	<1179417813.8132.250.camel@rhino>
	<744CD970-5421-47D6-A30A-C7C79BE21BE8@kernel.crashing.org>
Content-Type: text/plain
Date: Thu, 17 May 2007 09:58:59 -0700
Message-Id: <1179421139.8132.256.camel@rhino>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Zhang Wei-r63237 <Wei.Zhang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-05-17 at 11:14 -0500, Kumar Gala wrote:
> On May 17, 2007, at 11:03 AM, Wade Farnsworth wrote:
> 
> > On Thu, 2007-05-17 at 10:50 +0800, Zhang Wei-r63237 wrote:
> >> Hi,
> >>
> >> If you add below sector to pci@8000, please remove the interrupt-map
> >> sector from pci@8000.
> >
> > Correct me if I'm wrong, but I think if the interrupt-map for pci@8000
> > is removed then the pci devices on the revision 1.0 board will not get
> > the correct interrupts.  I don't currently have a rev 1.0 to test
> > though.  Can someone with a rev 1.0 HPCN board confirm this?
> 
> If I'm understanding things this might best be handled by two  
> different dts.  Is this because of board changes or chip/silicon  
> changes?
> 
> - k
> 

Yes.  On rev 1.0 boards, all of the devices on the south bridge are on
bus 0, while on rev 1.02, the devices on the southbridge are on bus 2.

I'd like to use the same dts for both rev's if possible.  But if there
is a reason why they shouldn't, I suppose I could create a separate dts.

--Wade
