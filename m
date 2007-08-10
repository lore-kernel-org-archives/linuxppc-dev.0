Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.176])
	by ozlabs.org (Postfix) with ESMTP id 42299DDEDA
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 11 Aug 2007 00:28:07 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so1009391wag
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Aug 2007 07:28:06 -0700 (PDT)
Message-ID: <fa686aa40708100728g38efe86er47dff1caad1f57a@mail.gmail.com>
Date: Fri, 10 Aug 2007 08:28:06 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Peter Korsgaard" <peter.korsgaard@barco.com>
Subject: Re: [PATCH] Consolidate XILINX_VIRTEX board support
In-Reply-To: <878x8jx3iq.fsf@sleipner.barco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20070806225642.7D72A7B005B@mail34-fra.bigfish.com>
	<87vebryfrv.fsf@sleipner.barco.com>
	<fa686aa40708091157y3c8c0725kbf25ce8a636d5c27@mail.gmail.com>
	<878x8jx3iq.fsf@sleipner.barco.com>
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

On 8/10/07, Peter Korsgaard <peter.korsgaard@barco.com> wrote:
> >>>>> "GL" == Grant Likely <grant.likely@secretlab.ca> writes:
>
> Hi,
>
> WR> -boot-$(CONFIG_XILINX_ML300)        += embed_config.o
> WR> -boot-$(CONFIG_XILINX_ML403)        += embed_config.o
> WR> +boot-$(CONFIG_XILINX_VIRTEX)       += embed_config.o
> >>
> >> Don't do that. Other boards with Xilinx FPGAs don't necessarily need
> >> embed_config.c
>
> GL> Then post patches for those boards so we can properly support the
> GL> different configuration.
>
> Also if the boards are not generally available? No problem for me, but
> I don't quite see the point.

GregKH likes to tell the story of one architecture that is actively
maintained, but only has about 2 users total.  The point isn't how
available the hardware is; the point is to see how others are using
the code.  Having a larger base of platform support to draw from makes
it easier to recognize patterns in the code which

Or, from a more selfish perspective; It's one thing to say "this
will/won't work because of that platform over there that you can't
see", and quite another to show the code and say "this is what I need
to do".  If you get your code merged, it is easier to influence the
design direction.  ie. you can say "Don't do that; you'll break this
supported board!"  :-)

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
