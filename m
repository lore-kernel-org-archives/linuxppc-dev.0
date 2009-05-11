Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from VA3EHSOBE001.bigfish.com (va3ehsobe001.messaging.microsoft.com
	[216.32.180.11]) by ozlabs.org (Postfix) with ESMTP id EE854DDD1B
	for <linuxppc-dev@ozlabs.org>; Tue, 12 May 2009 01:52:38 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: device trees.
Date: Mon, 11 May 2009 08:52:30 -0700
In-Reply-To: <fa686aa40905110651r1c18b78bpe8ffebe041726695@mail.gmail.com>
References: <4A0457BC.3040408@dlasys.net>
	<fa686aa40905091351k140c64a0w27eb44908218814@mail.gmail.com>
	<1242007203.7767.28.camel@concordia>
	<fa686aa40905102108l5c964893y2dfb84763e13511@mail.gmail.com>
	<4A07C664.6040609@dlasys.net>
	<fa686aa40905110651r1c18b78bpe8ffebe041726695@mail.gmail.com>
From: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
To: "Grant Likely" <grant.likely@secretlab.ca>,
	"David H. Lynch Jr." <dhlii@dlasys.net>
Message-ID: <20090511155232.A30671B6005D@mail89-va3.bigfish.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> You *could* generate the device tree dynamically, but I think that is
> a path of diminishing returns considering that generating a .dts at
> the same time as bitstream creation time is cheap and it is small.  At
> one time Steven Neuendorffer was playing with a scheme to preload a
> section of BRAM with a gzipped .dtb so that the correct device tree is
> always present.  I really liked the idea, and I'd like to try to
> pursue it.

In fact, the code to do this should still be floating around
git.xilinx.com, although someone would likely have to bring it up to the
current kernel versions.
My intention was to treat it as two independent configuration options:

1) .dtb location is in BRAM
2) .dtb is passed compressed (regardless of location)

Steve

This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
