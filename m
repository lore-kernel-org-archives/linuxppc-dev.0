Return-Path: <davem@davemloft.net>
Received: from cheetah.davemloft.net
	(adsl-63-197-226-105.dsl.snfc21.pacbell.net [63.197.226.105])
	by ozlabs.org (Postfix) with ESMTP id DA76F67A7F
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Jan 2005 18:09:43 +1100 (EST)
Date: Tue, 25 Jan 2005 22:42:48 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-Id: <20050125224248.276080b7.davem@davemloft.net>
In-Reply-To: <1106028614.4533.69.camel@gaston>
References: <1106028614.4533.69.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, jgarzik@pobox.com
Subject: Re: [PATCH] sungem update
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 18 Jan 2005 17:10:14 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> This patch updates the sungem driver. I reworked all of the PM stuff, making it
> less prone to races, probably simpler to read as well, and I no longer shut the
> PHY down when the interface is down so that things like laptop-net no longer
> die (the gain in power consumption was minimal, not worth the pain). I also
> implemented basic WOL support.
> 
> There is still something I'm not totally happy with in the locking
> (explained in the comment at the beginning), basically too much locking and a
> couple of places with delays in locks. I will try to improve these later on.
> 
> If you are happy with this, please forward to Linus/Andrew asap

Sorry for taking so long.  I'll try to quick review and sanity
test this on my sparc sungem chips tomorrow Ben.
