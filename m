Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-06.arcor-online.net (mail-in-06.arcor-online.net
	[151.189.21.46])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 788D7DDD0A
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jun 2007 16:57:57 +1000 (EST)
In-Reply-To: <1181717035.9397.30.camel@localhost.localdomain>
References: <1180406209.8139.13.camel@localhost.localdomain>
	<1181639293.8953.7.camel@localhost.localdomain>
	<f81c6f149f20c52f547f39ca0cc8d67c@kernel.crashing.org>
	<1181713501.9397.10.camel@localhost.localdomain>
	<1181715851.9397.22.camel@localhost.localdomain>
	<1181717035.9397.30.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <4d678092dfbbed51d8b89bc92259b549@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v3]: Fix e500 v2 core reboot bug
Date: Wed, 13 Jun 2007 08:57:49 +0200
To: Zang Roy-r61911 <tie-fei.zang@freescale.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Fix the reset bug on 8548CDS board.
>>> From MPC8548CDS with e500 v2 core, a new reset control register is
>> added.
> I am also curious who adds the extra symbol ">" before From, the
> mailer(I am using evolution) or else ...

The mailer yes, since "From " at the start of line
would be confused for an SMTP transport header.

Mail clients traditionally use ">" to prevent this; some
mail clients do something different though (a space, for
example).


Segher
