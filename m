Message-Id: <v01530501b797398fbfcc@[199.170.89.133]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Wed, 8 Aug 2001 13:51:11 -0500
To: Linux PPC Dev <linuxppc-dev@lists.linuxppc.org>
From: trag@io.com (Jeff Walther)
Subject: Re: [off topic] switching cpus
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 12:47 8/8/2001, Mike Fedyk wrote:

>On Wed, Aug 08, 2001 at 12:21:52PM -0500, Jeff Walther wrote:


>> The motherboards in question all have the same part number and range from
>> 75 MHz to 110 MHz, so I have not been able to determine any rhyme or reason
>            ^^^
>One small correction, 7200s go up to 120Mhz.

Yep.  Sorry about that.   I was looking under the heat sink last night and
the CPU markings read 110 MHz, and I guess my fingers grabbed that number
instead of the 120 MHz speed the machine actually runs at.   Although,
truth to tell, I'm not sure if that board was a 120 with a 110 CPU or a 90
with a 110 CPU.  It seems kind of odd that they would put a 110 into a 90,
since they'd have to also change the resistors on the voltage regulator
because the 100+ MHz PPC601s use a lower supply voltage.  On the other
hand, this board didn't have the peltier equipped heat sink, so I don't
think it was a 120, though the heat sink could have been changed before it
reached me.

Jeff Walther


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
