Return-Path: <evilninja@gmx.net>
Received: from mail.g-house.de (ns1.g-housing.de [62.75.136.201])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F343E67A6C
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Mar 2005 02:45:33 +1100 (EST)
Message-ID: <42287959.8050708@gmx.net>
Date: Fri, 04 Mar 2005 16:06:01 +0100
From: _evil <evilninja@gmx.net>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
References: <20050303124435.GA24233@Redstar.dorchain.net>
	<4227153C.3030201@gmx.net>
	<20050303141832.GU25080@Redstar.dorchain.net>
	<20050304075703.GA15637@Redstar.dorchain.net>
In-Reply-To: <20050304075703.GA15637@Redstar.dorchain.net>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Subject: Re: boot time scheduling hile atomic
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Joerg Dorchain wrote:
>>>
>>>i don't know why you're getting this error, but seeing "swapper" to be
>>>involved here: can you compile with CONFIG_SWAP=n and boot this one?
>>
>>I'll do tonight.
> 
> Did so, no effect on this. IMHO "swapper" is a somewhat misguiding name
> for the idle task with pid 0.

yes, i just guessed. sadly, it did not help :-\
and i can't decode the backtrace either.

does the system halt after the message? if not, we a re not in a hurry 
and if you have time you could possbily track it down a bit to 1) the 
kernelversion when it happened first and/or 2) find the .config option, 
that causes this error.

if the box halts after this, and no guru from linuxppc-dev is available, 
maybe you should try and post on linux-kernel too.

just my 2c,
Christian.
