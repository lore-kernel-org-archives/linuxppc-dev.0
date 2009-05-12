Return-Path: <glikely@secretlab.ca>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.29])
	by ozlabs.org (Postfix) with ESMTP id 9324BDDEE5
	for <linuxppc-dev@ozlabs.org>; Tue, 12 May 2009 15:30:43 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 2so1788599ywt.39
	for <linuxppc-dev@ozlabs.org>; Mon, 11 May 2009 22:30:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090512042733.8D4A21400054@mail184-dub.bigfish.com>
References: <4A0457BC.3040408@dlasys.net> <4A07C664.6040609@dlasys.net>
	<fa686aa40905110651r1c18b78bpe8ffebe041726695@mail.gmail.com>
	<20090511155232.A30671B6005D@mail89-va3.bigfish.com>
	<4A08593C.4010503@dlasys.net>
	<20090511183638.F07C01438054@mail184-wa4.bigfish.com>
	<4A08C599.2030100@dlasys.net>
	<20090512005554.EEE1019D009B@mail129-dub.bigfish.com>
	<4A08E050.9000302@dlasys.net>
	<20090512042733.8D4A21400054@mail184-dub.bigfish.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 11 May 2009 23:30:22 -0600
Message-ID: <fa686aa40905112230ve176b30o25abcdf5c203f6c7@mail.gmail.com>
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

On Mon, May 11, 2009 at 10:27 PM, Stephen Neuendorffer
<stephen.neuendorffer@xilinx.com> wrote:
>> > OK, so the key question seems to be *when* the bitstream is
> associated
>> > with the
>> > device tree. =A0If at bitstream generation time, you can prepend the
> .dtb
>> > to the bitstream. =A0As long as the dtb doesn't contain the magic
>> > bitstream start code, you can go back and access it later.
>> >
>> You really mean prepend ? I was presuming that things would work
> better
>> if it was appended ?
>
> Yes, actually prepend is simpler because you don't have to know the size
> of the bitstream.
> Everything before the SYNC code in the bitstream is ignored.

...In this case, might need to preprocess the .dtb the escape out the
possibility of a sync code appearing.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
