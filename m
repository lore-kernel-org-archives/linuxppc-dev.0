Message-Id: <200008030742.IAA26688@hyperion.valhalla.net>
Date: Thu, 03 Aug 2000 08:42:25 +0100
Subject: Re: Updated DMASOUND patches
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: "Michel Dänzer" <daenzerm@student.ethz.ch>
CC: linuxppc-dev@lists.linuxppc.org, Benjamin Herrenschmidt <bh40@calva.net>
Mime-version: 1.0
Content-type: text/plain; charset="ISO-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


 Thu, Aug 3, 2000,  Michel Dänzer wrote:
> Iain Sandoe wrote:
>
>> 2.4.0-test5
>>
>> This is much more flaky **with identical code**  there is no crashing (yet)
>> - but a strong tendency for almost any activity to cut off the sound.
>> opening the mixer control is a really good way of doing it.  Once the panel
>> is open you can restart the sound and all is hunky-dory... but...
>
> I've noticed that 2.4.0-test4 is much more sluggish than any 2.2 kernel I've
> used. Turning on DMA for the HD (yep, didn't do it automatically) helps a bit,
> but not totally.

According to DMESG DMA *is* on for both SCSI & IDE (IDE doesn't enter into
this really for me - all my disks are SCSI).  How could I tell if dmesg were
telling fibs?

>> I guess I'm a little suspicious of the new wait-queue stuff (that's really
>> the only major change to the sound side).
>
> There's a whole new kernel around the sound driver ;)

Fair point... I guess we do interact with the fs stuff, and IRQs and...
and... :-)

Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
