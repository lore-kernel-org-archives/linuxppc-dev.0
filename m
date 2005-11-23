Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DFE83687C7
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Nov 2005 09:12:59 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gaudenz Steinlin <gaudenz@debian.org>
In-Reply-To: <20051123215404.GB3401@soziologie.ch>
References: <1130999620.4680.28.camel@gaston>
	<51ad2e0d0511051358p2fe15f1i7278615996183eb1@mail.gmail.com>
	<1131229041.5229.29.camel@gaston> <43751182.1020009@gmail.com>
	<1131745946.24637.251.camel@gaston>
	<20051123215404.GB3401@soziologie.ch>
Content-Type: text/plain
Date: Thu, 24 Nov 2005 09:09:18 +1100
Message-Id: <1132783759.26560.335.camel@gaston>
Mime-Version: 1.0
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

On Wed, 2005-11-23 at 22:55 +0100, Gaudenz Steinlin wrote:
> Hi Ben
> 
> Benjamin Herrenschmidt schrieb:
> > The latest patch that is candidate for upstream is:
> 
> I have the same USB wakeup problem with my new powerbook 5,8 (oct 2005 
> 15"). Without the patch I get a kernel oops on wakeup just like the 
> others. With this patch applied (and the pb 5,8 basic enablement patch) 
> the lcd gets distorted colors on wakeup. It looks quite insane, like a 
> broken lcd.
> 
> I'm useing a vanilla 2.6.14.2 kernel. CONFIG_USB_SUSPEND is set, PREEMPT
> is disabled. Is there a newer version of the patch available for testing?

The USB patch has nothing to do with your screen problems. Does the
screen issue goes away after a couple of sleep/wakeup cycles ? i'm
waiting on the same machine model that I just ordered from Apple, so
I'll be able to fix remaining issues soon.

Ben.
