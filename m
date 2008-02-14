Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 31FF1DDF6E
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Feb 2008 01:28:43 +1100 (EST)
Message-Id: <A3DD9E21-D913-444F-9B7B-2D5C88A9EE5D@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Pavel Kiryukhin <pkiryukhin@ru.mvista.com>
In-Reply-To: <47B40573.1080203@ru.mvista.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH] [POWERPC] Enable correct operation of serial ports with
	nonzero regshift.
Date: Thu, 14 Feb 2008 08:28:39 -0600
References: <47B35ED8.7020404@ru.mvista.com>
	<B8D9D613-441B-4A20-AE2D-D808D4B82F16@kernel.crashing.org>
	<47B40573.1080203@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 14, 2008, at 3:10 AM, Pavel Kiryukhin wrote:

> Kumar Gala wrote:
>>
>> On Feb 13, 2008, at 3:19 PM, Pavel Kiryukhin wrote:
>>
>>> Add regshift reading to serial drivers.
>>> This enables correct operation of serial ports with nonzero  
>>> regshift.
>>
>> what device needs this?
>>
>> - k
>
> Xilinx opb 16550 uart

please add that info to the commit message so we know why this change  
was made.  Other it looks ok to me.

- k
