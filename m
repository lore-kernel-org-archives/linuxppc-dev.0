Return-Path: <steven.scholz@imc-berlin.de>
Received: from mail.imc-berlin.de (mail.imc-berlin.de [217.110.46.186])
	by ozlabs.org (Postfix) with ESMTP id 7FD67679FD
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 22 May 2006 21:03:57 +1000 (EST)
Received: from mailserver.berlin.imc-berlin.de
	(mailserver.berlin.imc-berlin.de [10.0.0.19])
	by mail.imc-berlin.de (Postfix) with ESMTP id 3099A2F022
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 22 May 2006 13:03:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mailserver.berlin.imc-berlin.de (Postfix) with ESMTP id 24BFB1E20E1
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 22 May 2006 13:03:53 +0200 (CEST)
Received: from [10.0.2.10] (scholz.berlin.imc-berlin.de [10.0.2.10])
	by mailserver.berlin.imc-berlin.de (Postfix) with ESMTP id 4CC071E2027
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 22 May 2006 13:03:52 +0200 (CEST)
Message-ID: <44719A96.2020309@imc-berlin.de>
Date: Mon, 22 May 2006 13:03:50 +0200
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Re: MPC8xx: resolution of gettimeofday() ?
References: <446C8E70.3040601@imc-berlin.de>
	<20060518164812.GA21075@gate.ebshome.net>
	<446D7CFA.5060505@imc-berlin.de>
	<20060519175513.GA12121@gate.ebshome.net>
In-Reply-To: <20060519175513.GA12121@gate.ebshome.net>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Eugene,

>>> Usually on PPC we use timebase to interpolate time between Decrementer 
>>> interrupts. In this case gettimeofday resolution is determined by 
>>> timebase resolution which is quite high (megahertz range).
>> Sorry. I don't understand. What do you mean with "timebase"? Is there a
>> second timer/counter?
> 
> PowerPC has a facility called timebase. This is 64-bit counter which 
> can be accessed using special instructions (mftb, mftbu on 32-bit PPC).
> Counter resolution depends on particular chip implementation, some 
> use core clock, other use bus clock...
> 
> It's similar to the time-stamp counter in Intel CPUs (accessed 
> with rdtsc instruction).
Thanks very much for clearing this!

> Please, refer to PPC arch manuals for more information. Also, if you 
> really interested in how gettimeofday() is implemented, why don't you 
> look at the source code yourself?
I tried. But it's not obvious. Not for me anyway.

-- 
Steven
