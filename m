Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-07.arcor-online.net (mail-in-07.arcor-online.net
	[151.189.21.47])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3C88ADDE1E
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Jun 2007 00:18:44 +1000 (EST)
In-Reply-To: <Pine.LNX.4.62.0706131609190.20109@pademelon.sonytel.be>
References: <20070612181825.730300780@am.sony.com>>
	<466EEC01.6080807@am.sony.com>
	<f7c4ca74d3e2031e01264f31f09e515a@kernel.crashing.org>
	<20070613084023.GA28629@aepfle.de>
	<0502b4de346bce374f98c49a99be50c1@kernel.crashing.org>
	<20070613112448.GA29239@aepfle.de>
	<184b5119eca8beae9a28453096b6fe26@kernel.crashing.org>
	<Pine.LNX.4.62.0706131542280.20109@pademelon.sonytel.be>
	<b6fa43eadda7c64fe95ed99e78dcf277@kernel.crashing.org>
	<Pine.LNX.4.62.0706131609190.20109@pademelon.sonytel.be>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <d13fe04437156ea27f697210f00aedf0@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [patch 29/30] PS3: Device tree source.
Date: Wed, 13 Jun 2007 16:18:36 +0200
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: linuxppc-dev@ozlabs.org, Olaf Hering <olaf@aepfle.de>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> It is built-in for the kboot kernel.
>>> It is passed from the bootstrap to the 2nd stage kernel.
>>
>> The 2nd stage kernel isn't userland.
>
> If you consider the kboot kernel `firmware', there can be breakage 
> between
> firmware and kernel versions.

Ah I see.  Your first kernel is in flash, the second
on disk?

There's no reason not to have the second kernel
recognise the old device tree names, at least for
a while.  Nothing special here.  This is independent
from either or not correcting the device tree, and
correcting the kernel to look at the right properties
if possible (it can always fall back to the bad old
ways, if it cannot figure out what machine type it is
running on otherwise).


Segher
