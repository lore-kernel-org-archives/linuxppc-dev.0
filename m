Return-Path: <jwboyer@gmail.com>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.28])
	by ozlabs.org (Postfix) with ESMTP id E3505DE042
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Apr 2009 22:29:26 +1000 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so79392yxb.39
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Apr 2009 05:29:24 -0700 (PDT)
MIME-Version: 1.0
Sender: jwboyer@gmail.com
In-Reply-To: <f73f7ab80904171732n41832d0hc62978e57bbcc32e@mail.gmail.com>
References: <f73f7ab80904171732n41832d0hc62978e57bbcc32e@mail.gmail.com>
Date: Mon, 20 Apr 2009 08:29:24 -0400
Message-ID: <625fc13d0904200529l152b8d75g33c3f940de1b2920@mail.gmail.com>
Subject: Re: Porting the ibm_newemac driver to use phylib (and other PHY/MAC
	questions)
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Kyle Moffett <kyle@moffetthome.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, netdev <netdev@vger.kernel.org>,
	"Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Apr 17, 2009 at 8:32 PM, Kyle Moffett <kyle@moffetthome.net> wrote:
> Hello,
>
> I'm currently fiddling with a custom embedded prototype board using
> the ibm_newemac driver with some currently-unsupported PHYs. =A0Those
> PHYs *are* supported by phylib, but the emac driver seems to have its
> own PHY layer cribbed from the sungem driver. =A0I'm curious if there's
> some particular reason it hasn't been ported (aside from "nobody has
> bothered yet").

IIRC, Ben had some issues with how phylib and the EMAC would need to
interact.  Not sure if he has those written down somewhere or not.
(CC'd).

> I've temporarily hacked a PHY driver together for the moment, but it
> would be much easier for us to maintain and update our board if the
> PHY drivers were integrated. =A0As a result I'm also interested in how
> complicated it might be to port the driver (and possibly sungem as
> well) over to phylib, if that is indeed feasible. =A0Also, if I end up
> going that route, are there others available with other hardware
> variants who would be willing to test my patches on their boards?

I have a large variety of boards that I can test with since the entire
4xx line relies on this driver for on-board network.

josh
