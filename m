Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-11.arcor-online.net (mail-in-11.arcor-online.net
	[151.189.21.51])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C3808DDF75
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 03:44:29 +1100 (EST)
In-Reply-To: <Pine.LNX.4.62.0703210817360.22113@pademelon.sonytel.be>
References: <20070321013810.404636000@samba.org>
	<20070321013825.623943000@samba.org>
	<20070321021456.GB2564@lixom.net>
	<Pine.LNX.4.62.0703210817360.22113@pademelon.sonytel.be>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <63c4469ae1c5af93ffe9c3f374b97fba@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [patch 09/10] Use lowercase for hex printouts in oops messages.
Date: Wed, 21 Mar 2007 17:44:21 +0100
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org, paulus@samba.org,
	anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> Use lowercase for hex printouts in oops messages. The number of 
>>> times I have
>>> tried to copy and paste from an oops into an objdump search...
>>
>> YES! Finally someone bothered to fix this. Thank you!

Bis.

> What about people pasting them into dc? ;-)

So _that's_ how it works in dc!  :-)


Segher
