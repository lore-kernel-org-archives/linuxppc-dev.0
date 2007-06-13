Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-11.arcor-online.net (mail-in-11.arcor-online.net
	[151.189.21.51])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 23B89DDD0A
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jun 2007 17:04:04 +1000 (EST)
In-Reply-To: <1181717615.9397.40.camel@localhost.localdomain>
References: <1181717615.9397.40.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <6dc1593b8ff8442f7b4cf7a01f69c07c@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v4]: Fix e500 v2 core reboot bug
Date: Wed, 13 Jun 2007 09:03:37 +0200
To: Zang Roy-r61911 <tie-fei.zang@freescale.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Fix the reset bug on 8548CDS board.

> Segher, do you have any comment?

This one looks fine, only some cosmetics left :-)

> If yes, I will revise again; if No, pick it up!

Well it's not me who picks things up around here...

> +				printk (KERN_EMERG "Error: reset control \
> +					register not mapped, spinning!\n");

...(... "bla bla bla "
	"bla bla bla\n");

instead?  Or there'll be a lot of whitespace in your string.
I don't see anything spinning like the warning says, btw (or
it must be something in abort()?)


Segher
