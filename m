Message-Id: <200008031124.MAA01266@hyperion.valhalla.net>
Date: Thu, 03 Aug 2000 12:24:51 +0100
Subject: Re: rtc again...
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Franz Sirl <Franz.Sirl@munich.netsurf.de>
CC: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  Thu, Aug 3, 2000,  Franz Sirl wrote:
> At 11:00 03.08.00, Martin Costabel wrote:
>>Iain Sandoe wrote:
>> >
>> > Hi,
>> >
>> > under 2.2.17pre15ben1
>> >
>> > rtc does not give me the right answer when built in - what am I doing
>> wrong?
>> >
>> > It won't build load as a module right now 'cos I forgot to check ppc_ksyms
>> > before doing the build :-( .... (I remembered for 2.4.0).
>> >
>> > under 2.4.0-test5 it seems to be fine as a module (haven't tried built in).
>>
>>I am using it as module both for 2.2.17-bk and for 2.4.0-test5. They
>>don't give the same time, and I think it is the one in 2.4.0 that is
>>right. I am at GMT+2:00, and the time in 2.2.17 is 2 hours early. When I
>>change /etc/sysconfig/clock from "UTC=false" to "UTC=true", both times
>>shift by 2 hours, but the discrepancy remains.
>
> Are you sure you are using the "hwclock" utility coming with util-linux?
> And not the old pmac specific "clock" utility to query the clock? What
> happens if you remove all "clock" binaries from your system?

yeah, I checked this.  (although the sbin/clock binary was still there
originally - I removed it).

No change - it's going to take a harder look - later today with luck.

Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
