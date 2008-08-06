Return-Path: <John.Linn@xilinx.com>
Received: from SG2EHSOBE004.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80]) by ozlabs.org (Postfix) with ESMTP id 0C083DE390
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Aug 2008 05:03:52 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Subject: RE: hang w/ppc6xx_defconfig related to 'simple-bus' compatible
Date: Wed, 6 Aug 2008 13:03:45 -0600
In-Reply-To: <2EA786FE-D62D-4F09-BE3E-F5198D71FDB1@kernel.crashing.org>
References: <F2163BC0-08A2-4C17-AAE7-C37BD0CA66EA@kernel.crashing.org><20080806134128.GA9533@secretlab.ca><20080806173547.GD3138@ld0162-tx32.am.freescale.net><20080806180206.35FAB718066@mail214-wa4.bigfish.com>
	<2EA786FE-D62D-4F09-BE3E-F5198D71FDB1@kernel
From: John Linn <John.Linn@xilinx.com>
To: "Kumar Gala" <galak@kernel.crashing.org>,
	"Stephen Neuendorffer" <stephenn@xilinx.com>
Message-ID: <20080806190347.D7CFA10B805A@mail60-sin.bigfish.com>
Cc: Scott Wood <scottwood@freescale.com>,
	ppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I was thinking it's CONFIG_PPC_UDBG_16550.

-- John

> -----Original Message-----
> From: linuxppc-dev-bounces+john.linn=3Dxilinx.com@ozlabs.org
[mailto:linuxppc-dev-
> bounces+john.linn=3Dxilinx.com@ozlabs.org] On Behalf Of Kumar Gala
> Sent: Wednesday, August 06, 2008 12:39 PM
> To: Stephen Neuendorffer
> Cc: Scott Wood; ppc-dev list
> Subject: Re: hang w/ppc6xx_defconfig related to 'simple-bus'
compatible
> =

> Do you know what the CONFIG_ option is called for the legacy driver.
> =

> - k
> =

> On Aug 6, 2008, at 1:02 PM, Stephen Neuendorffer wrote:
> =

> >
> > The problem (in my case) is that the legacy-serial driver doesn't
> > accept
> > all of the 16550 configurations accepted by the regular ns16550
> > driver.
> > The problem is not related to simple-bus, but only became visible
when
> > simple-bus bindings are used because the legacy-serial driver
> > specifically looks for an ns16550 node contained by a simple-bus.
> >
> > Most likely the hpcn_defconfig disables the legacy-serial driver
> > altogether.
> >
> > Steve
> >
> >> -----Original Message-----
> >> From:
linuxppc-dev-bounces+stephen.neuendorffer=3Dxilinx.com@ozlabs.org
> > [mailto:linuxppc-dev-
> >> bounces+stephen.neuendorffer=3Dxilinx.com@ozlabs.org] On Behalf Of
> >> Scott
> > Wood
> >> Sent: Wednesday, August 06, 2008 10:36 AM
> >> To: grant.likely@secretlab.ca
> >> Cc: ppc-dev list
> >> Subject: Re: hang w/ppc6xx_defconfig related to 'simple-bus'
> > compatible
> >>
> >> On Wed, Aug 06, 2008 at 07:41:28AM -0600, Grant Likely wrote:
> >>> On Tue, Aug 05, 2008 at 08:21:31AM -0500, Kumar Gala wrote:
> >>>> I'm trying to get the ppc6xx_defconfig booting on any 8641
> > (74xx/e600)
> >>>> system.  If I remove the 'simple-bus' compatible from the soc
node
> > in
> >>>> the .dts it works.  Otherwise it hangs at but and looks to be
> > crashed in
> >>>> the serial driver due to accessing memory at 0.
> >>>>
> >>>> I've tried the same .dts (w/'simple-bus') using the
> >>>> mpc8641_hpcn_defconfig and things work.
> >>>
> >>> The Xilinx folks hit something similar.  ns16550 nodes get matched
> > if
> >>> the parent claims simple-bus.  If extra stuff needs to be done to
> > use
> >>> that port, then bad things happen.
> >>
> >> If extra stuff needs to be done, it shouldn't claim to be a
> > simple-bus.
> >>
> >> -Scott
> >> _______________________________________________
> >> Linuxppc-dev mailing list
> >> Linuxppc-dev@ozlabs.org
> >> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> >
> >
> > This email and any attachments are intended for the sole use of the
> > named recipient(s) and contain(s) confidential information that may
> > be proprietary, privileged or copyrighted under applicable law. If
> > you are not the intended recipient, do not read, copy, or forward
> > this email message or any attachments. Delete this email message and
> > any attachments immediately.
> >
> >
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-dev
> =

> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev


This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
