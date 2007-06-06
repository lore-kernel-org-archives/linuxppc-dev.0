Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-09.arcor-online.net (mail-in-09.arcor-online.net
	[151.189.21.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0CF6EDDE0E
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Jun 2007 23:44:49 +1000 (EST)
In-Reply-To: <200706061501.15853.arnd@arndb.de>
References: <20070531.183033.-1300520557.kouish@swc.toshiba.co.jp>
	<18022.19709.50452.30370@cargo.ozlabs.ibm.com>
	<fe647387a21ec103882e7cf577d0d7d5@kernel.crashing.org>
	<200706061501.15853.arnd@arndb.de>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <f3272d0bef12738b1f45f656f6fda83c@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] of_serial: ignore unknown serial port
Date: Wed, 6 Jun 2007 15:44:39 +0200
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> Is this a bugfix that needs to go in 2.6.22?
>>
>> This potentially breaks lots of other platforms, so no
>> please, put it in early in the next cycle and give those
>> others time to recover from this change.
>
> I would expect that the bugfix is relatively harmless,

Sure, but you cannot prove that without checking all possibly
affected systems' device trees, that's my whole point.  If
you need a fix for .22 you can always put a conditional on
celleb around the offending code.  Anyway, Paul's choice.


Segher
