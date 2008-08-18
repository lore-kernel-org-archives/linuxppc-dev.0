Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CB931DE140
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Aug 2008 08:14:24 +1000 (EST)
Message-ID: <48A9F423.2070602@freescale.com>
Date: Mon, 18 Aug 2008 17:13:55 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Michael Neuling <mikey@neuling.org>
Subject: Re: self-modifying code in 2.6 kernel for ppc writes into readonly
	section
References: <78ef7ce10808180901v6c694e63xefc37dd97485533@mail.gmail.com>	<1586.1219087193@neuling.org>	<78ef7ce10808181257u637c5597xaa992b9e4e7a0925@mail.gmail.com>	<11009.1219092703@neuling.org>	<78ef7ce10808181427m507434f4we84d507b090a707b@mail.gmail.com>
	<18942.1219097397@neuling.org>
In-Reply-To: <18942.1219097397@neuling.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, Mihaela Grigore <grigore.mihaela@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michael Neuling wrote:
>> It seems like no one else is interested in the subject, so i will talk
>> directly to you.
>>
>> If you say that the cpu also seg faults, it means that the problem is
>> in the code of the linux kernel... :)
> 
> Sorry, I was only joking.  The hardware does _not_ segfault.  There is
> no equivalent to segfault in real hardware.

Well, there are machine checks and checkstops... :-)

-Scott
