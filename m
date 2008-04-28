Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id B0C08DDE04
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Apr 2008 12:25:16 +1000 (EST)
Date: Sun, 27 Apr 2008 22:25:14 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [RESEND][PATCH][POWERPC] PIKA Warp: Update platform code to
	supportRev B boards
Message-ID: <20080427222514.1086f2d3@lappy.seanm.ca>
In-Reply-To: <fa686aa40804271851t6d762a1et76fa3cc02c2205fe@mail.gmail.com>
References: <20080417152251.2bf07219@lappy.seanm.ca>
	<20080427152546.1e26b145@lappy.seanm.ca>
	<20080428105859.daef4d71.sfr@canb.auug.org.au>
	<fa686aa40804271851t6d762a1et76fa3cc02c2205fe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 27 Apr 2008 19:51:57 -0600
"Grant Likely" <grant.likely@secretlab.ca> wrote:

> Actually, it looks like he's trying to find the second gpio node in
> the tree.

Correct.

> Sean, if that is true, then this is a very fragile way to do it.
> Really, you should have a phandle somewhere that points to the GPIO
> node that your LEDs are attached to.  Others have been addressing the
> same problem and the consensus seems to be to add a 'leds' node for
> each of your leds with a phandle and gpio descriptor to the gpio node.
> 
> See the documentation added by this patch (section 't'):
> http://patchwork.ozlabs.org/linuxppc/patch?id=18156

I saw that earlier. I thought that that method relied on the gpio_led
driver? I want to use the gpio_led driver, but I believe the underlying
gpio code for the 440EP is not done yet.

If *either* assumption is wrong, let me know! It would be one less
driver (the warp_led driver) that I would have to support outside the
mainline kernel.

I believe, if the platform update gets accepted, that in 2.6.26 the
Warp will be usable with the the mainline kernel. You will just lose
some functionally, such as the SD driver which has already been
rejected.

Cheers,
   Sean
