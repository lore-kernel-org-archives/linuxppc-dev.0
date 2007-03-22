Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-07.arcor-online.net (mail-in-07.arcor-online.net
	[151.189.21.47])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DFE28DDED5
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Mar 2007 00:38:28 +1100 (EST)
In-Reply-To: <Pine.LNX.4.62.0703221419280.7246@pademelon.sonytel.be>
References: <20070315232956.37DAB353A6C@atlas.denx.de>
	<200703170909.13869.sr@denx.de>
	<e9c3a7c20703171117w7989adfehda99416265eef906@mail.gmail.com>
	<200703171943.27465.sr@denx.de>
	<e9c3a7c20703171209m55fd9dfsbba0e4fff5c6350d@mail.gmail.com>
	<1174320799.5044.21.camel@localhost.localdomain>
	<582f77296616b0b85ff7533bb7fea05c@kernel.crashing.org>
	<1174506924.10836.2.camel@localhost.localdomain>
	<0e5aac2ffcd189dc51f59d5891b2366c@kernel.crashing.org>
	<20070322113857.GA13547@lst.de>
	<856c539083dbd89a6f71edfd46f502f0@kernel.crashing.org>
	<Pine.LNX.4.62.0703221419280.7246@pademelon.sonytel.be>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <9db80aa3f81b1c7fa6e7bb761b7642a3@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] [PPC32] ADMA support for PPC 440SPe processors.
Date: Thu, 22 Mar 2007 14:38:20 +0100
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: linux-raid@vger.kernel.org, Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Stefan Roese <sr@denx.de>, Dan Williams <dan.j.williams@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> That sounds nice.  There are slightly fewer things called
>> SPU than there are called SPE I imagine?  Or is it just a
>> historical misnomer.
>
> AFAIK SPE is the preferred name, as the SPU is only a part of the SPE.
> That's what I was told.

And you were told right.  I was trying to be sarcastic
here, but you missed it.  Don't worry, it wasn't aimed
at you anyway ;-)


Segher
