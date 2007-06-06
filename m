Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net
	[151.189.21.42])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 26381DDE04
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Jun 2007 19:09:53 +1000 (EST)
In-Reply-To: <18022.19709.50452.30370@cargo.ozlabs.ibm.com>
References: <20070531.183033.-1300520557.kouish@swc.toshiba.co.jp>
	<18022.19709.50452.30370@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <fe647387a21ec103882e7cf577d0d7d5@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] of_serial: ignore unknown serial port
Date: Wed, 6 Jun 2007 11:09:39 +0200
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org, arnd@arndb.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Current of_serial driver assumes unknown serial port to be 8250. But
>> this behavior may cause fatal problems when the serial port is not
>> 8250. This patch corrects probe routine to ignore unknown serial port.
>>
>> Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>
> Is this a bugfix that needs to go in 2.6.22?

This potentially breaks lots of other platforms, so no
please, put it in early in the next cycle and give those
others time to recover from this change.


Segher
