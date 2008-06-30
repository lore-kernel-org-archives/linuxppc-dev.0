Return-Path: <Monstr@seznam.cz>
Received: from mxl.seznam.cz (mxl.seznam.cz [77.75.72.44])
	by ozlabs.org (Postfix) with ESMTP id 07580DDDE6
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Jun 2008 16:51:56 +1000 (EST)
In-Reply-To: <1d3f23370806291702g4344a2f9lb62f85cbb475fca4@mail.gmail.com>
Date: Mon, 30 Jun 2008 08:48:14 +0200 (CEST)
To: =?us-ascii?Q?John=20Williams?= <john.williams@petalogix.com>
From: =?us-ascii?Q?Michal=20Simek?= <Monstr@seznam.cz>
Subject: =?us-ascii?Q?Re=3A=20=5BPATCH=2012=2F60=5D=20microblaze=5Fv4=3A=20Generic=20dts=20file=20for=20platforms?=
Mime-Version: 1.0
Message-Id: <4121.6644-31137-1228643821-1214808494@seznam.cz>
Content-Type: text/plain;
	charset="us-ascii"
Cc: linux-arch@vger.kernel.org,
	=?us-ascii?Q?Michal=20Simek?= <monstr@monstr.eu>,
	vapier.adi@gmail.com, arnd@arndb.de, matthew@wil.cx,
	microblaze-uclinux@itee.uq.edu.au, linux-kernel@vger.kernel.org,
	John.Linn@xilinx.com, linuxppc-dev@ozlabs.org,
	will.newton@gmail.com, hpa@zytor.com, drepper@redhat.com,
	alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi John, Steve and others,

in generic platform will be generic DTS which I sent in first versions. 
This DTS will be for simple platform. There is not copyright.

FDT generator add copyright notice on the top of file. I added it when I start 
to program this BSP. Xilinx only add their copyright line which is fine. 
We can talk how big can be this copyright but I am convinced that will be 
part of commented code forever because there is placed important information
which EDK version this file generated and which version of FDT this file generate.
We can talk about showing license there but I think this is out of topic now because there
won't be any license in first microblaze pack.

Michal

> Since this is a generated file, and entirely bitstream specific, does
> it make sense to include it in the kernel tree?  If it does, then is
> it produced from one of the Xilinx reference designs?  Can you add
> documentation to the header that specifies exactly which design
> version this .dts is for?

I think there's value in having a generic DTS as an example or
template, even if it doesn't correspond to any specific machine.
Agreed a comment block explaining this is valuable.

I'd almost oppose any attempt to include a standard DTS for things
like ML401 boards etc - they are just misleading.  Unless we do MD5
hashes on MHS files, and use them as the filenames, any attempt to
define a standard platform will just fail and confuse people.  Better
to show them how to generate the DTS for their system.

>> +/*
>> + * (C) Copyright 2007-2008 Xilinx, Inc.
>> + * (C) Copyright 2007-2008 Michal Simek
>> + *
>> + * Michal SIMEK <monstr@monstr.eu>
>
> If this is a generated file, then is this copyright notice even appropriate?

I agree.  I think Michal is just copying Xilinx's habit of putting
copyright headers in generated files, and it's one that we should stop
now.

Regards,

John
_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-dev
