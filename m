Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 0FA43DDDEE
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Dec 2007 23:14:09 +1100 (EST)
Date: Mon, 24 Dec 2007 15:15:46 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] [POWERPC] MPC8360E-RDK: Device tree and board file
Message-ID: <20071224121546.GA7903@localhost.localdomain>
References: <20071221202309.GA4557@localhost.localdomain>
	<476DD544.2050807@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <476DD544.2050807@freescale.com>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Dec 22, 2007 at 09:25:56PM -0600, Timur Tabi wrote:
> Anton Vorontsov wrote:
> 
> >2. QE SCCs (slow UCCs, used as an UARTs)
> 
> I a posted a driver that provides this support, I'm just waiting for 
> Kumar to apply it.

Yup. I've seen it, thanks. I'm going to test it as well. ;-)

> What revision of the 8360 does this board use?

MPC8360E, Rev: 21. Are you aware of any known issues on this chip
regarding UCC serials?

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
