Mime-Version: 1.0
Message-Id: <v04220801b54a8085a69d@[10.0.0.42]>
In-Reply-To: <20000518163342.A14744@lambda.u-strasbg.fr>
References: <39226066.BF822A70@mpifr-bonn.mpg.de>
 <Pine.LNX.4.10.10005171253140.16549-100000@opal.biophys.uni-duesseldorf.de
 <20000517140836.A12638@lambda.u-strasbg.fr>
 <v04220800b5492487abdb@[10.0.0.42]>
 <20000518163342.A14744@lambda.u-strasbg.fr>
Date: Thu, 18 May 2000 22:40:19 -0700
To: luther@dpt-info.u-strasbg.fr
From: "Timothy A. Seufert" <tas@mindspring.com>
Subject: Re: Pismo status
Cc: linuxppc-dev@lists.linuxppc.org, debian-powerpc@lists.debian.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 4:33 PM +0200 5/18/00, Sven LUTHER wrote:
>On Wed, May 17, 2000 at 10:15:24PM -0700, Timothy A. Seufert wrote:
>>  The PowerPC 750 (G3) and 7400 (G4) can both fire off an interrupt
>>  when the on-die temperature sensor reading rises above a trigger
>>  value (or falls below a second trigger value).  This feature *could*
>>  be used by an operating system to slow down the CPU (through the
>
>So this mean that the G3 and G4 cpus have both the equivalent of
>speedstep/whatever that AMD & Intel are introducing as a big novelty ?

Sort of.  The method is quite different.  I think AMD and Intel are
actually changing the core clock rate of the processor in response to
system conditions.  The 750 and 7400 can't do that.  Instead, they
can restrict the speed at which instructions can be fetched from the
I-cache into the prefetch queue, which in turn results in lower power
use (and of course lower performance) due to the dynamic power
management features of the 750 and 7400, which save power by
completely halting the clock going to idle functional units.

>>  instruction cache throttling feature) or halt it to prevent
>>  overheating.  However, there is no hardware feature which can halt
>>  the CPU without software control.
>
>Are you sure about this ? did you already manage to burn out a ppc cpu like
>you do when running a pentium without a fan ?

There is no mention of such a thing in the PowerPC 750 manual.

   Tim Seufert

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
