Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D4790DDEC7
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Apr 2007 06:12:13 +1000 (EST)
In-Reply-To: <8746466a0704121254h205a8247u39587560991f07a4@mail.gmail.com>
References: <8746466a0704121254h205a8247u39587560991f07a4@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <1A484369-13F5-49A0-8BFF-3DC290316BEF@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: booke_wdt being a kernel module
Date: Fri, 13 Apr 2007 15:12:42 -0500
To: Dave <dave.jiang@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 12, 2007, at 2:54 PM, Dave wrote:

> Does it make sense for the booke_wdt driver to be a kernel module?
> Since the watchdog cannot be stopped, unloading the module after the
> watchdog has started basically garantees a reboot.... Should
> CONFIG_BOOKE_WDT be changed to a bool from tristate?

I don't see any value in making the booke_wdt driver a module.

- k
