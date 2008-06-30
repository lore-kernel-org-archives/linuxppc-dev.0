Return-Path: <john.williams@petalogix.com>
Received: from hu-out-0506.google.com (hu-out-0506.google.com [72.14.214.228])
	by ozlabs.org (Postfix) with ESMTP id 404F6DDE22
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Jun 2008 10:02:30 +1000 (EST)
Received: by hu-out-0506.google.com with SMTP id 34so3325434hue.9
	for <linuxppc-dev@ozlabs.org>; Sun, 29 Jun 2008 17:02:27 -0700 (PDT)
Message-ID: <1d3f23370806291702g4344a2f9lb62f85cbb475fca4@mail.gmail.com>
Date: Mon, 30 Jun 2008 10:02:21 +1000
From: "John Williams" <john.williams@petalogix.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [PATCH 12/60] microblaze_v4: Generic dts file for platforms
In-Reply-To: <fa686aa40806272249l7eae0c34k43a20ad41672b77a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1214483429-32360-1-git-send-email-monstr@seznam.cz>
	<1214483429-32360-6-git-send-email-monstr@seznam.cz>
	<1214483429-32360-7-git-send-email-monstr@seznam.cz>
	<1214483429-32360-8-git-send-email-monstr@seznam.cz>
	<1214483429-32360-9-git-send-email-monstr@seznam.cz>
	<1214483429-32360-10-git-send-email-monstr@seznam.cz>
	<1214483429-32360-11-git-send-email-monstr@seznam.cz>
	<1214483429-32360-12-git-send-email-monstr@seznam.cz>
	<1214483429-32360-13-git-send-email-monstr@seznam.cz>
	<fa686aa40806272249l7eae0c34k43a20ad41672b77a@mail.gmail.com>
Cc: linux-arch@vger.kernel.org, Michal Simek <monstr@monstr.eu>,
	vapier.adi@gmail.com, arnd@arndb.de, matthew@wil.cx,
	microblaze-uclinux@itee.uq.edu.au, linux-kernel@vger.kernel.org,
	drepper@redhat.com, linuxppc-dev@ozlabs.org,
	will.newton@gmail.com, hpa@zytor.com, monstr@seznam.cz,
	John.Linn@xilinx.com, alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Jun 28, 2008 at 3:49 PM, Grant Likely <grant.likely@secretlab.ca> wrote:
> On Thu, Jun 26, 2008 at 5:29 AM,  <monstr@seznam.cz> wrote:
>> From: Michal Simek <monstr@monstr.eu>

>>  arch/microblaze/platform/generic/system.dts |  300 +++++++++++++++++++++++++++

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
