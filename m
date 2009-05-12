Return-Path: <glikely@secretlab.ca>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.30])
	by ozlabs.org (Postfix) with ESMTP id B6562DDE45
	for <linuxppc-dev@ozlabs.org>; Tue, 12 May 2009 15:22:42 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 2so1787271ywt.39
	for <linuxppc-dev@ozlabs.org>; Mon, 11 May 2009 22:22:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090512011219.GB18223@yookeroo.seuss>
References: <4A0457BC.3040408@dlasys.net> <1242007203.7767.28.camel@concordia>
	<fa686aa40905102108l5c964893y2dfb84763e13511@mail.gmail.com>
	<4A07C664.6040609@dlasys.net>
	<fa686aa40905110651r1c18b78bpe8ffebe041726695@mail.gmail.com>
	<4A085612.9050602@dlasys.net>
	<fa686aa40905111047p5f350b0dh796564cc1383a336@mail.gmail.com>
	<4A089AC8.9080704@dlasys.net>
	<fa686aa40905111609l3feaf555taadf048714030a1@mail.gmail.com>
	<20090512011219.GB18223@yookeroo.seuss>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 11 May 2009 23:22:21 -0600
Message-ID: <fa686aa40905112222q75056b60hd9c2465b335496d1@mail.gmail.com>
Subject: Re: device trees.
To: Grant Likely <grant.likely@secretlab.ca>,
	"David H. Lynch Jr." <dhlii@dlasys.net>, linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 11, 2009 at 7:12 PM, David Gibson
<david@gibson.dropbear.id.au> wrote:
> On Mon, May 11, 2009 at 05:09:27PM -0600, Grant Likely wrote:
>> In other words; having your bootloader support FDT is preferred, but
>> not required.
>
> I wouldn't even go so far as to say it's preferred. =A0IMO, people have
> gone a bit prematurely keen on moving devtree handling into the
> firmware. =A0Putting it in the firmware has a number of advantages, but
> it also has a number of non-trivial disadvantages.

I disagree.  The more I work with it, the more I appreciate the
advantage of decoupling the kernel image file from the hardware
description.  It is valuable being able to build a single image file
that boots on a wide range of boards because the device tree passed in
by firmware.

I'm not downplaying the disadvantages and problems, but I still hold
the view that the striving for generic multiplatform kernel images is
worth the effort.

... but I do agree that hard linking the .dtb into firmware, or making
the .dtb hard to upgrade is the way of madness.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
