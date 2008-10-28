Return-Path: <glikely@secretlab.ca>
Message-ID: <fa686aa40810281032y6470d462ya8248e138c432583@mail.gmail.com>
Date: Tue, 28 Oct 2008 11:32:13 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
To: "Matt Sealey" <matt@genesi-usa.com>
Subject: Re: GPIO - marking individual pins (not) available in device tree
In-Reply-To: <4907469B.6030506@genesi-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <7b6eafc46f644dea59fbf0af17dbc005@localhost>
	<fa686aa40810280715m3275a302jd43ab517d2d455fc@mail.gmail.com>
	<4907469B.6030506@genesi-usa.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Konstantinos Margaritis <markos@codex.gr>,
	devicetree-discuss list <devicetree-discuss@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Oct 28, 2008 at 11:06 AM, Matt Sealey <matt@genesi-usa.com> wrote:
> The other problem was defining pins which most definitely ARE
> connected to something (as GPIO) but could well be in an ill-defined
> order or for no defined purpose with regards to the peripheral. A
> lot of GPIO drivers right now (bitbang SPI, I2C) will just allocate
> one pin as one thing and the other as another - if you say pin 15
> and 16 for bitbang-i2c, then it may assumes pin 15 is clock and 16
> is data. For SPI, you get another pin, which order is it (the
> middle one may be correct but the outer ones could be swapped).

Yes, order is important, and yes it should be defined.  That is what
the binding documentation must specify.  It is no different from the
ordering of multiple ranges in the reg property or multiple
interrupts.

> Is this even defined? Shouldn't it be? And therein lies the
> question :)

Yes and yes.  It all hangs off the value of compatible and the
documentation of what the compatible value means.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
