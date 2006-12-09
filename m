Return-Path: <clemens.koller@anagramm.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id 2132B67B6F
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Dec 2006 16:37:01 +1100 (EST)
Message-ID: <457A4A40.2060803@anagramm.de>
Date: Sat, 09 Dec 2006 06:31:44 +0100
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Power management for ppc 85xx
References: <BFEE19E1D0DBF84698D76276388DCB843F2251@gbrwgceumf01.eu.xerox.net>
	<5480D0D0-2F38-4BF1-B018-78E25D97F7B6@kernel.crashing.org>
In-Reply-To: <5480D0D0-2F38-4BF1-B018-78E25D97F7B6@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Marta Chamorro <Marta.Chamorro@xerox.com>, linuxppc-embedded@ozlabs.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello, Kumar, Hi, Marta!

>> Glad I managed to make sense. I checked the hardware spec on the board
>> and it looks like we're using everything, apart from the SEC and maybe
>> the stand-alone I2C (I think we're just using the one within the CMP).
>> By the way, I made a mistake and the actual processor on the board is
>> the cut-down 8541, not the 8555. My apologies for that.
>>
>> This morning I added some printks and confirmed that there is no code
>> behind pm_ops, so my question remains: is there some code out there  
>> that
>> I can use? (hope so, otherwise I'm doomed...)
> 
> I'm sorry to say you're doomed.  I don't believe anyone's spent any  
> time trying to do pwr mgmt on 85xx.

I am working with the MPC8540 in a mobile product and some
power saving would be fine to use. But I haven't seen any
power management code for that thingy in the kernels at all.
So, there is some work left there. Maybe I will have
a closer look in the future.

According to some tests of a board manufacturer, the cpu
doesn't power down very much, when you stop some peripherals
or send the core to nap. But I wasn't able to confirm that yet.

Best greets,

Clemens Koller
_______________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Str. 45/1
81379 Muenchen
Germany

http://www.anagramm-technology.com
Phone: +49-89-741518-50
Fax: +49-89-741518-19
