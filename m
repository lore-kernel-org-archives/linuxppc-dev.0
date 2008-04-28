Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 19694DE105
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Apr 2008 03:59:07 +1000 (EST)
Date: Mon, 28 Apr 2008 13:59:05 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [RESEND][PATCH][POWERPC] PIKA Warp: Update platform code to
	supportRev B boards
Message-ID: <20080428135905.4c037b4b@lappy.seanm.ca>
In-Reply-To: <fa686aa40804281044p5fa0ef9s15107cc38fafc9fa@mail.gmail.com>
References: <20080417152251.2bf07219@lappy.seanm.ca>
	<20080427152546.1e26b145@lappy.seanm.ca>
	<20080428105859.daef4d71.sfr@canb.auug.org.au>
	<fa686aa40804271851t6d762a1et76fa3cc02c2205fe@mail.gmail.com>
	<20080427222514.1086f2d3@lappy.seanm.ca>
	<fa686aa40804272147y54df795fj7e8dad89dc237ecd@mail.gmail.com>
	<20080428131001.052be010@lappy.seanm.ca>
	<fa686aa40804281044p5fa0ef9s15107cc38fafc9fa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, rpurdie@rpsys.net,
	Sean MacLennan <sean.maclennan@ottawa.kanatek.ca>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 28 Apr 2008 11:44:19 -0600
"Grant Likely" <grant.likely@secretlab.ca> wrote:

> This looks appropriate.  You'll need to make sure that the values in
> the linux,name property meet the Linux LED naming guidelines.  I think
> this is covered in Documentation/leds-class.c.  You can also as
> Richard Purdie; the LED subsystem maintainer.

The leds name is "devicename:colour:function" where you are allowed to
leave sections blank. So I only filled in the colour ;)

I also notice that it is colour, not color.

I am hoping that this code is only for 2.6.26 and that we will switch
to the gpio-leds driver for 2.6.27. I don't want to keep supporting yet
another driver outside of the mainline kernel. Let's face it, I'm
lazy :D

Cheers,
   Sean
