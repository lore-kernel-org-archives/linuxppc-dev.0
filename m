Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5CEA3DDE17
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Dec 2007 08:56:15 +1100 (EST)
Message-Id: <EBE86B51-C550-47BA-8A71-1F7284E09F0E@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: benh@kernel.crashing.org
In-Reply-To: <1196456356.13230.104.camel@pasglop>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH 2/11] ibm_newemac: Add ET1011c PHY support
Date: Fri, 30 Nov 2007 15:56:09 -0600
References: <1196401223.5661.297518056501.qpush@grosgo>
	<20071130054126.E3EFADDE0C@ozlabs.org>
	<20071130142904.GC3117@lixom.net>
	<1196456356.13230.104.camel@pasglop>
Cc: Olof Johansson <olof@lixom.net>, netdev@vger.kernel.org, jgarzik@pobox.com,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Nov 30, 2007, at 2:59 PM, Benjamin Herrenschmidt wrote:

>
> On Fri, 2007-11-30 at 08:29 -0600, Olof Johansson wrote:
>> Hi,
>>
>> On Fri, Nov 30, 2007 at 04:40:24PM +1100, Benjamin Herrenschmidt  
>> wrote:
>>
>>> This adds support for the Agere ET1011c PHY as found on the AMCC  
>>> Taishan
>>> board.
>>
>> The whole patch has whitespace messed up (tabs vs spaces).
>
> Thanks for noticing it on the ...3rd time those are sent to the  
> list...

Clearly if you used checkpatch.pl you'd have noticed this by now. :)

- k
