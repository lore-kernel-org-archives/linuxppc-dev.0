Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f172.google.com (mail-gx0-f172.google.com
	[209.85.217.172]) by ozlabs.org (Postfix) with ESMTP id E8AF6DDFB0
	for <linuxppc-dev@ozlabs.org>; Wed, 13 May 2009 10:01:31 +1000 (EST)
Received: by gxk20 with SMTP id 20so603359gxk.9
	for <linuxppc-dev@ozlabs.org>; Tue, 12 May 2009 17:01:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090512232446.GB24338@yookeroo.seuss>
References: <1242007203.7767.28.camel@concordia> <4A07C664.6040609@dlasys.net>
	<fa686aa40905110651r1c18b78bpe8ffebe041726695@mail.gmail.com>
	<4A085612.9050602@dlasys.net>
	<fa686aa40905111047p5f350b0dh796564cc1383a336@mail.gmail.com>
	<4A089AC8.9080704@dlasys.net>
	<fa686aa40905111609l3feaf555taadf048714030a1@mail.gmail.com>
	<20090512011219.GB18223@yookeroo.seuss>
	<fa686aa40905112222q75056b60hd9c2465b335496d1@mail.gmail.com>
	<20090512232446.GB24338@yookeroo.seuss>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 12 May 2009 18:01:09 -0600
Message-ID: <fa686aa40905121701s6dae2b9bwb5089c589eafa3ad@mail.gmail.com>
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

On Tue, May 12, 2009 at 5:24 PM, David Gibson
<david@gibson.dropbear.id.au> wrote:
> On Mon, May 11, 2009 at 11:22:21PM -0600, Grant Likely wrote:
>> ... but I do agree that hard linking the .dtb into firmware, or making
>> the .dtb hard to upgrade is the way of madness.
>
> Ah, we're talking at cross purposes a bit then. =A0Yeah, I'm talking
> about the situation where the dtb is part of the firmware, or at least
> as difficult / inconvenient to update as the firmware. =A0If the dtb is
> separate from the kernel, but as easy to update / switch as the
> kernel, that is indeed a very nice setup.

:-D

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
