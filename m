Return-Path: <gaudenz@debian.org>
Received: from ping.pong.ch (ping.pong.ch [82.197.162.178])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AE6CB687DE
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Nov 2005 09:23:46 +1100 (EST)
Date: Wed, 23 Nov 2005 22:55:37 +0100
From: Gaudenz Steinlin <gaudenz@debian.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <20051123215404.GB3401@soziologie.ch>
References: <1130999620.4680.28.camel@gaston>
	<51ad2e0d0511051358p2fe15f1i7278615996183eb1@mail.gmail.com>
	<1131229041.5229.29.camel@gaston> <43751182.1020009@gmail.com>
	<1131745946.24637.251.camel@gaston>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
In-Reply-To: <1131745946.24637.251.camel@gaston>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
Subject: Re: 2.6.14 USB vs. sleep issues
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Ben

Benjamin Herrenschmidt schrieb:
> The latest patch that is candidate for upstream is:

I have the same USB wakeup problem with my new powerbook 5,8 (oct 2005 
15"). Without the patch I get a kernel oops on wakeup just like the 
others. With this patch applied (and the pb 5,8 basic enablement patch) 
the lcd gets distorted colors on wakeup. It looks quite insane, like a 
broken lcd.

I'm useing a vanilla 2.6.14.2 kernel. CONFIG_USB_SUSPEND is set, PREEMPT
is disabled. Is there a newer version of the patch available for testing?

Gaudenz
