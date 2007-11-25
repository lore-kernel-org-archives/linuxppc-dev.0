Return-Path: <clemens.koller@anagramm.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id B26FBDDED1
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Nov 2007 04:05:41 +1100 (EST)
Message-ID: <4749AA1B.3050805@anagramm.de>
Date: Sun, 25 Nov 2007 18:00:11 +0100
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: Bai Shuwei <baishuwei@gmail.com>
Subject: Re: PCI to Parallel for PowerPC
References: <f3566d60711242106x4d56efe1w325e70c522ddd62c@mail.gmail.com>
In-Reply-To: <f3566d60711242106x4d56efe1w325e70c522ddd62c@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, shekr06@lzu.cn, puyq@lzu.cn, zhang_wei@lzu.cn,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Bai Shuwei schrieb:

Please don't cross-post.

> hi, all
>     I bought a SMC1500 stepper motor card. And it can connect with host 
> through parallel port. My target board is PowerPC 440, which hasn't 
> parrallel port. So I bought a PCI to Parallel line for SMC1500. But when 
> I run the stepper motor, I find it's not stable. I  doubt there are 
> somthing wrong with my PCI to Parallel line. So I beg somebody can tell 
> me where I can bought the  appropriate conversion line from PCI to 
> parallel, and does somebody give me some idea about how to control my 
> stepper motor through PowerPC 440? thx all

Put that PCI Card to your host where your stepper was working
properly to see if it's a hardware issue with that card.

Then it depends on how you control your stepper motor. If you use
some bit-banging (which I wouldn't recommend) to drive each winding
and want to have smooth movement, you need a very precise timing
when it comes to some "more than low-speed" stepper motors,
otherwise your motors will start to coggle.
To be precise: you will first have to figure out what leads to
the effect of "it's not stable". Do you have an Oscilloscope?

Regards,
-- 
Clemens Koller
_______________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Str. 45/1
81379 Muenchen
Germany

http://www.anagramm-technology.com
Phone: +49-89-741518-50
Fax: +49-89-741518-19
