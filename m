Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 58FE067AC1
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Jan 2005 00:44:58 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nico Schottelius <nico-linux-ppc@schottelius.org>
In-Reply-To: <20050126113554.GD19633@schottelius.org>
References: <20050118094216.GB25470@Redstar.dorchain.net>
	<20050126113554.GD19633@schottelius.org>
Content-Type: text/plain
Date: Thu, 27 Jan 2005 00:42:26 +1100
Message-Id: <1106746946.6250.56.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH] Heartbeat LED for iBook
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2005-01-26 at 12:35 +0100, Nico Schottelius wrote:
> Hello!
> 
> 
> Joerg Dorchain [Tue, Jan 18, 2005 at 10:42:16AM +0100]:
> > [heartbeat blink patch]
> 
> Well, wouldn't it make much more sense to write a
> /dev/frontled to access it via userspace? 
> 
> Then one could enable much more features like
> - xmms plugins
> - num-lock led
> - network-traffic
> - morse-codes
> - glowing when typing
> - ...

One can always control the led by sending PMU command directly
via /dev/adb :) Ok, that sort-of sucks, especially since the command is
only supported by some versions of the PMU. On the other hand, I dislike
cluttering /dev ... maybe I can find some better mecanism via sysfs...

Ben.
