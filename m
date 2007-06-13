Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-07.arcor-online.net (mail-in-07.arcor-online.net
	[151.189.21.47])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 120D1DDE17
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jun 2007 17:54:51 +1000 (EST)
In-Reply-To: <1181720633.12936.19.camel@localhost.localdomain>
References: <1181717615.9397.40.camel@localhost.localdomain>
	<6dc1593b8ff8442f7b4cf7a01f69c07c@kernel.crashing.org>
	<1181718898.12936.6.camel@localhost.localdomain>
	<cad6a9b0bd58df6298cb5f8402e512e7@kernel.crashing.org>
	<1181720633.12936.19.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <26a24ad5f123db79f880f8c53cf2c71f@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v4]: Fix e500 v2 core reboot bug
Date: Wed, 13 Jun 2007 09:54:43 +0200
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

>> There is no real reason to break the string in two anyway, it
>> is fine to have a more-than-80-char line in printk messages.
>>
> I separate it, because I am afraid I will be  challenged by 80 char
> column rule.

Yeah, I understand.

> Please check the CodeStyle file and its example:

[snip]

> If it does not matter, I'd like to put them in one line :-).

Current thinking on this seems to be that long literal strings
are fine.  You are right that some people might challenge you
on this, of course ;-)


Segher
