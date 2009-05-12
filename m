Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f220.google.com (mail-gx0-f220.google.com
	[209.85.217.220]) by ozlabs.org (Postfix) with ESMTP id E41D1DDEE0
	for <linuxppc-dev@ozlabs.org>; Tue, 12 May 2009 10:04:37 +1000 (EST)
Received: by gxk20 with SMTP id 20so6361333gxk.9
	for <linuxppc-dev@ozlabs.org>; Mon, 11 May 2009 17:04:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090511231915.007AC1430052@mail201-wa4.bigfish.com>
References: <4A0457BC.3040408@dlasys.net>
	<fa686aa40905091351k140c64a0w27eb44908218814@mail.gmail.com>
	<1242007203.7767.28.camel@concordia>
	<fa686aa40905102108l5c964893y2dfb84763e13511@mail.gmail.com>
	<4A07C664.6040609@dlasys.net>
	<fa686aa40905110651r1c18b78bpe8ffebe041726695@mail.gmail.com>
	<4A085612.9050602@dlasys.net>
	<fa686aa40905111047p5f350b0dh796564cc1383a336@mail.gmail.com>
	<4A089AC8.9080704@dlasys.net>
	<20090511231915.007AC1430052@mail201-wa4.bigfish.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 11 May 2009 18:04:16 -0600
Message-ID: <fa686aa40905111704g29d18835w249c89b97d22fc0d@mail.gmail.com>
Subject: Re: device trees.
To: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, "David H. Lynch Jr." <dhlii@dlasys.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 11, 2009 at 5:19 PM, Stephen Neuendorffer
<stephen.neuendorffer@xilinx.com> wrote:
>
>> >> =A0 =A0The best alternative to creating the device tree dynamically
> would
>> >> be to
>> >> =A0 =A0append the devicetree to the bitimage in a way the boot loader
> could
>> >> always find it.
>> >>
>> >
>> > That sounds like a good solution to me.
>> >
>> =A0 =A0 I am glad you like it. If Xilinx would like to offer any advice =
as
>> to how to prepend a device tree to the end of a bit file without
>> =A0 =A0 foreclosing any of their future plans or .... I would be happy t=
o
>> look at implementing it.
>
> There are options here...
>
> For the benefit of the mailing list: they are tied into how the FPGA
> configuration is loaded, and the
> particular FPGA family. =A0By far the most portable/generic option is to
> simply use an initialized BRAM for this.
>
> David: If you would like to have a discussion regarding particular
> design tradeoffs, I'd be happy to, but since I doubt there is anyone on
> this list who is interested in the vagaries of FPGA configuration
> methods, I suggest we have the discussion privately.

I disagree.  There are lots of lurkers on this list who care about
virtex stuff, not to mention non-lurkers like me.  :-)  I would at
least like to be a fly on the wall of any such discussion.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
