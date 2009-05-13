Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f172.google.com (mail-gx0-f172.google.com
	[209.85.217.172]) by ozlabs.org (Postfix) with ESMTP id BB0B5DDFAD
	for <linuxppc-dev@ozlabs.org>; Wed, 13 May 2009 14:03:43 +1000 (EST)
Received: by gxk20 with SMTP id 20so789161gxk.9
	for <linuxppc-dev@ozlabs.org>; Tue, 12 May 2009 21:03:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090513023614.GJ24338@yookeroo.seuss>
References: <fa686aa40905110651r1c18b78bpe8ffebe041726695@mail.gmail.com>
	<4A08593C.4010503@dlasys.net>
	<20090511183638.F07C01438054@mail184-wa4.bigfish.com>
	<4A08C599.2030100@dlasys.net>
	<20090512005554.EEE1019D009B@mail129-dub.bigfish.com>
	<4A08E050.9000302@dlasys.net>
	<20090512042733.8D4A21400054@mail184-dub.bigfish.com>
	<fa686aa40905112230ve176b30o25abcdf5c203f6c7@mail.gmail.com>
	<20090513001048.490B533005D@mail141-va3.bigfish.com>
	<20090513023614.GJ24338@yookeroo.seuss>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 12 May 2009 22:03:22 -0600
Message-ID: <fa686aa40905122103v2c1881cav1e4989ca4a65f32@mail.gmail.com>
Subject: Re: device trees.
To: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>,
	Grant Likely <grant.likely@secretlab.ca>, linuxppc-dev@ozlabs.org,
	"David H. Lynch Jr." <dhlii@dlasys.net>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 12, 2009 at 8:36 PM, David Gibson
<david@gibson.dropbear.id.au> wrote:
> On Tue, May 12, 2009 at 05:10:46PM -0700, Stephen Neuendorffer wrote:
>>
>> Another possibility is to pad the DTB with a DESYNC command and the
>> correct pad frame, just in case it cannot be prevented.
>
> Um.. one thing I'm missing in this discussion of attaching the dtb to
> the bitstream: =A0I don't see how the bitstream becomes accessible to
> the kernel at runtime. =A0Unless you were exposing the dtb as part of
> the fpga programming, but I thought you explicitly weren't doing that
> because of limited bram space.
>
> I imagine this is simply due to my ignorance about FPGA techniques,
> but if someone could enlighten me...?

In this case the processor has access to the flash where the FPGA
bitstreams are stored and a set of registers in a CPLD which tells it
which bitstream was used to configure the FPGA.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
