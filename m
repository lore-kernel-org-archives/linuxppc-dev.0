Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-12.arcor-online.net (mail-in-12.arcor-online.net
	[151.189.21.52])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E691967BED
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Oct 2006 06:05:53 +1000 (EST)
In-Reply-To: <1160664666.4792.151.camel@localhost.localdomain>
References: <20061012045943.9389.qmail@web52403.mail.yahoo.com>
	<452E1A1D.1050601@genesi-usa.com>
	<1160664666.4792.151.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <1924CA98-A7C7-4FD2-9709-58EC9DD6BEB6@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Handling machine check exception
Date: Thu, 12 Oct 2006 22:05:40 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: ganesh subramonian <gun_raj@yahoo.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> The G2 core definitely has a DAR register (SPR 19).
>>
>> Look on the Freescale site for G2CORERM.pdf - this is
>> your reference manual, not the one specifically for the
>> 8247.
>
> Is DAR set for a machine check ?

Not on these old cores.


Segher
