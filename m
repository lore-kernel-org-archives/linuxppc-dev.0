Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from WA4EHSOBE006.bigfish.com (wa4ehsobe005.messaging.microsoft.com
	[216.32.181.15]) by ozlabs.org (Postfix) with ESMTP id 65565DDF85
	for <linuxppc-dev@ozlabs.org>; Tue, 12 May 2009 09:34:27 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: device trees.
Date: Mon, 11 May 2009 16:19:15 -0700
In-Reply-To: <4A089AC8.9080704@dlasys.net>
References: <4A0457BC.3040408@dlasys.net>
	<fa686aa40905091351k140c64a0w27eb44908218814@mail.gmail.com>
	<1242007203.7767.28.camel@concordia>
	<fa686aa40905102108l5c964893y2dfb84763e13511@mail.gmail.com>
	<4A07C664.6040609@dlasys.net>
	<fa686aa40905110651r1c18b78bpe8ffebe041726695@mail.gmail.com>
	<4A085612.9050602@dlasys.net>
	<fa686aa40905111047p5f350b0dh796564cc1383a336@mail.gmail.com>
	<4A089AC8.9080704@dlasys.net>
From: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
To: "David H. Lynch Jr." <dhlii@dlasys.net>,
	<grant.likely@secretlab.ca>
Message-ID: <20090511231915.007AC1430052@mail201-wa4.bigfish.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> >>    The best alternative to creating the device tree dynamically
would
> >> be to
> >>    append the devicetree to the bitimage in a way the boot loader
could
> >> always find it.
> >>
> >
> > That sounds like a good solution to me.
> >
>     I am glad you like it. If Xilinx would like to offer any advice as
> to how to prepend a device tree to the end of a bit file without
>     foreclosing any of their future plans or .... I would be happy to
> look at implementing it.

There are options here...

For the benefit of the mailing list: they are tied into how the FPGA
configuration is loaded, and the
particular FPGA family.  By far the most portable/generic option is to
simply use an initialized BRAM for this.

David: If you would like to have a discussion regarding particular
design tradeoffs, I'd be happy to, but since I doubt there is anyone on
this list who is interested in the vagaries of FPGA configuration
methods, I suggest we have the discussion privately.

Steve


This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
