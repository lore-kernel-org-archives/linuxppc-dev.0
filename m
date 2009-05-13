Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from VA3EHSOBE005.bigfish.com (va3ehsobe005.messaging.microsoft.com
	[216.32.180.15]) by ozlabs.org (Postfix) with ESMTP id C2983DDFAC
	for <linuxppc-dev@ozlabs.org>; Wed, 13 May 2009 10:10:54 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Subject: RE: device trees.
Date: Tue, 12 May 2009 17:10:46 -0700
In-Reply-To: <fa686aa40905112230ve176b30o25abcdf5c203f6c7@mail.gmail.com>
References: <4A0457BC.3040408@dlasys.net> <4A07C664.6040609@dlasys.net>
	<fa686aa40905110651r1c18b78bpe8ffebe041726695@mail.gmail.com>
	<20090511155232.A30671B6005D@mail89-va3.bigfish.com>
	<4A08593C.4010503@dlasys.net>
	<20090511183638.F07C01438054@mail184-wa4.bigfish.com>
	<4A08C599.2030100@dlasys.net>
	<20090512005554.EEE1019D009B@mail129-dub.bigfish.com>
	<4A08E050.9000302@dlasys.net>
	<20090512042733.8D4A21400054@mail184-dub.bigfish.com>
	<fa686aa40905112230ve176b30o25abcdf5c203f6c7@mail.gmail.com>
From: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Message-ID: <20090513001048.490B533005D@mail141-va3.bigfish.com>
Cc: linuxppc-dev@ozlabs.org, "David H. Lynch Jr." <dhlii@dlasys.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Another possibility is to pad the DTB with a DESYNC command and the correct=
 pad frame, just in case it cannot be prevented.

Steve

> -----Original Message-----
> From: Grant Likely [mailto:grant.likely@secretlab.ca]
> Sent: Monday, May 11, 2009 10:30 PM
> To: Stephen Neuendorffer
> Cc: David H. Lynch Jr.; linuxppc-dev@ozlabs.org
> Subject: Re: device trees.
> =

> On Mon, May 11, 2009 at 10:27 PM, Stephen Neuendorffer
> <stephen.neuendorffer@xilinx.com> wrote:
> >> > OK, so the key question seems to be *when* the bitstream is
> > associated
> >> > with the
> >> > device tree. =A0If at bitstream generation time, you can prepend the=

> > .dtb
> >> > to the bitstream. =A0As long as the dtb doesn't contain the magic
> >> > bitstream start code, you can go back and access it later.
> >> >
> >> You really mean prepend ? I was presuming that things would work
> > better
> >> if it was appended ?
> >
> > Yes, actually prepend is simpler because you don't have to know the siz=
e
> > of the bitstream.
> > Everything before the SYNC code in the bitstream is ignored.
> =

> ...In this case, might need to preprocess the .dtb the escape out the
> possibility of a sync code appearing.
> =

> g.
> =

> --
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.


This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
