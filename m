Return-Path: <rpurdie@rpsys.net>
Received: from tim.rpsys.net (tim.rpsys.net [194.106.48.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6E81ADE11B
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Apr 2008 07:00:45 +1000 (EST)
Subject: Re: [RESEND][PATCH][POWERPC] PIKA Warp: Update platform code to
	supportRev B boards
From: Richard Purdie <rpurdie@rpsys.net>
To: Sean MacLennan <smaclennan@pikatech.com>
In-Reply-To: <20080428135905.4c037b4b@lappy.seanm.ca>
References: <20080417152251.2bf07219@lappy.seanm.ca>
	<20080427152546.1e26b145@lappy.seanm.ca>
	<20080428105859.daef4d71.sfr@canb.auug.org.au>
	<fa686aa40804271851t6d762a1et76fa3cc02c2205fe@mail.gmail.com>
	<20080427222514.1086f2d3@lappy.seanm.ca>
	<fa686aa40804272147y54df795fj7e8dad89dc237ecd@mail.gmail.com>
	<20080428131001.052be010@lappy.seanm.ca>
	<fa686aa40804281044p5fa0ef9s15107cc38fafc9fa@mail.gmail.com>
	<20080428135905.4c037b4b@lappy.seanm.ca>
Content-Type: text/plain
Date: Mon, 28 Apr 2008 21:44:05 +0100
Message-Id: <1209415445.5923.59.camel@dax.rpnet.com>
Mime-Version: 1.0
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Sean MacLennan <sean.maclennan@ottawa.kanatek.ca>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mon, 2008-04-28 at 13:59 -0400, Sean MacLennan wrote:
> On Mon, 28 Apr 2008 11:44:19 -0600
> "Grant Likely" <grant.likely@secretlab.ca> wrote:
> 
> > This looks appropriate.  You'll need to make sure that the values in
> > the linux,name property meet the Linux LED naming guidelines.  I think
> > this is covered in Documentation/leds-class.c.  You can also as
> > Richard Purdie; the LED subsystem maintainer.
> 
> The leds name is "devicename:colour:function" where you are allowed to
> leave sections blank. So I only filled in the colour ;)

You can leave sections blank but it pays to leave the separator in so
use ":red:" or ":red", not "red".

> I also notice that it is colour, not color.

;-)

Cheers,

Richard
