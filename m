Return-Path: <jonsmirl@gmail.com>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.187])
	by ozlabs.org (Postfix) with ESMTP id F0802DDDF7
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 17 Sep 2007 04:38:56 +1000 (EST)
Received: by rv-out-0910.google.com with SMTP id c27so997057rvf
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 16 Sep 2007 11:38:56 -0700 (PDT)
Message-ID: <9e4733910709161138m177edb1k99e5df120e9ca9df@mail.gmail.com>
Date: Sun, 16 Sep 2007 14:38:55 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Robert Schwebel" <r.schwebel@pengutronix.de>
Subject: Re: Domen's MPC5200 FEC cleanup patch.
In-Reply-To: <20070916183446.GX23573@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910709142038y1bd88cd5s7c9bb21a668db9f6@mail.gmail.com>
	<9e4733910709142128l7a264a05ve68f59aee92b40e3@mail.gmail.com>
	<20070915122218.GB19857@nd47.coderock.org>
	<9e4733910709150855k6ba6dc8fye9762817566208b4@mail.gmail.com>
	<9e4733910709161000i64622520i77caa00e56abc7a8@mail.gmail.com>
	<9e4733910709161005u4f400ab7wb1bf55dac1b45193@mail.gmail.com>
	<9e4733910709161100i456c176ay664d89ac638c9958@mail.gmail.com>
	<9e4733910709161125u15dcd02cj300c0e3a7fda4c0a@mail.gmail.com>
	<20070916183446.GX23573@pengutronix.de>
Cc: Domen Puncer <domen.puncer@telargo.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 9/16/07, Robert Schwebel <r.schwebel@pengutronix.de> wrote:
> On Sun, Sep 16, 2007 at 02:25:09PM -0400, Jon Smirl wrote:
> > Next I'll look at how the pcm030 supplies an Ethernet address. It has
> > an EEPROM on the board that holds it. Is this something that can be
> > read from of?
>
> If you use our u-boot port, the mac addresses are being written by
> u-boot and should already be present when linux comes in.

Your right, it is already there.

Any idea why my DNS servers are getting set up from DHCP?

>
> Robert
> --
> Pengutronix - Linux Solutions for Science and Industry
> Entwicklungszentrum Nord     http://www.pengutronix.de
>


-- 
Jon Smirl
jonsmirl@gmail.com
