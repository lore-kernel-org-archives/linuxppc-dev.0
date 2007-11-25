Return-Path: <news@alea.gnuu.de>
Received: from uucp.gnuu.de (banki.eumelnet.de [83.246.114.63])
	by ozlabs.org (Postfix) with ESMTP id 2379ADDE0A
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Nov 2007 00:22:08 +1100 (EST)
Received: from news by alea.gnuu.de with local (Exim 4.63)
	(envelope-from <news@alea.gnuu.de>) id 1IwEm3-0000GZ-Si
	for linuxppc-dev@ozlabs.org; Sun, 25 Nov 2007 11:31:40 +0100
To: linuxppc-dev@ozlabs.org
From: =?UTF-8?Q?J=C3=B6rg?= Sommer <joerg@alea.gnuu.de>
Subject: Re: time accounting problem (powerpc only?)
Date: Sun, 25 Nov 2007 10:31:39 +0000 (UTC)
Message-ID: <slrnfkijob.j2k.joerg@alea.gnuu.de>
References: <1195814816.4149.94.camel@johannes.berg>
	<slrnfkdnma.681.joerg@alea.gnuu.de>
	<1195850245.4149.170.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: news <news@alea.gnuu.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

Johannes Berg <johannes@sipsolutions.net> wrote:
>> % diff /proc/interrupts <(sleep 2; cat /proc/interrupts)
>> --- /proc/interrupts    2007-11-23 15:04:06.004846901 +0100
>> +++ /proc/self/fd/11    2007-11-23 15:04:05.952841422 +0100
>> @@ -1,15 +1,15 @@
>>             CPU0       
>> - 25:   18063968   MPIC 1    Level     VIA-PMU
>> + 25:   18064241   MPIC 1    Level     VIA-PMU
>> - 42:    1415066   MPIC 1    Level     keywest i2c
>> - 47:    2075159   MPIC 1    Level     GPIO1 ADB
>> - 48:    6686659   MPIC 1    Level     radeon@pci:0000:00:10.0
>> + 42:    1415084   MPIC 1    Level     keywest i2c
>> + 47:    2075193   MPIC 1    Level     GPIO1 ADB
>> + 48:    6686778   MPIC 1    Level     radeon@pci:0000:00:10.0
>> 
>> I don't know where they come from, but that's the cause of the high IRQ
>> time.
>
> Are you sure about that?

No, I saw the high hardware interrupt value in top and looked at
/proc/interrupts and concluded that those are the evil source of the
high load.

> I'm fairly sure that I always had rather high numbers of interrupt
> here. And the system isn't sluggish or unresponsive as you'd expect if
> the IRQs actually did take 90% of the CPU time!

Okay, so what might be the source?

Doesn't really nobody else see this values? At least, Elimar
Riesebieter has the same problem. He reported on debian-powerpc.

Bye, Jörg.
-- 
Treffen sich zwei Funktionen.
Sagt die eine: „Verschwinde oder ich differenzier' dich!“
Erwidert die andere: „Ätsch, ich bin exponentiell!“
