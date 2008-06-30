Return-Path: <John.Linn@xilinx.com>
Received: from WA4EHSOBE005.bigfish.com (outbound-wa4.frontbridge.com
	[216.32.181.16]) by ozlabs.org (Postfix) with ESMTP id E6D81DDFAF
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Jul 2008 02:49:50 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Subject: RE: [PATCH] [POWERPC] Xilinx: add compatibility for 'simple-bus'.
Date: Mon, 30 Jun 2008 10:49:43 -0600
In-Reply-To: <977C41F842E66D4CB2E41332313B6150062A27B7@XSJ-EXCHVS1.xlnx.xilinx.com>
References: <fa686aa40806281333i5ae1833fg561622640b5d3a4e@mail.gmail.com>
	<20080630034548.A10A81750069@mail131-sin.bigfish.com>
	<20080630163429.GE17916@secretlab.ca>
	<977C41F842E66D4CB2E41332313B6150062A27B7@XSJ-EXCHVS1.xlnx.xilinx.com>
From: John Linn <John.Linn@xilinx.com>
To: "Stephen Neuendorffer" <stephenn@xilinx.com>, <grant.likely@secretlab.ca>
Message-ID: <20080630164946.19CFF268053@mail219-wa4.bigfish.com>
Cc: linuxppc-dev@ozlabs.org, git <git@xilinx.com>, dwg@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I'll give it a try, sounds easy.

-- John

-----Original Message-----
From: Stephen Neuendorffer =

Sent: Monday, June 30, 2008 10:49 AM
To: grant.likely@secretlab.ca; John Linn
Cc: dwg@au1.ibm.com; jwboyer@linux.vnet.ibm.com;
linuxppc-dev@ozlabs.org; git
Subject: RE: [PATCH] [POWERPC] Xilinx: add compatibility for
'simple-bus'.


Ah.. good idea... hadn't thought of that, I guess.

John Linn: I have no time to look at this.  Can you see if such a fix
fixes the problem?

Steve

> -----Original Message-----
> From: Grant Likely [mailto:glikely@secretlab.ca] On Behalf Of Grant
Likely
> Sent: Monday, June 30, 2008 9:34 AM
> To: Stephen Neuendorffer
> Cc: dwg@au1.ibm.com; jwboyer@linux.vnet.ibm.com;
linuxppc-dev@ozlabs.org; git
> Subject: Re: [PATCH] [POWERPC] Xilinx: add compatibility for
'simple-bus'.
> =

> Stephen Neuendorffer wrote:
> > Grant Likely wrote:
> > > > I think the easiest solution is to change the Kconfig so that
> > > > PPC_UDBG_16550 is only selected based on !XILINX_VIRTEX.  I've
done this
> > > > in my tree, but I've been swamped with other things at the
moment, so I
> > > > haven't verified it.
> > >
> > > This is an easy solution, but it is not a good one.  Doing so
would
> > > break UDBG on other 405 boards when building multiplatform
kernels.
> > > It would be better to teach legacy serial about the shift and
offset.
> > > Alternately, add code to add_legacy_soc_port() to skip it if the
> > > shift/offset properties are present.
> >
> > Is there really much of a chance of that, given the differences
> > with the bootwrappers?  Does anyone care enough about legacy_serial
> > for this to matter?   My impression was that legacy serial was not
> > preferred anyway...
> =

> You never know, a single kernel build can be wrapped multiple times,
and
> besides, it is a trivial fix.  Just add a test for the presence of
> reg-shift and bail if it is present.
> =

> I don't know much about the history of legacy serial, but I do not
> support adding multiplatform restrictions when not needed.
> legacy_serial may be crusty, but it does have the advantage of
> supporting UDBG which is a useful feature.  It may or may not go away.
> =

> Cheers,
> g.
> =



This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
