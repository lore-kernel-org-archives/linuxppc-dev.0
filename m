Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 5B4FA2C030A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 May 2013 08:59:55 +1000 (EST)
Message-ID: <1369691284.3557.34.camel@pasglop>
Subject: Re: [PATCH 1/2] ARM: kirkwood: proper retain MAC address workaround
 on DT ethernet
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Miller <davem@davemloft.net>
Date: Tue, 28 May 2013 07:48:04 +1000
In-Reply-To: <20130527.131857.945196320286011406.davem@davemloft.net>
References: <1369647565.3557.28.camel@pasglop> <51A33447.80305@gmail.com>
 <1369655404.3557.33.camel@pasglop>
 <20130527.131857.945196320286011406.davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: andrew@lunn.ch, jason@lakedaemon.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, buytenh@wantstofly.org, grant.likely@linaro.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 sebastian.hesselbarth@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-05-27 at 13:18 -0700, David Miller wrote:
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Date: Mon, 27 May 2013 21:50:04 +1000
> 
> > It would be handy to be able to just do something like
> > 
> >       of_set_property(node, name, ptr, len);
> > 
> > However, that wouldn't help much with the allocation/leak problem,
> > though at least it would be easier to use. It could also *try* to re-use
> > the current allocation if the new content is of smaller or equal size.
> 
> And this is so much better of an interface because it allows the
> OF implementation to decide how to deal with memory allocation
> and freeing.

Absolutely, I'm not arguing that point.

Cheers,
Ben.
