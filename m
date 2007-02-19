Return-Path: <domen.puncer@telargo.com>
Received: from out002.atlarge.net (out002.atlarge.net [129.41.63.60])
	by ozlabs.org (Postfix) with ESMTP id 0F58CDDDE4
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 19 Feb 2007 22:00:42 +1100 (EST)
Date: Mon, 19 Feb 2007 12:00:36 +0100
From: Domen Puncer <domen.puncer@telargo.com>
To: Sylvain Munaut <tnt@246tNt.com>
Subject: Re: [RFC PATCHES] lite5200b low power mode works
Message-ID: <20070219110036.GN4397@moe.telargo.com>
References: <20061222105404.GC2481@moe.telargo.com>
	<20070123093339.GF4397@moe.telargo.com>
	<20070219072146.GM4397@moe.telargo.com>
	<45D978C9.7050402@246tNt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <45D978C9.7050402@246tNt.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 19/02/07 11:15 +0100, Sylvain Munaut wrote:
> Domen Puncer wrote:
> > On 23/01/07 10:33 +0100, Domen Puncer wrote:
> >   
> >> I'm planning on porting this to Grant/Sylvain's arch/powerpc mpc52xx
> >> tree soon.
> >>     
> >
> > OK... and I've done that (mainline kernel + FEC/bestcomm patches)
> > + some cleanups, fixes.
> >
> > Any of you guys interested in having this in your tree?
> >
> >   
> Sure, feel free to post them.

It seems to be my lucky day. I just figured out what I was doing
wrong with deep-sleep (aplicable to all mpc52xx), so I'll delay this
a few days, and send patches implementing both mpc5200b and lite5200b
"suspend to ram" modes.


	Domen

> 
>     Sylvain
