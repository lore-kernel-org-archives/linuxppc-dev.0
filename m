Mime-Version: 1.0
Message-Id: <v04220803b54a84458836@[10.0.0.42]>
In-Reply-To: <Pine.SOL.3.95.1000518074410.17922A-100000@dana.ucc.nau.edu>
References: <Pine.SOL.3.95.1000518074410.17922A-100000@dana.ucc.nau.edu>
Date: Thu, 18 May 2000 22:53:09 -0700
To: Tim Wojtulewicz <Tim.Wojtulewicz@NAU.EDU>
From: "Timothy A. Seufert" <tas@mindspring.com>
Subject: Re: Pismo status
Cc: linuxppc-dev@lists.linuxppc.org, debian-powerpc@lists.debian.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 7:48 AM -0700 5/18/00, Tim Wojtulewicz wrote:
>On Wed, 17 May 2000, Timothy A. Seufert wrote:
>
>>
>>  No, it will not.
>>
>>  The PowerPC 750 (G3) and 7400 (G4) can both fire off an interrupt
>>  when the on-die temperature sensor reading rises above a trigger
>>  value (or falls below a second trigger value).  This feature *could*
>>  be used by an operating system to slow down the CPU (through the
>>  instruction cache throttling feature) or halt it to prevent
>>  overheating.  However, there is no hardware feature which can halt
>>  the CPU without software control.
>>
>
>So in other words, without a little bit of help from the OS, the fan won't
>come on when it the temperature hits this trigger value.  The temperature
>would of course, continue to rise.

This die temperature sensor has nothing to do with the PowerBook's
fan.  It's built into all PPC 750 and 7400 CPUs.

Apple could use the die sensor to control the fan, but instead they
use a sensor on the motherboard of the PowerBook, as the fan is
really intended to ensure that the ambient temperature inside the
whole PowerBook doesn't get too hot.  This because there are actually
things which are much more sensitive to overheating than the CPU,
like the hard drive.

>Has any code been written for LinuxPPC that will let us monitor this
>sensor?  I know there's a whole lm_sensors package for i386 and the like,
>but is there something like this for us?

For some PowerBooks / PMU versions, I think so.  We will probably get
full support for things like this when Apple puts it into Darwin/OS X.

>Yes, I had heard they upgraded the PMU, but I wasn't aware of how much
>they had changed it.  Is it just a matter of knowing some extra bits we
>can switch on and off in the PMU, or is it more than that?

Probably more than that, but I don't know anything beyond the basic
fact that the PMU (both the hardware and its control program) got the
first major upgrade in years.

   Tim Seufert

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
